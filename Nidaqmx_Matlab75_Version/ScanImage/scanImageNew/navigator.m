function navigator

    global state
    global gh
    
    hires_cfg='512x512 red max.cfg';
    lores_cfg='128x128 2 chan no max.cfg';
    
    state.navigator.navChannel=2;
    
%    selectConfigurationFromMenu(hires_cfg);
    
    %executeGrabOneStackCallback;
    
    %wait(state.daq.grabInput, 1000);
    
    axisPosition = [0 0 1 1];
	aspectRatio = state.internal.imageAspectRatioBias*state.acq.scanAmplitudeY/state.acq.scanAmplitudeX; 

    state.navigator.usingNav=1;
    
    state.navigator.navFigure = figure(...
		'Position', state.windowPositions.compositeImage_position, ...
		'doublebuffer', 'on',...
		'Tag',  'NavFigure', ...
		'Name',  'Navigator', ...
		'NumberTitle', 'off',  ...
		'CloseRequestFcn', 'set(gcf, ''visible'', ''off'')', ...
		'visible', 'on' ...
		);
		
	state.navigator.navAxis = axes(...
		'YDir', 'Reverse',...
		'NextPlot', 'add', ...
		'XLim', [0 state.acq.pixelsPerLine], ...
		'YLim', [0 state.acq.linesPerFrame], ...
		'CLim', [0 1], ...
		'Parent', state.navigator.navFigure, ...
		'YTickLabelMode', 'manual', ...
		'XTickLabelMode', 'manual', ...
		'Position', axisPosition,  ...
		'XTickLabel', [], ...
		'YTickLabel', [], ...
		'DataAspectRatioMode', 'manual',  ...
		'DataAspectRatio', [aspectRatio 1 1]...
		);
    
  	%startImage=	zeros(state.acq.linesPerFrame, state.acq.pixelsPerLine, 3);

    startImage=state.acq.maxData{state.navigator.navChannel};
    
    state.navigator.storedMaxImage=startImage;
    
    state.navigator.storedAllImages=state.acq.acquiredData{state.navigator.navChannel};
    
    state.navigator.navImage = image(...
            startImage, ...
            'Parent', state.navigator.navAxis...
		);
    
    set(state.navigator.navAxis, 'DataAspectRatioMode', 'auto');
    
    state.navigator.navZoom=state.acq.zoomFactor;
    state.navigator.numberOfZSlices=state.acq.numberOfZSlices;
    state.navigator.numberOfFrames=state.acq.numberOfFrames;
    
    state.navigator.repeatedMirrorData=state.acq.repeatedMirrorData;
    state.navigator.lengthOfXData=state.internal.lengthOfXData;
    state.navigator.fractionStart=state.internal.fractionStart;
    state.navigator.fractionPerPixel=state.internal.fractionPerPixel;
    
    state.navigator.maxMirrorX=max(state.acq.repeatedMirrorData(:, 1));
    state.navigator.minMirrorX=min(state.acq.repeatedMirrorData(:, 1));
    state.navigator.maxMirrorY=max(state.acq.repeatedMirrorData(:, 2));
    state.navigator.minMirrorY=min(state.acq.repeatedMirrorData(:, 2));
    
    setColorMap('gray');
    
    % switch to low-res configuration
    
    %selectConfigurationFromMenu(lores_cfg);
    
    %displayReferenceImage;
    
    