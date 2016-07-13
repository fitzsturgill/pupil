function success = pupSaveData
    global state
    success = 0;
    if isempty(state.pupil.processedData);
        success = pupProcessVideo;
        if ~success
            error('Error in pupSaveData');
        end
    end
    
    pupilData = state.pupil.processedData;
    saveName = fullfile(state.pupil.filePath, [state.pupil.fileBaseName num2str(state.pupil.fileNumber) '.mat']);
    save(saveName, 'pupilData');
    disp(['*** Saved: ' saveName ' ***']);
    success = 1;
    

    