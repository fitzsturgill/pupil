%% pupil_dev_script2

rawFrame = state.pupil.vidData(:,:,state.pupil.currentFrame);

%
    r = round(state.pupil.pupil.diameter/2);
    [xx,yy] = meshgrid(-r:r);
    nhood = xx.^2 + yy.^2 <= r^2;
    nhood = nhood / sum(sum(nhood));

    
    rawFrame_conv = conv2(rawFrame, nhood);
%     figure; surf(xx, yy, double(nhood));

ensureFigure('test', 1); subplot(1,2,1); imshow(rawFrame, [0 256]);
subplot(1,2,2); imshow(rawFrame_conv, [min(min(rawFrame_conv)) max(max(rawFrame_conv))]);

%% try matt's function
convFrame = state.pupil.convFrameData;
convFrame = 256 - convFrame; % invert image

[center, radius] = detectWidefieldWindow(convFrame, 1);
