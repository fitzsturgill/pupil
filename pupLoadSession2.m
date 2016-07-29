function pupilSession = pupLoadSession2(filepath)

%% assumes all trials are same length
%     cd('E:\Data\ChAT_26\SO_RewardPunish_odor\Session Data\Pupil_160710');
    cd(filepath);

    frameRate = 120;
    dX = 1/frameRate;
    fs = dir('Pupil_*.mat');
    if length(fs) == 0
        error('Error in pupLoadSession, no Pupil_ files found');
    end
    fileList = {};
    [fileList{1:length(fs)}] = fs(:).name;
    [fileList,~] = sort_nat(fileList);
    nTrials = length(fileList);
%     trialLength = 10;

%% load and figure out min number of frames
    nFrameArray = zeros(nTrials, 1);
%     S = repmat(struct(), nTrials, 1);
%     S = struct();
    for counter = 1:nTrials
        if counter == 1
            S = load(fileList{counter});
        else
            S(counter) = load(fileList{counter});
        end
        nFrameArray(counter) = S(counter).pupilData.settings.nFrames;
    end
    minFrames = min(nFrameArray); % truncate to minimum frame count (small amount of slop in video acquisition)
    %% now initialize
    matFields = {'eyeArea', 'blinkDetected',...
        'pupArea', 'pupDiameter', 'pupResidual'};

    pupilSession = struct();
    pupilSession.settings = cell(nTrials, 1);
    pupilSession.xData = 0:dX:(minFrames - 1) * dX;
    for field = matFields
        pupilSession.(field{:}) = zeros(nTrials, minFrames);
    end
%     h = waitbar(0, 'Loading Pupil Session Data');
%     for field = scalarFields
%         pupilSession.(field{:}) = zeros(nTrials, 1);
%     end
    %%    

    for counter = 1:nTrials        
%         pupilSession.frameIdx(counter, :) = S(counter).pupilData.currentFrame(1:minFrames);
%         pupilSession.dX(counter) = trialLength/pupilSession.nFrames(counter);
%         pupilSession.xData(counter, :) = 0:pupilSession.dX(counter):(trialLength - pupilSession.dX(counter));
%         pupilSession.trueFrameRate(counter) = S(counter).pupilData.settings.nFrames / trialLength;
        pupilSession.settings{counter} = S(counter).pupilData.settings;
        pupilSession.eyeArea(counter, :) = S(counter).pupilData.eye.area(1:minFrames);
        pupilSession.blinkDetected(counter, :) = S(counter).pupilData.eye.blinkDetected(1:minFrames);
        pupilSession.pupArea(counter, :) = S(counter).pupilData.pupil.area(1:minFrames);
        pupilSession.pupDiameter(counter, :) = S(counter).pupilData.pupil.diameter(1:minFrames);
        pupilSession.pupResidual(counter, :) = S(counter).pupilData.pupil.circResidual(1:minFrames);
%         waitbar(counter/nTrials);
    end
%     close(h);
    disp(['*** Loaded Pupil Files from: ' filepath ' ***']);
