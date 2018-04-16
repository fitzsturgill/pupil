function pupPlayVideo
    global state
    
    for counter = 1:state.pupil.skipFrames:state.pupil.nFrames
        if state.pupil.stopPlayback
            state.pupil.stopPlayback = 0;
            return
        end
        state.pupil.currentFrame = counter;
        updateGUIByGlobal('state.pupil.currentFrame');
        pupProcessFrame;
        pupUpdateFrameFigure;
        drawnow;
        
    end
    
    
%     ensureFigure('testAverages_fig', 1);
%     subplot(2,2,1); imagesc(maxFrame(:,:,1)); title('max');
%     subplot(2,2,2); imagesc(meanFrame(:,:,1)); title('mean');
%     subplot(2,2,3); imagesc(minFrame(:,:,1)); title('min');
%     
%     
%     set(gcf, 'ColorMap', makeColorMap('graySat',9));
%    
% 
%     if testVar.getMean
%         testVar.meanFrame = meanFrame(:,:,1);
%         testVar.getMean = 0;
%     end
end
% function map = makeColorMap(color, bits)
% 	
% 	a = zeros(2^bits,1);
% 	b = (0:1/(2^bits -1):1)';
% % 	a = zeros(2^bits + 2,1);
% % 	b = (0:1/(2^bits +1):1)';
% 	
% 	switch color 
% 	case 'red'
% 		map = squeeze(cat(3, b, a, a));
% 	case 'green'
% 		map = squeeze(cat(3, a, b, a));
% 	case 'blue'
% 		map = squeeze(cat(3, a, a, b));
% 	case 'graySat'
% 		map = squeeze(cat(3, b, b, b));
% 		map(1,:)=[0 0 0.5];
% 		map(end,:)=[0.5 0 0];
% 	case 'gray'
% 		map = squeeze(cat(3, b, b, b));
%     end
% end