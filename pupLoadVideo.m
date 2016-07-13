function success = pupLoadVideo(fileNumber)
    global state

    if nargin < 1
        fileNumber = state.pupil.fileNumber;
    end
        state.pupil.processedData=[];
    try
        name = [state.pupil.fileBaseName num2str(fileNumber) '.avi'];
        fname = fullfile(state.pupil.filePath, [state.pupil.fileBaseName num2str(fileNumber) '.avi']);
        
        state.pupil.vidObject = VideoReader(fname);
        disp(['*** Loaded ' name ' from ' state.pupil.filePath ' ***']);
        state.pupil.fileName = name;
        updateGUIByGlobal('state.pupil.fileName');
        state.pupil.fileNumber = fileNumber;
        updateGUIByGlobal('state.pupil.fileNumber');
        
        nFrames = round(state.pupil.vidObject.Duration * state.pupil.vidObject.FrameRate);
        state.pupil.nFrames=nFrames;
        frameSize = [state.pupil.vidObject.Height state.pupil.vidObject.Width];
        state.pupil.frameSize = frameSize;
        vidData = zeros([frameSize nFrames]);
%         while hasFrame(state.pupil.vidObject)
        counter = 1;
        
        while hasFrame(state.pupil.vidObject)
            frame = rgb2gray(readFrame(state.pupil.vidObject));
            vidData(:,:,counter) = frame;
            counter = counter + 1;
        end
        state.pupil.vidData = vidData;
        success = 1;
    catch
        success = 0;
        disp('*** Failed to Load Video ***');
    end
        