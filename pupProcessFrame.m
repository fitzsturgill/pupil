function pupProcessFrame(frame)
    global state
    
    if nargin < 1
        frame = state.pupil.currentFrame;
    end
    
    success = 0;
    connectivity = 8;  % default connectivity for identifiying connected components
    closeDiameter = 6; % default 8
    filterSigma = 1;
    
    pupilMax = 100;

    rawFrame = state.pupil.vidData(:,:,frame);

    
    %% try filtering
    if filterSigma
        rawFrame = imgaussfilt(rawFrame, filterSigma);
    end
    
    state.pupil.rawFrameData = rawFrame;
    
        % apply eyelid threshold
    success = 1;
    state.pupil.frameAvg = mean2(rawFrame);
    try
        eyeMaskRaw = rawFrame < state.pupil.lidThresh;
        se = strel('disk',closeDiameter); % morphologically close
        eyeMaskRaw = imclose(eyeMaskRaw, se);
        eyeMaskComps = bwconncomp(eyeMaskRaw, connectivity);
        numPixels = cellfun(@numel, eyeMaskComps.PixelIdxList);
        [biggest,idx] = max(numPixels); % find the biggest region    
        % for speed: rewrite eyeMaskComps (CC structure returned by bwconncomp) to isolate only the biggest component
        eyeMaskComps.NumObjects=1;
        eyeMaskComps.PixelIdxList=eyeMaskComps.PixelIdxList(idx);
        stats = regionprops(eyeMaskComps,...
            'ConvexArea',...
            'Centroid',...  % not of filled region
            'BoundingBox',...
            'MinorAxisLength',...  
            'MajorAxisLength',...
            'ConvexImage',...
            'SubarrayIdx'...        
            );
%         offsets = floor(stats.BoundingBox);
%         eyeMaskComp = stats.ConvexImage;
%         eyeMaskFrame = stats.ConvexImage .* rawFrame(stats.SubarrayIdx{:});
        eyeMaskComp = stats.ConvexImage;
        eyeMaskFrame = stats.ConvexImage .* rawFrame(stats.SubarrayIdx{:}); % see documentation for regionprops
        displayFrame = eyeMaskFrame;
        eyeMaskFrame(~stats.ConvexImage) = 255; % set exterior = 255 to make subsequent thresholding simpler       
        displayFrame(~stats.ConvexImage) = -1; % to show difference between mask and saturated pixels within eye (assuming that data will have few true 0 pixels)    
        state.pupil.eye.mask = eyeMaskComp;
        state.pupil.eye.frame = displayFrame;
        state.pupil.eye.area = stats.ConvexArea;
        state.pupil.eye.box = stats.BoundingBox;
        state.pupil.eye.SubarrayIdx = stats.SubarrayIdx;
        state.pupil.eye.avg = mean(eyeMaskFrame(stats.ConvexImage));
        state.pupil.eye.minorAxisLength = stats.MinorAxisLength;
        state.pupil.eye.majorAxisLength = stats.MajorAxisLength;        
        state.pupil.eye.centroid = stats.Centroid;
        state.pupil.eye.blinkDetected = stats.ConvexArea < state.pupil.blinkArea;
        
    catch
        success = 0;
        state.pupil.eye.mask = NaN;
        state.pupil.eye.frame = NaN;
        state.pupil.eye.area = NaN;
        state.pupil.eye.box = zeros(1,4);
        state.pupil.eye.avg = NaN;
        state.pupil.eye.minorAxisLength = NaN;
        state.pupil.eye.majorAxisLength = NaN;        
        state.pupil.eye.centroid = NaN(1,2);
        state.pupil.eye.blinkDetected=NaN;
    end

        
    % if eye found, then find pupil
  
    try
        % throw error if eye wasn't found
