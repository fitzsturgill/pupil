function varargout = pupPupilRegion(op)
    global state
    
    switch op
        case 'select'
           delete(state.pupil.pupilRegionHandle);
           h  = imfreehand(state.pupil.rawFrameAx);
           state.pupil.pupilRegionHandle = h;
           state.pupil.pupilRegionMask = h.createMask;
           set(h, 'Visible', 'off');
        case 'getRegion'
            if ~isempty(state.pupil.pupilRegionMask)
                regionMask = state.pupil.pupilRegionMask(state.pupil.eye.SubarrayIdx{:});
            else
                regionMask = [];
            end
    end
    if nargout == 1
        varargout{1} = regionMask;
    end
           