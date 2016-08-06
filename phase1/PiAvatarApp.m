function varargout = PiAvatarApp(varargin)
%PIAVATARAPP MATLAB code file for PiAvatarApp.fig
%      PIAVATARAPP, by itself, creates a new PIAVATARAPP or raises the existing
%      singleton*.
%
%      H = PIAVATARAPP returns the handle to a new PIAVATARAPP or the handle to
%      the existing singleton*.
%
%      PIAVATARAPP('Property','Value',...) creates a new PIAVATARAPP using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to PiAvatarApp_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PIAVATARAPP('CALLBACK') and PIAVATARAPP('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PIAVATARAPP.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PiAvatarApp

% Last Modified by GUIDE v2.5 07-Aug-2016 00:50:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PiAvatarApp_OpeningFcn, ...
                   'gui_OutputFcn',  @PiAvatarApp_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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

% --- Executes just before PiAvatarApp is made visible.
function PiAvatarApp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)
handles.piAvatar = [];

% Choose default command line output for PiAvatarApp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PiAvatarApp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PiAvatarApp_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function editIpAddress_Callback(hObject, eventdata, handles)
% hObject    handle to editIpAddress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIpAddress as text
%        str2double(get(hObject,'String')) returns contents of editIpAddress as a double


% --- Executes during object creation, after setting all properties.
function editIpAddress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editIpAddress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editId_Callback(hObject, eventdata, handles)
% hObject    handle to editId (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editId as text
%        str2double(get(hObject,'String')) returns contents of editId as a double


% --- Executes during object creation, after setting all properties.
function editId_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editId (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editPassword_Callback(hObject, eventdata, handles)
% hObject    handle to editPassword (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editPassword as text
%        str2double(get(hObject,'String')) returns contents of editPassword as a double


% --- Executes during object creation, after setting all properties.
function editPassword_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPassword (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuAvailableResolutions.
function popupmenuAvailableResolutions_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuAvailableResolutions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuAvailableResolutions contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuAvailableResolutions
idx = get(hObject, 'Value');
res = hObject.String{idx};
[strwidth,res] = strtok(res,'x');
strheight = strtok(res,'x');
width  = str2double(strwidth);
height = str2double(strheight);
axes(handles.axesImage)
%set(handles.axesImage.Children,'CData',rand(height,width,3))
imshow(rand(height,width,3));

% Update handless
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function popupmenuAvailableResolutions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuAvailableResolutions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject,'String', raspi.internal.cameraboard.AvailableResolutions);

% --- Executes on button press in pushbuttonConnect.
function pushbuttonConnect_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonConnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Instantiation of PiAvatar
ipAddress= get(handles.editIpAddress,'String');
id = get(handles.editId,'String');
password = get(handles.editPassword,'String');
idx = get(handles.popupmenuAvailableResolutions, 'Value');
res = handles.popupmenuAvailableResolutions.String{idx};
[strwidth,res] = strtok(res,'x');
strheight = strtok(res,'x');
width  = str2double(strwidth);
height = str2double(strheight);
piAvatar = PiAvatar(...
    'IpAddress',ipAddress,...
    'Id',id,...
    'Password',password,...
    'Resolution',sprintf('%dx%d',width,height));
handles.piAvatar = piAvatar;

% Update GUI
set(handles.editIpAddress                 , 'Enable', 'off')
set(handles.editId                        , 'Enable', 'off')
set(handles.editPassword                  , 'Enable', 'off')
set(handles.popupmenuAvailableResolutions , 'Enable', 'off');
set(hObject                               , 'Enable', 'off')
set(handles.pushbuttonDisconnect          , 'Enable', 'on')
set(handles.textNoConnection              , 'Enable', 'off')
set(handles.textReady                     , 'Enable', 'on')
set(handles.textInProcess                 , 'Enable', 'off')
set(handles.popupmenuAvailableImageEffects, 'Enable', 'on')
set(handles.pushbuttonStart               , 'Enable', 'on')

% Update image
idx = get(handles.popupmenuAvailableImageEffects, 'Value');
val = handles.popupmenuAvailableImageEffects.String{idx};
set(handles.piAvatar,'ImageEffect',val)
for iter = 1:5
    step(handles.piAvatar,'Snapshot')
end
img = get(handles.piAvatar,'img');
axes(handles.axesImage)
imshow(img)

% Update handles
guidata(hObject,handles)

% --- Executes on selection change in popupmenuAvailableImageEffects.
function popupmenuAvailableImageEffects_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuAvailableImageEffects (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuAvailableImageEffects contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuAvailableImageEffects
idx = get(hObject, 'Value');
val = hObject.String{idx};
set(handles.piAvatar,'ImageEffect',val)
release(handles.piAvatar)

for iter = 1:5
    step(handles.piAvatar,'Snapshot')
end
img = get(handles.piAvatar,'img');
set(handles.axesImage.Children,'CData',img)

% Update handles
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function popupmenuAvailableImageEffects_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuAvailableImageEffects (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Get camera information
set(hObject,'String', raspi.internal.cameraboard.AvailableImageEffects);

% --- Executes on button press in pushbuttonDisconnect.
function pushbuttonDisconnect_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonDisconnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
while ~isempty(handles.piAvatar)
    handles.piAvatar = [];
end
set(hObject                               , 'Enable', 'off')
set(handles.editIpAddress                 , 'Enable', 'on')
set(handles.editId                        , 'Enable', 'on')
set(handles.editPassword                  , 'Enable', 'on')
set(handles.pushbuttonConnect             , 'Enable', 'on')
set(handles.textNoConnection              , 'Enable', 'on')
set(handles.textReady                     , 'Enable', 'off')
set(handles.textInProcess                 , 'Enable', 'off')
set(handles.popupmenuAvailableResolutions , 'Enable', 'on')
set(handles.popupmenuAvailableImageEffects, 'Enable', 'off')
set(handles.pushbuttonStart               , 'Enable', 'off')
set(handles.pushbuttonStop                , 'Enable', 'off')

% Update handles
guidata(hObject,handles)

% --- Executes on button press in pushbuttonStop.
function pushbuttonStop_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Update GUI
set(hObject                               , 'Enable', 'off')
set(handles.pushbuttonStart               , 'Enable', 'on')
set(handles.textNoConnection              , 'Enable', 'off')
set(handles.textReady                     , 'Enable', 'on')
set(handles.textInProcess                 , 'Enable', 'off')
set(handles.popupmenuAvailableImageEffects, 'Enable', 'on')
% Random 
axes(handles.axesImage)
img = rand(size(get(handles.axesImage.Children,'CData')));
set(handles.axesImage.Children,'CData',img)

% Release piAvatar
release(handles.piAvatar)

% Update handles
guidata(hObject,handles)

% --- Executes on button press in pushbuttonStart.
function pushbuttonStart_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Update GUI
set(hObject                               , 'Enable', 'off')
set(handles.pushbuttonStop                , 'Enable', 'on')
set(handles.textNoConnection              , 'Enable', 'off')
set(handles.textReady                     , 'Enable', 'off')
set(handles.textInProcess                 , 'Enable', 'on')
set(handles.popupmenuAvailableResolutions , 'Enable', 'off')
set(handles.popupmenuAvailableImageEffects, 'Enable', 'off')

% Get snapshot
for iter = 1:100
    step(handles.piAvatar,'Snapshot')
    img = get(handles.piAvatar,'img');
    set(handles.axesImage.Children,'CData',img)
end

% Update handles
guidata(hObject,handles)
