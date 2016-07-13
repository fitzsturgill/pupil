function pupProcessVideo(showProgress)
    if nargin < 1
        showProgress = 1;
    end
    global state

    nFrames = state.pupil.nFrames;
    success = 0;    
    %% initialize structure for saving/viewing
    pupilData = struct(...
        'settings', [],...
        'eye', [],...
        'pupil', []...
        );
    
    for field = state.pupil.settingsFields
        pupilData.settings.(field{:}) = state.pupil.(field{:});
    end

    for field = state.pupil.saveFields
        pupilData.(field{:}) = zeros(nFrames,1);
    end
    if showProgress
        h = waitbar(0, 'Processing Video');
    end
    for field = state.pupil.eyeSaveFields
        switch field{:}
            case 'centroid'
                pupilData.eye.(field{:}) = zeros(nFrames,2);                
            otherwise
                pupilData.eye.(field{:}) = zeros(nFrames,1);
        end
    end

    for field = state.pupil.pupilSaveFields
        switch field{:}
            case 'centroid'
                pupilData.pupil.(field{:}) = zeros(nFrames,2);     
            case 'circCenter'
                pupilData.pupil.(field{:}) = zeros(nFrames,2);                     
            otherwise
                pupilData.pupil.(field{:}) = zeros(nFrames,1);
        end
    end     

    
    %% process and store data
    for counter = 1:state.pupil.nFrames
        if showProgress
            if mod(counter, 50)
                pupFlipFrame(counter, 0);
            else
                pupFlipFrame(counter, 1);
            end
        else
            pupFlipFrame(counter, 0);
        end
        for field = state.pupil.saveFields
            pupilData.(field{:})(counter) = state.pupil.(field{:});
        end

        for field = state.pupil.eyeSaveFields
            pupilData.eye.(field{:})(counter,:) = state.pupil.eye.(field{:});
        end

        for field = state.pupil.pupilSaveFields
            pupilData.pupil.(field{:})(counter,:) = state.pupil.pupil.(field{:});
        end
        if showProgress
            waitbar(counter/nFrames);
        end
    end    
    state.pupil.processedData = pupilData;
    success = 1;
    if showProgress
        ensureFigure('processedData', 1) 
        subplot(2,2,1); plot(state.pupil.processedData.eye.area); title('eye area');
        subplot(2,2,2); plot(state.pupil.processedData.pupil.area); title('pupil area');      
        subplot(2,2,3); plot(state.pupil.processedData.pupil.diameter); title('pupil diameter');
        subplot(2,2,4); plot(state.pupil.processedData.pupil.circResidual); title('residual');   
        close(h);
    end