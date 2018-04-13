function addSpineDataToList
global state gh

set(gh.spineDataGUI.combSpData, 'Enable', 'on');
state.imageProc.spineData.allDataList{state.imageProc.spineData.counter,1} = state.imageProc.spineData.spineDataName;
state.imageProc.spineData.allDataList{state.imageProc.spineData.counter,2} = [state.imageProc.spineData.meanDensity, state.imageProc.spineData.meanDenErr,...
		state.imageProc.spineData.overallDensity, state.imageProc.spineData.overallDenErr, state.imageProc.spineData.overallLength, state.imageProc.spineData.overallLenErr, ...
		state.imageProc.spineData.meanLength, state.imageProc.spineData.meanLenErr, state.imageProc.spineData.overallVolume, state.imageProc.spineData.overallVolErr, ...
		state.imageProc.spineData.meanVolume, state.imageProc.spineData.meanVolErr,  state.imageProc.spineData.meanDensity3, state.imageProc.spineData.meanDenErr3, ...
	 state.imageProc.spineData.overallDensity3, state.imageProc.spineData.overallDenErr3, state.imageProc.spineData.numberOfNeurons];
state.imageProc.spineData.allDataList{state.imageProc.spineData.counter,3} = state.imageProc.spineData.HistogramData;
state.imageProc.spineData.allDataList{state.imageProc.spineData.counter,4} = state.imageProc.spineData.volumeHist;
state.imageProc.spineData.counter = state.imageProc.spineData.counter+1;