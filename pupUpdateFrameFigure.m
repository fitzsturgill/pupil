function pupUpdateFrameFigure
    global state
    
    set(state.pupil.rawFrameImageHandle, 'CData', state.pupil.rawFrameData);
    set(state.pupil.eyeFrameImageHandle, 'CData', state.pupil.eye.frame);
    set(state.pupil.pupFrameImageHandle, 'CData', state.pupil.pupil.frame);
    
    set(state.pupil.rawFrameAx, 'YLim', [0 size(state.pupil.rawFrameData, 1)], 'XLim', [0 size(state.pupil.rawFrameData, 2)]);
    set(state.pupil.eyeFrameAx, 'YLim', [0 size(state.pupil.eye.frame, 1)], 'XLim', [0 size(state.pupil.eye.frame, 2)]);
    set(state.pupil.pupFrameAx, 'YLim', [0 size(state.pupil.pupil.frame, 1)], 'XLim', [0 size(state.pupil.pupil.frame, 2)]);    
%     set(state.pupil.eyeFrameAx, 'CData', state.pupil.eye.frame);
%     set(state.pupil.pupFrame, 'CData', state.pupil.pupil.frame);
    
    set(state.pupil.eyeBoxHandle, 'Position', state.pupil.eye.box);
    set(state.pupil.pupBoxHandle, 'Position', state.pupil.pupil.box); 

    r = state.pupil.pupil.circRadius;
    c = state.pupil.pupil.circCenter;
    theta = 0:pi/50:2*pi;
    xcoords = r * cos(theta) + c(1);
    ycoords = r * sin(theta) + c(2);
    set(state.pupil.pupCircleHandle, 'XData', xcoords, 'YData', ycoords);
    
    drawnow;