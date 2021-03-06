function fig = readIM1_fig()
% This is the machine-generated representation of a Handle Graphics object
% and its children.  Note that handle values may change when these objects
% are re-created. This may cause problems with any callbacks written to
% depend on the value of the handle at the time the object was saved.
% This problem is solved by saving the output as a FIG-file.
%
% To reopen this object, just type the name of the M-file at the MATLAB
% prompt. The M-file and its associated MAT-file must be on your path.
% 
% NOTE: certain newer features in MATLAB may not have been saved in this
% M-file due to limitations of this format, which has been superseded by
% FIG-files.  Figures which have been annotated using the plot editor tools
% are incompatible with the M-file/MAT-file format, and should be saved as
% FIG-files.

load readIM1_fig

h0 = figure('Color',[0.4 0.4 0.4], ...
	'Colormap',mat0, ...
	'FileName','D:\projects\programs\matlab\utilities\GUI\readIM1.fig', ...
	'PaperPosition',[18 180 576 432], ...
	'PaperUnits','points', ...
	'Position',[502 246 1009 868], ...
	'Tag','FigImAn', ...
	'ToolBar','none');
h1 = uimenu('Parent',h0, ...
	'Accelerator','p', ...
	'Label','Projections', ...
	'Tag','Proj');
h2 = uimenu('Parent',h1, ...
	'Accelerator','z', ...
	'Callback',mat1, ...
	'Label','Z_projections', ...
	'Tag','ProjeZ');
h2 = uimenu('Parent',h1, ...
	'Accelerator','x', ...
	'Callback','Tags=get(gcbo, ''Tag''); switcher(Tags); ', ...
	'Label','X_projections', ...
	'Tag','ProjeX');
h2 = uimenu('Parent',h1, ...
	'Accelerator','y', ...
	'Callback','Tags=get(gcbo, ''Tag''); switcher(Tags); ', ...
	'Label','Y-projections', ...
	'Tag','ProjeY');
h2 = uimenu('Parent',h1, ...
	'Label','ProjProperties', ...
	'Tag','ProjeP');
h1 = uimenu('Parent',h0, ...
	'Label','Analysis', ...
	'Tag','Ana');
h2 = uimenu('Parent',h1, ...
	'Accelerator','b', ...
	'Callback','Tags=get(gcbo, ''Tag''); switcher(Tags); ', ...
	'Label','Box Scan', ...
	'Tag','AnalyBox');
h2 = uimenu('Parent',h1, ...
	'Accelerator','l', ...
	'Callback','Tags=get(gcbo, ''Tag''); switcher(Tags); ', ...
	'Label','Line Scan', ...
	'Tag','AnalyLin');
h2 = uimenu('Parent',h1, ...
	'Label','AnalysisProperties', ...
	'Tag','AnalyPro');
h1 = uimenu('Parent',h0, ...
	'Label','Animation', ...
	'Tag','Anima');
h2 = uimenu('Parent',h1, ...
	'Callback','Tags=get(gcbo, ''Tag''); switcher(Tags); ', ...
	'Label','AviMovies', ...
	'Tag','AnimaAvi');
