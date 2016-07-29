function seeAverages(pulses, channels) 
	global state
	
	persistent colors
	if isempty(colors)
		colors={'red', 'black', 'blue', 'green', 'yellow',...
				'red', 'black', 'blue', 'green', 'yellow',...
				'red', 'black', 'blue', 'green', 'yellow',...
				'red', 'black', 'blue', 'green', 'yellow',...
				'red', 'black', 'blue', 'green', 'yellow',...
				'red', 'black', 'blue', 'green', 'yellow',...
			};
	end
	if nargin==0
		if state.cycle.useCyclePos
			pulses=1:size(state.cycle.delayList,2);
		else
			pulses=state.cycle.da0List;
		end
		
	end
	if nargin<2
		channels=0:7;
	end
	
	first=1;
	channelsUsed=[];
	pulsesUsed=[];
	counter=0;
	for channel=channels
		if getfield(state.phys.settings, ['acq' num2str(channel)]) & getfield(state.phys.settings, ['avg' num2str(channel)])
			pulsesDone=zeros(1,100);
			channelsUsed(end+1)=channel;
			for pulse=pulses
				if pulse & ~pulsesDone(pulse)
					pulsesDone(pulse)=1;
					name=physAvgName(state.epoch, channel, pulse);
					if ~iswave(name);
						wave(name, []);
					end
					if ~any(pulse==pulsesUsed)
						pulsesUsed(end+1)=pulse;
					end
					counter=mod(counter, length(colors))+1;
					if first
						evalin('base',['plot(' name ');']);
						evalin('base',['setplotprops(''' name ''', ''color'', ''' colors{counter} '''); ']);
						first=0;
					else
						figure(gcf);
						evalin('base', ['append(' name ');']);
						evalin('base', ['setplotprops(' name ', ''color'', ''' colors{counter} '''); ']);
					end
				end
			end
		end
	end
	if first
		figure;
	end
	set(gcf, 'Name', ['EPOCH ' num2str(state.epoch) ', Chan ' num2str(channelsUsed) ', Pulses ' num2str(pulsesUsed)], ...
		'NumberTitle', 'off');



