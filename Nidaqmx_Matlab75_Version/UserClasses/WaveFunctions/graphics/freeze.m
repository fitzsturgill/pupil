function freeze(axishandle)
% Function locks scale and the resacaleAxis function will not operate on it.
% USe release(ax) to allow autoscale to commence.
%
% Sets the axis UserData.autoscale=0 on the ax.
%

if nargin == 0	% No inputs...look for GCA
	a=findobj('Type', 'axes');  % Are there any axes?
	if ~isempty(a)              
		ax=gca;
	else
		error('freeze: No axes defined.');
	end
elseif nargin==1	% axis handle...check
	if istype(axishandle,'axes')
		ax=axishandle;
	else
		error('freeze: Bad Axes handle.');
	end
else
	error('freeze: too many inputs. Only input is axis handle.')
end

userData = get(ax, 'UserData'); % Check if frozen....the dont autoscale.
if isstruct(userData)	% Check format...
	if isfield(userData, 'autoScale')
		userData=setfield(userData, 'autoScale', 0); 	%Dont AutoScale
		set(ax,  'UserData', userData);
	else
		return	
	end
else
	error('freeze: axis UserData in incorrect format.');
end

rescaleAxis(ax);	%Now just sets the update modes for the axis to manual


