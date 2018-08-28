function pupProcessDirectory(start, showProgress, stop)
    if nargin < 1
        start = 0; % assuming that bonsai is saving first video with suffix 0 (zero)
    end
    
    if nargin < 2
        showProgress = 1;
    end
    
    if nargin < 3
        stop = 500;
    end
    
    for fileNumber = start:stop 
        if pupLoadVideo(fileNumber)        
            pupProcessVideo(showProgress);
            pupSaveData;
            drawnow;
        end
    end
    
    
    
    %% old version
%         fileNumber = start;    
%     while pupLoadVideo(fileNumber)        
%         pupProcessVideo(showProgress);
%         pupSaveData;
%         fileNumber = fileNumber + 1;
%         drawnow;
%         if fileNumber == stop
%             break
%         end
%     end