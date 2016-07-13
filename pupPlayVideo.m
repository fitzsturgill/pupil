function pupPlayVideo
    global state
    
    for counter = 1:state.pupil.skipFrames:state.pupil.nFrames
        state.pupil.currentFrame = counter;
        updateGUIByGlobal('state.pupil.currentFrame');
        pupProcessFrame;
        pupUpdateFrameFigure;
        drawnow;
    end