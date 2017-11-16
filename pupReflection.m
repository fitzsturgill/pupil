function pupReflection(op)
    %% NOT Working!
    global state
    
    switch op
        case 'select'
           h  = impoly(state.pupil.rawFrameAx);
           state.pupil.reflectionPolyHandle = h;
           state.pupil.reflectionPolyMask = h.createMask;
           set(h, 'Visible', 'off');
        case 'process'
            thisMask = state.pupil.reflectionPolyMask & state.pupil.rawFrameData > 200;
            state.pupil.rawFrameData = regionfill(state.pupil.rawFrameData,thisMask);
    end
           