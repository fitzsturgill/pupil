function pupAutoSelectPupilRegion
    global state
    
    minFrame = min(state.pupil.vidData(:,:,frame);


if isempty(regionMask)
            pupilMaskRaw = eyeMaskFrame < state.pupil.pupThresh;
        else
            pupilMaskRaw = eyeMaskFrame < state.pupil.pupThresh & regionMask;
        end
        
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
            'SubarrayIdx'...
            );