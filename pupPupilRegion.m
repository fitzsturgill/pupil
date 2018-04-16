function varargout = pupPupilRegion(op)
    global state
    
    switch op
        case 'select'
           delete(state.pupil.pupilRegionHandle);
           h  = imfreehand(state.pupil.rawFrameAx);
           state.pupil.pupilRegionHandle = h;
           state.pupil.pupilRegionMask = h.createMask;
           set(h, 'Visible', 'on');
        case 'getRegion'
            if ~isscalar(state.pupil.pupilRegionMask)
                regionMask = state.pupil.pupilRegionMask(state.pupil.eye.SubarrayIdx{:});
            else
                regionMask = state.pupil.pupilRegionMask; % scalar value of 1
            end
        case 'reset'
           if ishandle(state.pupil.pupilRegionHandle)
               state.pupil.pupilRegionHandle.delete            
           end          
           state.pupil.pupilRegionMask = 1; % set to scalar 1
    end
    if nargout == 1
        varargout{1} = regionMask;
    end
           