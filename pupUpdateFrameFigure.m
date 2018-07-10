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

    % draw fitted circle
    r = state.pupil.pupil.circRadius;
    c = state.pupil.pupil.circCenter;
    theta = 0:pi/50:2*pi;
    xcoords = r * cos(theta) + c(1);
    ycoords = r * sin(theta) + c(2);
    set(state.pupil.pupCircleHandle, 'XData', xcoords, 'YData', ycoords);
    
    % same for minimum enclosing circle
    r = state.pupil.pupil.circRadius2;
    c = state.pupil.pupil.circCenter2;
    theta = 0:pi/50:2*pi;
    xcoords = r * cos(theta) + c(1);
    ycoords = r * sin(theta) + c(2);
    set(state.pupil.pupCircleHandle2, 'XData', xcoords, 'YData', ycoords);
    
    % convolution
%     r = round(state.pupil.kernelDiameter/2);
%     [xx,yy] = meshgrid(-r:r);
%     nhood = xx.^2 + yy.^2 <= r^2;
%     nhood = nhood / sum(sum(nhood));
%     state.pupil.convFrameData = conv2(state.pupil.rawFrameData, nhood);
%     set(state.pupil.convFrameImageHandle, 'CData', state.pupil.convFrameData);
%     set(state.pupil.convFrameAx, 'YLim', [0 size(state.pupil.convFrameData, 1)], 'XLim', [0 size(state.pupil.convFrameData, 2)]);
    
%     ensureFigure('test_subtract', 1);
%     imagesc(state.pupil.rawFrameData - testVar.meanFrame);
  
    drawnow;