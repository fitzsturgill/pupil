function pupAutoSelectPupilRegion(op)
    global state
    
    switch op
        case 'select'
            connectivity = 8;
            closeDiameter = 6; % default 8

            % compute minimum of image to reveal area possibly covered by pupil at
            % any given time
            minFrame = min(state.pupil.vidData, [], 3);

            regionMaskRaw = minFrame < state.pupil.pupThresh & state.pupil.pupilRegionMask;



            se = strel('disk',closeDiameter); % morphologically close using circular structuring element
            regionMaskRaw = imclose(regionMaskRaw, se);
            regionMaskComps = bwconncomp(regionMaskRaw, connectivity);
            numPixels = cellfun(@numel, regionMaskComps.PixelIdxList);
            [biggest,idx] = max(numPixels); % find the biggest region    
            % for speed: rewrite pupilMaskComps (CC structure returned by bwconncomp) to isolate only the biggest component
            regionMaskComps.NumObjects=1;
            regionMaskComps.PixelIdxList=regionMaskComps.PixelIdxList(idx);
            stats = regionprops(regionMaskComps,...
                'ConvexArea',...
                'BoundingBox',...
                'Centroid',...
                'ConvexImage',...
                'SubarrayIdx',...
                'ConvexHull'...
                );

            state.pupil.pupilAutoRegionMask  = zeros(state.pupil.frameSize);
            state.pupil.pupilAutoRegionMask(stats.SubarrayIdx{:}) = stats.ConvexImage;
            if ishandle(state.pupil.pupilAutoRegionHandle)
                state.pupil.pupilAutoRegionHandle.delete;
            end
            state.pupil.pupilAutoRegionHandle = line(state.pupil.rawFrameAx, stats.ConvexHull(:,1), stats.ConvexHull(:,2), 'Color', 'y', 'LineWidth', 1);
            % plot it
            ensureFigure('autoPupilRegion', 1); imshow(minFrame, [0 256]);
            line(stats.ConvexHull(:,1), stats.ConvexHull(:,2), 'Color', 'y', 'LineWidth', 1);
        case 'getRegion'
            if ~isscalar(state.pupil.pupilAutoRegionMask)
                regionMask = state.pupil.pupilAutoRegionMask(state.pupil.eye.SubarrayIdx{:});
            else
                regionMask = state.pupil.pupilAutoRegionMask; % scalar value of 1
            end            
        case 'reset'
            state.pupil.pupilAutoRegionMask = 1;
            if ishandle(state.pupil.pupilAutoRegionHandle)
                state.pupil.pupilAutoRegionHandle.delete;
            end
    end