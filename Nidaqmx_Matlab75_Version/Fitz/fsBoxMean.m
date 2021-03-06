function subtracted=fsboxMean(channel)
	global state
	
	figure(channel);

	k = waitforbuttonpress;

	if isempty(findobj(gcf, 'Type', 'axes'))
		disp('*** NO axes***');
		return
	end
		
		
	point1 = get(gca,'CurrentPoint');    % button down detected
	finalRect = rbbox;                   % return figure units
% 	set(gh.pcellControl.selectBoxButton, 'ForeGroundColor', [0 0 0]);
	setStatusString('');

	point2 = get(gca,'CurrentPoint');    % button up detected
	point1 = point1(1,1:2);              % extract x and y
	point2 = point2(1,1:2);
	p1 = min(point1,point2);             % calculate locations
	offset = abs(point1-point2);         % and dimensions
	x = [p1(1) p1(1)+offset(1) p1(1)+offset(1) p1(1) p1(1)];
	y = [p1(2) p1(2) p1(2)+offset(2) p1(2)+offset(2) p1(2)];
	x=round(x);
	y=round(y);
	x0=x(1);
	x1=x(2);
	y0=y(1);
	y1=y(3);
	
	
	
	
	m=mean2(state.acq.acquiredData{channel}(x0:x1,y0:y1));

	
	
	% 	s=std2(state.acq.acquiredData{chan});

	m0=0;
	eval(['m0=state.acq.binFactor*state.acq.pmtOffsetChannel' num2str(channel) ';']);
	
	subtracted=m-m0;
	
	
	
	
	
	
	
	
% 	pv=s*s/(m-m0);
% 	disp(['offset = ' num2str(m0)]);
% 	disp(['mean = ' num2str(m)]);
% 	disp(['var = ' num2str(s*s)]);
% 	disp(['pvpp on channel ' num2str(chan) ' = ' num2str(pv)]);
	return