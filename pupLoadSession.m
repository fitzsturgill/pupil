function pupilSession = pupLoadSession(filepath, trialLength)
%     cd('E:\Data\ChAT_26\SO_RewardPunish_odor\Session Data\Pupil_160710');
    cd(filepath);


    fs = dir('Pupil_*.mat');
    if length(fs) == 0
        error('Error in pupLoadSession, no Pupil_ files found');
    end
    fileList = {};
    [fileList{1:length(fs)}] = fs(:).name;
    [fileList,~] = sort_nat(fileList);
    nTrials = length(fileList);
%     trialLength = 10;

    cellFields = {'frameIdx', 'xData', 'settings', 'eyeArea', 'blinkDetected',...
        'pupArea', 'pupDiameter', 'pupResidual'};
    matFields = {'nFrames', 'trueFrameRate', 'dX'};

    pupilSession = struct();
    for field = cellFields
        pupilSession.(field{:}) = cell(nTrials, 1);
    end
    h = waitbar(0, 'Loading Pupil Session Data');
    for field = matFields
        pupilSession.(field{:}) = zeros(nTrials, 1);
    end

    for counter = 1:nTrials
        S = load(fileList{counter});
        pupilSession.frameIdx{counter} = S.pupilData.currentFrame;
        pupilSession.nFrames(counter) = S.pupilData.settings.nFrames;
%         xData = linspace(0, trialLength, pupilSession.nFrames + 1);    
%         pupilSession.xData{counter} = xData(1:end-1);  % i.e. linspace(0,10,10) doesn't give integers....
        pupilSession.dX(counter) = trialLength/pupilSession.nFrames(counter);
        pupilSession.xData{counter} = 0:pupilSession.dX(counter):(trialLength - pupilSession.dX(counter));
        pupilSession.trueFrameRate(counter) = S.pupilData.settings.nFrames / trialLength;
        pupilSession.settings{counter} = S.pupilData.settings;
        pupilSession.eyeArea{counter} = S.pupilData.eye.area;
        pupilSession.blinkDetected{counter} = S.pupilData.eye.blinkDetected;
        pupilSession.pupArea{counter} = S.pupilData.pupil.area;
        pupilSession.pupDiameter{counter} = S.pupilData.pupil.diameter;
        pupilSession.pupResidual{counter} = S.pupilData.pupil.circResidual;
        waitbar(counter/nTrials);
    end
    close(h);
    disp(['*** Loaded Pupil Files from: ' filepath ' ***']);
