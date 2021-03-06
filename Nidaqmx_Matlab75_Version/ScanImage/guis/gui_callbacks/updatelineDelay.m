function updatelineDelay(handle)
global state gh

% updatelineDelay.m******
% Callback function that updates all the parameters that need to be updated whenever
% the lineDelay variable changes.
%
% This includes the actual definition of lineDelay;
%
% Written By: Thomas Pologruto
% Cold Spring Harbor Labs
% January 2, 2001

% If Line Delay is in ms
state.acq.lineDelay = get(gh.configurationGUI.edit4, 'Value');
state.acq.lineDelay = .001*state.acq.lineDelay/state.acq.msPerLine;
