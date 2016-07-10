function pupProcessFrame(frame)
    global state
    
    if nargin < 1
        frame = state.pupil.currentFrame;
    end
    
    success = 0;
    connectivity = 8;  % default connectivity for identifiying connected components
    closeDiameter = 8;

    rawFrame = state.pupil.vidData(:,:,frame);
    state.pupil.rawFrameData = rawFrame;
        %%
    
        % apply eyelid threshold
    success = 1;
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
            'Area',...
            'Centroid',...
            'BoundingBox',...
            'MinorAxisLength',...
            'MajorAxisLength',...
            'Image',...
            'SubarrayIdx',...
            'PixelIdxList'...            
            );
%         offsets = floor(stats.BoundingBox);
%         eyeMaskComp = stats.ConvexImage;
%         eyeMaskFrame = stats.ConvexImage .* rawFrame(stats.SubarrayIdx{:});
        eyeMaskComp = stats.Image;
        eyeMaskFrame = stats.Image .* rawFrame(stats.SubarrayIdx{:});
        eyeMaskFrame(~stats.Image) = 255; % set exterior = 255 to make subsequent thresholding simpler
        state.pupil.eye.mask = eyeMaskComp;
        state.pupil.eye.frame = eyeMaskFrame;
        state.pupil.eye.area = stats.Area;
        state.pupil.eye.box = stats.BoundingBox;
        state.pupil.eye.avg = mean(rawFrame(stats.SubarrayIdx{:}));
        state.pupil.eye.minorAxisLength = stats.MinorAxisLength;
        state.pupil.eye.majorAxisLength = stats.MajorAxisLength;        
        state.pupil.eye.centroid = stats.Centroid;
        
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
    end

        
    % if eye found, then find pupil
  
    try
        % throw error if eye wasn't found
        if ~success
            error('Error in pupProcesFrame: Eye Not Found');
        end
        
        pupilMaskRaw = eyeMaskFrame < state.pupil.pupThresh;
        se = strel('disk',closeDiameter); % morphologically close using circular structuring element
        pupilMaskRaw = imclose(pupilMaskRaw, se);
        pupilMaskComps = bwconncomp(pupilMaskRaw, connectivity);
        numPixels = cellfun(@numel, pupilMaskComps.PixelIdxList);
        [biggest,idx] = max(numPixels); % find the biggest region    
        % for speed: rewrite pupilMaskComps (CC structure returned by bwconncomp) to isolate only the biggest component
        pupilMaskComps.NumObjects=1;
        pupilMaskComps.PixelIdxList=pupilMaskComps.PixelIdxList(idx);
        stats = regionprops(pupilMaskComps,...
            'Area',...
            'BoundingBox',...
            'Centroid',...
            'Image',...
            'SubarrayIdx',...
            'PixelIdxList',...
            'EquivDiameter'...
            );
        pupilMaskFrame = stats.Image .* eyeMaskFrame(stats.SubarrayIdx{:});
        pupilMaskFrame(~stats.Image) = 255;
        state.pupil.pupil.diameter=stats.EquivDiameter;
        state.pupil.pupil.mask = stats.Image;
        state.pupil.pupil.frame = pupilMaskFrame;
        state.pupil.pupil.area = stats.Area;
        state.pupil.pupil.box = stats.BoundingBox;
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
        if ~success
            error('Error in pupProcesFrame: Pupil Not Found');
        end
        perim = bwperim(stats.Image); % perimeter of pupil object
        [i, j] = find(perim); % row and column indices
        [c, r, residual] = fitcircle([i j]);


        state.pupil.pupil.circCenter = c'; % transpose
        state.pupil.pupil.circRadius = r;
        state.pupil.pupil.circResidual = residual;
        state.pupil.pupil.diameter = r * 2;
    catch
        disp('Error in pupProcessFrame: Circle Not Found');
        state.pupil.pupil.circCenter = [NaN NaN]; % transpose
        state.pupil.pupil.circRadius = NaN;
        state.pupil.pupil.circResidual = NaN;
        state.pupil.pupil.diameter = NaN;
    end

        


    