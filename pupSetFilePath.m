function pupSetFilePath
	global state

	[fname, pname] = uiputfile('path', 'Choose movie path...');
	if pname == 0
		return
	else
		state.pupil.filePath = pname;
        updateGUIByGlobal('state.pupil.filePath');
    end
    
    warning('need to delete pupil region and auto region masks');
    
