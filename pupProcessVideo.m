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
        h = waitbar(0, 'Processing Video', 'Position', [15.7500   44.2500  270.0000   56.2500]);
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
        
        if state.pupil.stopPlayback
            state.pupil.stopPlayback = 0;
            return
        end
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
            pupilData.pupil.(field{:})(counter,:) = state.pupil.pupil.(field{:})(1);
        end
        if showProgress
            waitbar(counter/nFrames);
        end
    end    
    state.pupil.processedData = pupilData;
    success = 1;
    % always update graph, not very time-consuming
    ensureFigure('processedData', 1) 
    subplot(3,2,1); hold on; plot(state.pupil.processedData.currentFrame, state.pupil.processedData.eye.area); title('eye area'); set(gca, 'XLim', [1 state.pupil.nFrames]);
    yyaxis right; plot(state.pupil.processedData.currentFrame, state.pupil.processedData.frameAvg, 'r')
    subplot(3,2,2); plot(state.pupil.processedData.currentFrame, state.pupil.processedData.pupil.area); title('pupil area'); set(gca, 'XLim', [1 state.pupil.nFrames]);
    subplot(3,2,3); plot(state.pupil.processedData.currentFrame, state.pupil.processedData.pupil.diameter);% hold on; plot(state.pupil.processedData.currentFrame, state.pupil.processedData.pupil.diameter2, 'r'); 
    title('pupil diameter'); set(gca, 'XLim', [1 state.pupil.nFrames]);
    subplot(3,2,4); plot(state.pupil.processedData.currentFrame, state.pupil.processedData.pupil.circResidual); title('residual'); set(gca, 'XLim', [1 state.pupil.nFrames]);
    subplot(3,2,5); scatter(state.pupil.processedData.pupil.circResidual, state.pupil.processedData.pupil.diameter);
    xlabel('circ fit residual'); ylabel('pupil diameter');
    if showProgress
        close(h);
    end