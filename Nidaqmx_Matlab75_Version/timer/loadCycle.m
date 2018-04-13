function loadCycle(pname, fname)
	global state

	if state.internal.cycleChanged
		beep;
		answer=questdlg('Do you want to save changes to the current cycle?', 'SAVE CYCLE?', 'Yes', 'No', 'Cancel', 'Yes');
		if strcmp(answer, 'Cancel')
			return
		elseif strcmp(answer, 'Yes')
			saveCycle;
		end
	end
	
	if nargin<2
		if ~isempty(state.cycle.cyclePath)
			try
				cd(state.cycle.cyclePath);
			catch
			end
		end
		[fname, pname]=uigetfile('*.cyc', 'Choose cycle');
	end

	if ~isnumeric(fname) & ~isempty(fname)
		try
			cycle=load(fullfile(pname, fname), '-MAT');
		catch
			beep;
			error(['loadCycle : Unable to load ' fullfile(pname, fname) '. File may be missing or have been moved.'])
		end
			

		fnames=fieldnames(cycle.cycle);
		for counter=1:length(fnames)
			eval(['state.cycle.' fnames{counter} ' = cycle.cycle.' fnames{counter} ';']);
		end
		
		state.cycle.cycleName = fname;
		state.cycle.cyclePath = pname;
		updateCycleDisplay(1);
		updateGUIBYGlobal('state.cycle.VCRCPulse');
		updateGUIBYGlobal('state.cycle.CCRCPulse');
		updateGUIBYGlobal('state.cycle.randomize');
		updateGUIBYGlobal('state.cycle.writeProtect');
		updateGUIBYGlobal('state.cycle.useCyclePos');
		updateGUIBYGlobal('state.cycle.cycleName'); %TN 27Oct05
		
		makeCycleMenu;
		checkCurrentCycleInMenu;
		state.internal.cycleChanged=0;
		changeCyclePosition(1);
		
		setStatusString('cycle loaded');
	else
		setStatusString('Cannot load cycle');
	end
	
	