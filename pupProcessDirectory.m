function pupProcessDirectory(start)
    if nargin < 1
        start = 0; % assuming that bonsai is saving first video with suffix 0 (zero)
    end
    global state
    
    fileNumber = start;    
    while pupLoadVideo(fileNumber)
        pupProcessVideo;
        pupSaveData;
        fileNumber = fileNumber + 1;
        drawnow;
    end
        