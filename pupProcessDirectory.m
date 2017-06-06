function pupProcessDirectory(start, showProgress)
    if nargin < 1
        start = 0; % assuming that bonsai is saving first video with suffix 0 (zero)
    end
    
    if nargin < 2
        showProgress = 1;
    end
    global state
    
    fileNumber = start;    
    while pupLoadVideo(fileNumber)
        pupProcessVideo(showProgress);
        pupSaveData;
        fileNumber = fileNumber + 1;
        drawnow;
    end