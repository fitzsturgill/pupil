function initPupil
    

    global state gh

    gh.pupil = guihandles(pupil);

    openini('pupil.ini');
    
    % save fields
    state.pupil.settingsFields = {...  % all scalar
        'filePath',...
        'fileName',...
        'fileNumber',...
        'nFrames',...
        'frameRate'...
        'lidThresh'...
        'pupThresh'...
        };
    state.pupil.saveFields = {...   % of length 1,nFrames
        'currentFrame',...
        'lidThresh',...
        'pupThresh'...
        };
    state.pupil.eyeSaveFields = {... % of length 1,nFrames
        'area',...
        'avg',...
        'majorAxisLength',...
        'minorAxisLength',...
        'centroid',...
        'blinkDetected'...
        };
    state.pupil.pupilSaveFields = {... % of length 1,nFrames
        'area',...
        'diameter',...
        'centroid',...
        'circCenter',...
        'circResidual'...
        };
    
    % set up figures
    state.pupil.frameFigure = ensureFigure('frameFigure', 1);
    % raw frame
    state.pupil.rawFrameAx = subplot(2,2,1); 
    state.pupil.rawFrameImageHandle = imshow(rand(100)*255, [0 255], 'Parent', state.pupil.rawFrameAx);
    state.pupil.eyeBoxHandle = rectangle('Position', [0 0 0 0], 'EdgeColor', 'm');
    set(gca, 'NextPlot', 'add'); %  set intended for update speed    
    % eye frame
    state.pupil.eyeFrameAx = subplot(2,2,2); 
    state.pupil.eyeFrameImageHandle = imshow(rand(100)*255, [0 255], 'Parent', state.pupil.eyeFrameAx);
    state.pupil.pupBoxHandle = rectangle('Position', [0 0 0 0], 'EdgeColor', 'm');    
    set(gca, 'NextPlot', 'add'); %  set intended for update speed            
    % pupil frame
    state.pupil.pupFrameAx = subplot(2,2,3); 
    state.pupil.pupFrameImageHandle = imshow(rand(100)*255, [0 255], 'Parent', state.pupil.pupFrameAx);
    state.pupil.pupCircleHandle = line([0 0], [0 0], 'Parent', state.pupil.pupFrameAx, 'Color', 'y');
    set(gca, 'NextPlot', 'add'); %  set intended for update speed    
    
    set(state.pupil.frameFigure, 'ColorMap', makeColorMap('graySat',9));
end

function map = makeColorMap(color, bits)
	
	a = zeros(2^bits,1);
	b = (0:1/(2^bits -1):1)';
% 	a = zeros(2^bits + 2,1);
% 	b = (0:1/(2^bits +1):1)';
	
	switch color 
	case 'red'
		map = squeeze(cat(3, b, a, a));
	case 'green'
		map = squeeze(cat(3, a, b, a));
	case 'blue'
		map = squeeze(cat(3, a, a, b));
	case 'graySat'
		map = squeeze(cat(3, b, b, b));
		map(1,:)=[0 0 0.5];
		map(end,:)=[0.5 0 0];
	case 'gray'
		map = squeeze(cat(3, b, b, b));
    end
end
    
    