h2 = uimenu('Parent',h1, ...
	'Label','AnimateProperties', ...
	'Tag','AnimaPro');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
	'ListboxTop',0, ...
	'Position',[757 592 189 181], ...
	'Style','frame', ...
	'Tag','Frame1');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
	'ListboxTop',0, ...
	'Position',[51 441 189 181], ...
	'Style','frame', ...
	'Tag','Frame1');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
	'ListboxTop',0, ...
	'Position',[51 636 189 112], ...
	'Style','frame', ...
	'Tag','Frame1');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[1 1 1], ...
	'Callback','             ', ...
	'ListboxTop',0, ...
	'Position',[126 726 100 18], ...
	'String','d:\data\brian\chronic_data\', ...
	'Style','edit', ...
	'Tag','DirectoryText');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[1 1 1], ...
	'Callback','                        ', ...
	'ListboxTop',0, ...
	'Position',[126 701 100 18], ...
	'String','c083b', ...
	'Style','edit', ...
	'Tag','BaseText');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[1 1 1], ...
	'Callback',mat2, ...
	'ListboxTop',0, ...
	'Position',[126 676 100 18], ...
	'String','2', ...
	'Style','edit', ...
	'Tag','SweepText');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
	'Callback',mat3, ...
	'FontSize',10, ...
	'ListboxTop',0, ...
	'Position',[66 641 79 29], ...
	'String','< last', ...
	'Tag','SweepLast');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
	'Callback',mat4, ...
	'FontSize',10, ...
	'ListboxTop',0, ...
	'Position',[156 641 75 29], ...
	'String','next >', ...
	'Tag','SweepNext');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
	'ListboxTop',0, ...
	'Position',[66 726 60 20], ...
	'String','directory', ...
	'Style','text', ...
	'Tag','StaticText1');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
	'ListboxTop',0, ...
	'Position',[66 701 60 21], ...
	'String','base', ...
	'Style','text', ...
	'Tag','StaticText1');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
	'ListboxTop',0, ...
	'Position',[66 676 60 19], ...
	'String','sweep', ...
	'Style','text', ...
	'Tag','StaticText1');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
	'Callback',mat5, ...
	'ListboxTop',0, ...
	'Position',[56 541 182 20], ...
	'Style','slider', ...
	'Tag','FrameSlider');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[1 1 1], ...
	'ListboxTop',0, ...
	'Position',[56 566 37 20], ...
	'String','1', ...
	'Style','edit', ...
	'Tag','FrameMin');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[1 1 1], ...
	'ListboxTop',0, ...
	'Position',[201 566 37 20], ...
	'String','1', ...
	'Style','edit', ...
	'Tag','FrameMax');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[1 1 1], ...
	'Callback',mat6, ...
	'ListboxTop',0, ...
	'Position',[131 566 37 20], ...
	'String','1', ...
	'Style','edit', ...
	'Tag','FrameCurrent');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
	'ListboxTop',0, ...
	'Position',[56 586 34 20], ...
	'String','min', ...
	'Style','text', ...
	'Tag','StaticText2');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
	'ListboxTop',0, ...
	'Position',[131 586 34 20], ...
	'String','current', ...
	'Style','text', ...
	'Tag','StaticText2');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
	'ListboxTop',0, ...
	'Position',[201 586 34 20], ...
	'String','max', ...
	'Style','text', ...
	'Tag','StaticText2');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[1 1 1], ...
	'Callback','       ', ...
	'ListboxTop',0, ...
	'Position',[191 756 40 18], ...
	'String','1', ...
	'Style','edit', ...
	'Tag','ChanText');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
	'ListboxTop',0, ...
	'Position',[126 756 60 21], ...
	'String','chan(1,2)', ...
	'Style','text', ...
	'Tag','StaticText1');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
	'Callback',mat7, ...
	'ListboxTop',0, ...
	'Position',[799 781 78 27], ...
	'String','Save Image', ...
	'Tag','SavesImg');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
	'Callback',mat8, ...
	'ListboxTop',0, ...
	'Position',[836 260 78 27], ...
	'String','Save Data', ...
	'Tag','SavesDat');
h1 = uicontrol('Parent',h0, ...
	'Units','points', ...
	'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
	'Callback',mat9, ...
	'FontSize',16, ...
	'ListboxTop',0, ...
	'Position',[88.1379310344828 304.758620689655 47.7931034482759 22.3448275862069], ...
	'String','>>', ...
	'Style','togglebutton', ...
	'Tag','FrameMovies');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
	'ListboxTop',0, ...
	'Position',[76 517 34 20], ...
	'String','fps', ...
	'Style','text', ...
	'Tag','StaticText3');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[1 1 1], ...
	'ListboxTop',0, ...
	'Position',[76 499 37 20], ...
	'String','10', ...
	'Style','edit', ...
	'Tag','FrameFPS');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
	'Callback',mat10, ...
	'ListboxTop',0, ...
	'Position',[791 725 85 20], ...
	'SliderStep',[0.002865329512893983 0.02865329512893983], ...
	'Style','slider', ...
	'Tag','IpropMinSl');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
	'Callback',mat11, ...
	'ListboxTop',0, ...
	'Position',[792 684 85 20], ...
	'SliderStep',[0.00286532951289398 0.0286532951289398], ...
	'Style','slider', ...
	'Tag','IpropMaxSl', ...
	'Value',0.6416103151862459);
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[1 1 1], ...
	'Callback',mat12, ...
	'ListboxTop',0, ...
	'Position',[880 685 37 20], ...
	'String','165', ...
	'Style','edit', ...
	'Tag','IpropMaxIn');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[1 1 1], ...
	'Callback',mat13, ...
	'ListboxTop',0, ...
	'Position',[880 725 37 20], ...
	'String','165', ...
	'Style','edit', ...
	'Tag','IpropMinIn');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
	'ListboxTop',0, ...
	'Position',[871 701 56 20], ...
	'String','max', ...
	'Style','text', ...
	'Tag','StaticText2');
h1 = uicontrol('Parent',h0, ...
	'BackgroundColor',[0.752941176470588 0.752941176470588 0.752941176470588], ...
	'ListboxTop',0, ...
	'Position',[865 746 53 20], ...
	'String','min', ...
	'Style','text', ...
	'Tag','StaticText2');