%         if ~success
%             error('Error in pupProcessFrame: Eye Not Found');
%         end
        if state.pupil.eye.blinkDetected % if blinking, don't calculate pupil stats
            success=0;
        end
        assert(success > 0);
        
        % restrict search for pupil in user defined region
        regionMask = pupPupilRegion('getRegion');
        pupilMaskRaw = eyeMaskFrame < state.pupil.pupThresh & regionMask;
%         if isempty(regionMask)
%             pupilMaskRaw = eyeMaskFrame < state.pupil.pupThresh;
%         else
%             pupilMaskRaw = eyeMaskFrame < state.pupil.pupThresh & regionMask;
%         ends
        
        se = strel('disk',closeDiameter); % morphologically close using circular structuring element
        pupilMaskRaw = imclose(pupilMaskRaw, se);
        pupilMaskComps = bwconncomp(pupilMaskRaw, connectivity);
        numPixels = cellfun(@numel, pupilMaskComps.PixelIdxList);
        [biggest,idx] = max(numPixels); % find the biggest region    
        % for speed: rewrite pupilMaskComps (CC structure returned by bwconncomp) to isolate only the biggest component
        pupilMaskComps.NumObjects=1;
        pupilMaskComps.PixelIdxList=pupilMaskComps.PixelIdxList(idx);
        stats = regionprops(pupilMaskComps,...
            'ConvexArea',...
            'BoundingBox',...
            'Centroid',...
            'ConvexImage',...
            'SubarrayIdx',...
            'PixelList'...
            );
        pupilMaskFrame = stats.ConvexImage .* eyeMaskFrame(stats.SubarrayIdx{:});
        pupilMaskFrame(~stats.ConvexImage) = 255;
%         pupilMaskFrame = stats.ConvexImage * 255;
        state.pupil.pupil.diameter=2 * sqrt(stats.ConvexArea/pi);
        state.pupil.pupil.mask = stats.ConvexImage;
        state.pupil.pupil.frame = pupilMaskFrame;
        state.pupil.pupil.area = stats.ConvexArea;
        state.pupil.pupil.box = stats.BoundingBox;
        state.pupil.pupil.SubarrayIdx = stats.SubarrayIdx;        
        state.pupil.pupil.centroid = stats.Centroid;
    catch
        state.pupil.pupil.diameter = NaN;
        state.pupil.pupil.mask = NaN;
        state.pupil.pupil.frame = NaN;
        state.pupil.pupil.area = NaN;
        state.pupil.pupil.box = zeros(1,4);
        state.pupil.pupil.centroid = NaN(1,2);
        success=0;
    end

%         find circle
    try
%         if ~success
%             error('Warning in pupProcesFrame: Pupil Not Found');
%         end
        assert(success > 0);
        perim = bwperim(stats.ConvexImage); % perimeter of pupil object
        [i, j] = find(perim); % row and column indices
        [c, r, residual] = fitcircle([i j]);
        % testing- try min enclosing circle
        [r2, c2] = ApproxMinBoundSphereND(stats.PixelList);
        c2 = c2 - stats.BoundingBox(1:2);
        if (r * 2) > pupilMax
            state.pupil.pupil.circCenter = [NaN NaN]; % transpose
            state.pupil.pupil.circRadius = NaN;
            state.pupil.pupil.circResidual = NaN;
            state.pupil.pupil.diameter = NaN;
        else        
            state.pupil.pupil.circCenter = c'; % transpose
            state.pupil.pupil.circRadius = r;
            state.pupil.pupil.circResidual = residual;
            state.pupil.pupil.diameter = r * 2;
            state.pupil.pupil.circCenter2 = c2'; % transpose
            state.pupil.pupil.circRadius2 = r2;
            state.pupil.pupil.diameter2 = r2 * 2;            
        end
        

    catch
        state.pupil.pupil.circCenter = [NaN NaN]; % transpose
        state.pupil.pupil.circRadius = NaN;
        state.pupil.pupil.circResidual = NaN;
        state.pupil.pupil.diameter = NaN;
    end

        


    