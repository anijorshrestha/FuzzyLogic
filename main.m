function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 07-Sep-2020 16:01:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ktx
Data_ktx = uigetfile('*.ktx');
ktx=readktx(Data_ktx);
assignin('base','Data_ktx',Data_ktx);
assignin('base','ktx',ktx);
set(handles.pushbutton2,'Enable','on');
set(handles.text5,'Visible','On');
set(handles.text5,'String',ktx.titel);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global plot;
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global otx
Data_otx=uigetfile('*.otx');
otx=readotx(Data_otx);
assignin('base','Data_otx',Data_otx);
assignin('base','otx',otx);
set(handles.text8,'Visible','On');
set(handles.text8,'String',otx.titel);
set(handles.savegraph,'Enable','on');


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu
in = evalin('base', 'otx') ;
x = evalin('base', 'x') ;
mu = evalin('base', 'mu') ;
min_cl = evalin('base', 'min_cl') ;
max_cr = evalin('base', 'max_cr') ;
ktx = evalin('base', 'ktx') ;
set(hObject,'String',in.Merk.name);
option = get(handles.popupmenu1,'Value') ;
linewidth=str2num(get(handles.edit1,'String'));
membershipFunction(x,mu,min_cl,max_cr,ktx,option,handles,linewidth)


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'Visible','Off');


% --- Executes on button press in savegraph.
function pushbutton3_Callback(hObject, eventdata, handles)
global plot
% hObject    handle to savegraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.popupmenu1,'Visible','On');
set(handles.text7,'Visible','On');
set(handles.text9,'Visible','On');
set(handles.edit1,'Visible','On');
in = evalin('base', 'otx') ;
x = evalin('base', 'x') ;
mu = evalin('base', 'mu') ;
min_cl = evalin('base', 'min_cl') ;
max_cr = evalin('base', 'max_cr') ;
ktx = evalin('base', 'ktx') ;
set(handles.popupmenu1,'String',[in.Merk.name]);
linewidth=str2num(get(handles.edit1,'String'));
option = get(handles.popupmenu1,'Value') ;
membershipFunction(x,mu,min_cl,max_cr,ktx,option,handles,linewidth);



% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
global plot
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text5,'Visible','Off');
set(handles.text9,'Visible','Off');
set(handles.pushbutton2,'Enable','Off');
set(handles.popupmenu1,'Visible','Off');
set(handles.text7,'Visible','Off');
set(handles.text8,'Visible','Off');
set(handles.edit1,'Visible','Off');
cla


% --- Executes on button press in savegraph.
function savegraph_Callback(hObject, eventdata, handles)
% hObject    handle to savegraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fignew = figure('Visible','off'); % Invisible figure
newAxes = copyobj(handles.axes1,fignew); % Copy the appropriate axes
h=gcf;
set(h,'PaperPositionMode','auto');
set(h,'PaperOrientation','landscape');
set(h,'Position',[20 20 1100 700]);
id=get(handles.popupmenu1,'Value');
items = get(handles.popupmenu1,'String')
selectedItem = items{id};
disp(selectedItem);
download_option = get(handles.popupmenu2,'Value')
if download_option == 1
    print(gcf, '-djpeg', strcat(selectedItem,'.jpeg'))
elseif download_option== 2
     print(gcf, '-dpng', strcat(selectedItem,'.png'))
elseif download_option== 3
     print(gcf, '-dpdf', strcat(selectedItem,'.pdf'))
else
    print(gcf, '-dbmp', strcat(selectedItem,'.bmp'))
end
    
    
   


% set(newAxes,'Position',get(groot,'DefaultAxesPosition')); % The original position is copied too, so adjust it.
% set(fignew, 'PaperUnits', 'centimeters');
% set(gcf, 'PaperPosition', [0 0 100 100]);
% set(fignew,'CreateFcn','set(gcbf,''Visible'',''on'')'); % Make it visible upon loading
% saveas(fignew,'features.jpg');
% delete(fignew);


% F = getframe(handles.axes1);
% Image = frame2im(F);
% imwrite(Image.cdata, 'Image.jpg')


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'Visible','Off');
set(hObject,'String',1)









% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