h1 = axes('Parent',h0, ...
	'Units','pixels', ...
	'CameraUpVector',[0 1 0], ...
	'CameraUpVectorMode','manual', ...
	'Color',[0.3 0.3 0.3], ...
	'ColorOrder',mat14, ...
	'NextPlot','replacechildren', ...
	'Position',[297 50 519 238], ...
	'Tag','WinDat', ...
	'XColor',[0 0 0], ...
	'YColor',[0 0 0], ...
	'ZColor',[0 0 0]);
h2 = text('Parent',h1, ...
	'Color',[0 0 0], ...
	'HandleVisibility','off', ...
	'HorizontalAlignment','center', ...
	'Position',mat15, ...
	'Tag','Axes2Text4', ...
	'VerticalAlignment','cap');
set(get(h2,'Parent'),'XLabel',h2);
h2 = text('Parent',h1, ...
	'Color',[0 0 0], ...
	'HandleVisibility','off', ...
	'HorizontalAlignment','center', ...
	'Position',mat16, ...
	'Rotation',90, ...
	'Tag','Axes2Text3', ...
	'VerticalAlignment','baseline');
set(get(h2,'Parent'),'YLabel',h2);
h2 = text('Parent',h1, ...
	'Color',[0 0 0], ...
	'HandleVisibility','off', ...
	'HorizontalAlignment','right', ...
	'Position',[-57.33590733590734 5.894514767932489 17.32050807568877], ...
	'Tag','Axes2Text2', ...
	'Visible','off');
set(get(h2,'Parent'),'ZLabel',h2);
h2 = text('Parent',h1, ...
	'Color',[0 0 0], ...
	'HandleVisibility','off', ...
	'HorizontalAlignment','center', ...
	'Position',[49.80694980694982 1.067510548523207 17.32050807568877], ...
	'Tag','Axes2Text1', ...
	'VerticalAlignment','bottom');
set(get(h2,'Parent'),'Title',h2);
h2 = line('Parent',h1, ...
	'Color',[0 0 1], ...
	'Tag','WinDatLine1', ...
	'XData',mat17, ...
	'YData',mat18);
h1 = axes('Parent',h0, ...
	'Units','pixels', ...
	'Box','on', ...
	'CameraUpVector',[0 -1 0], ...
	'CameraViewAngle',8.089374781751729, ...
	'CameraViewAngleMode','manual', ...
	'CLimMode','manual', ...
	'Color',[1 1 1], ...
	'ColorOrder',mat19, ...
	'DataAspectRatioMode','manual', ...
	'Layer','top', ...
	'NextPlot','replacechildren', ...
	'Position',[301 301 512 512], ...
	'Tag','WinImg', ...
	'TickDir','out', ...
	'TickDirMode','manual', ...
	'Visible','off', ...
	'WarpToFill','off', ...
	'XColor',[0 0 0], ...
	'YColor',[0 0 0], ...
	'YDir','reverse', ...
	'ZColor',[0 0 0]);
h2 = text('Parent',h1, ...
	'Color',[0 0 0], ...
	'HandleVisibility','off', ...
	'HorizontalAlignment','center', ...
	'Position',[59.91248001092023 45.99343675669144 632.9752959602454], ...
	'Tag','WinImgText4', ...
	'VerticalAlignment','cap');
set(get(h2,'Parent'),'XLabel',h2);
h2 = text('Parent',h1, ...
	'Color',[0 0 0], ...
	'HandleVisibility','off', ...
	'HorizontalAlignment','center', ...
	'Position',[-6.602711689704318 20.26255996723932 632.9752959602454], ...
	'Rotation',90, ...
	'Tag','WinImgText3', ...
	'VerticalAlignment','baseline');
set(get(h2,'Parent'),'YLabel',h2);
h2 = text('Parent',h1, ...
	'Color',[0 0 0], ...
	'HandleVisibility','off', ...
	'HorizontalAlignment','right', ...
	'Position',[-37.40974784578305 -34.34991321853661 632.9752959602454], ...
	'Tag','WinImgText2', ...
	'Visible','off');
set(get(h2,'Parent'),'ZLabel',h2);
h2 = text('Parent',h1, ...
	'Color',[0 0 0], ...
	'HandleVisibility','off', ...
	'HorizontalAlignment','center', ...
	'Position',[59.91248001092023 -1.442397324543428 632.9752959602454], ...
	'Tag','WinImgText1', ...
	'VerticalAlignment','bottom');
set(get(h2,'Parent'),'Title',h2);
h2 = image('Parent',h1, ...
	'CData',mat20, ...
	'CDataMapping','scaled', ...
	'Tag','WinImgImage1', ...
	'XData',[1 100], ...
	'YData',[1 32]);
if nargout > 0, fig = h0; end
