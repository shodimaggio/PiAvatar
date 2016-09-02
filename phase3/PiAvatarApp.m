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
%
% Copyright (c) 2016-, Shogo MURAMATSU, All rights reserved.
%
% Contact address: Shogo MURAMATSU,
%    Faculty of Engineering, Niigata University,
%    8050 2-no-cho Ikarashi, Nishi-ku,
%    Niigata, 950-2181, JAPAN

% Edit the above text to modify the response to help PiAvatarApp

% Last Modified by GUIDE v2.5 02-Sep-2016 13:45:40

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
handles.agHandle = AccelGraph('AxesHandle',handles.axesAccel);
handles.command  = 'Neutral';
handles.tglLed1  = false;
handles.tglLed2  = false;
handles.piState  = 'No connection';
%handles.isPiLocked = false;

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

%if strcmp(handles.textInProcess.Enable,'on')
if strcmp(handles.piState,'In process')
    
    switch(eventdata.Key)
        case 'uparrow'
            handles.command = 'Forward';
        case 'downarrow'
            handles.command = 'Reverse';
        case 'leftarrow'
            handles.command = 'Turn left';
        case 'rightarrow'
            handles.command = 'Turn right';
        case 'space'
            handles.command = 'Brake';
        case '1'
            if handles.tglLed1
                handles.command = 'Led1Off';
                handles.tglLed1 = false;
                %handles.textLed1.Enable = 'off';
            else
                handles.command = 'Led1On';
                handles.tglLed1 = true;
                %handles.textLed1.Enable = 'on';
            end
        case '2'
            if handles.tglLed2
                handles.command = 'Led2Off';
                handles.tglLed2 = false;
                %handles.textLed2.Enable = 'off';
            else
                handles.command = 'Led2On';
                handles.tglLed2 = true;
                %handles.textLed2.Enable = 'on';
            end
    end
    guidata(hObject,handles);
    
end

function figure1_KeyReleaseFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

%if strcmp(handles.textInProcess.Enable,'on')
if strcmp(handles.piState,'In process')
    handles.command = 'Neutral';
    guidata(hObject,handles);
end

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
idx = hObject.Value;
res = hObject.String{idx};
[strwidth,res] = strtok(res,'x');
strheight = strtok(res,'x');
width  = str2double(strwidth);
height = str2double(strheight);
axes(handles.axesImage)
imshow(rand(height,width,3));
uistack(handles.axesAccel,'top')
uistack(handles.axesImage,'bottom')

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

hObject.String = raspi.internal.cameraboard.AvailableResolutions;

% --- Executes on button press in pushbuttonConnect.
function pushbuttonConnect_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonConnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Instantiation of PiAvatar
ipAddress     = handles.editIpAddress.String;
id            = handles.editId.String;
password      = handles.editPassword.String;
piCamera      = handles.checkboxPiCamera.Value;
faceDetection = handles.checkboxFaceDetection.Value;
histogramEq   = handles.checkboxHistogramEq.Value;

idx          = handles.popupmenuAvailableResolutions.Value;
res          = handles.popupmenuAvailableResolutions.String{idx};
[swidth,res] = strtok(res,'x');
sheight      = strtok(res,'x');
width        = str2double(swidth);
height       = str2double(sheight);

try
    handles.piAvatar = PiAvatar(...
        'IpAddress',ipAddress,...
        'Id',id,...
        'Password',password,...
        'Resolution',sprintf('%dx%d',width,height),...
        'PiCamera',piCamera,...
        'FaceDetection',faceDetection,...
        'HistogramEq',histogramEq);
    
    % Update GUI
    hObject.Enable = 'off';
    %
    uiobjs = findobj('UserData','Initialization');
    for idx = 1:length(uiobjs)
        uiobjs(idx).Enable = 'off';
    end
    %
    handles.pushbuttonDisconnect.Enable           = 'on';
    %
    handles.piState = 'Ready';
    handles.textNoConnection.Enable               = 'off';
    handles.textReady.Enable                      = 'on';    
    handles.textInProcess.Enable                  = 'off';
    %
    handles.pushbuttonStart.Enable                = 'on';
    handles.uipanelControlMonitor.Visible         = 'on';
    
    % Update image
    if handles.checkboxPiCamera.Value
        handles.popupmenuAvailableImageEffects.Enable = 'on';
        handles.checkboxHorizontalFlip.Enable         = 'on';
        handles.checkboxVerticalFlip.Enable           = 'on';
        %
        idx = handles.popupmenuAvailableImageEffects.Value;
        val = handles.popupmenuAvailableImageEffects.String{idx};
        handles.piAvatar.ImageEffect = val;
        for iter = 1:5
            step(handles.piAvatar,'Snapshot')
        end
        if isempty(handles.axesImage.Children)
            axes(handles.axesImage)
            imshow(handles.piAvatar.img)
            uistack(handles.axesAccel,'top')
            uistack(handles.axesImage,'bottom')
        else
            handles.axesImage.Children.CData = handles.piAvatar.img;
        end
    else
        handles.popupmenuAvailableImageEffects.Enable = 'off';
        handles.checkboxHorizontalFlip.Enable         = 'off';
        handles.checkboxVerticalFlip.Enable           = 'off';
    end
    
    % Update handles
    guidata(hObject,handles)
catch
    % http://jp.mathworks.com/help/matlab/ref/dialog.html
    d = dialog('Position',[300 300 250 150],...
        'Name','Warning: pushbuttonConnect_Callback');
    uicontrol('Parent',d,...
        'Style','text',...
        'Position',[20 80 210 40],...
        'String','Connecton failed. Please retry.');
    uicontrol('Parent',d,...
        'Position',[85 20 70 25],...
        'String','OK',...
        'Callback','delete(gcf)');
    waitfor(d)
end


% --- Executes on button press in pushbuttonDisconnect.
function pushbuttonDisconnect_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonDisconnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
while ~isempty(handles.piAvatar)
    handles.piAvatar = [];
end
hObject.Enable                                = 'off';
handles.pushbuttonConnect.Enable              = 'on';
%
uiobjs = findobj('UserData','Initialization');
for idx = 1:length(uiobjs)
    uiobjs(idx).Enable = 'on';
end
if ~handles.checkboxPiCamera.Value
    handles.checkboxFaceDetection.Enable          = 'off';
    handles.checkboxHistogramEq.Enable            = 'off';    
    handles.popupmenuAvailableResolutions.Enable  = 'off';
end
%
handles.piState = 'No connection';
handles.textNoConnection.Enable               = 'on';
handles.textReady.Enable                      = 'off';
handles.textInProcess.Enable                  = 'off';
%
handles.popupmenuAvailableImageEffects.Enable = 'off';
handles.checkboxHorizontalFlip.Enable         = 'off';
handles.checkboxVerticalFlip.Enable           = 'off';
handles.pushbuttonStart.Enable                = 'off';
handles.pushbuttonStop.Enable                 = 'off';
handles.uppanelControlMonitor.Visible         = 'off';

% Update handles
guidata(hObject,handles)

% --- Executes on selection change in popupmenuAvailableImageEffects.
function popupmenuAvailableImageEffects_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuAvailableImageEffects (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenuAvailableImageEffects contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenuAvailableImageEffects
release(handles.piAvatar)
idx = hObject.Value;
val = hObject.String{idx};
handles.piAvatar.ImageEffect = val;

for iter = 1:5
    step(handles.piAvatar,'Snapshot')
end
handles.axesImage.Children.CData = handles.piAvatar.img;

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
hObject.String = raspi.internal.cameraboard.AvailableImageEffects;

% --- Executes on button press in checkboxHorizontalFlip.
function checkboxHorizontalFlip_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxHorizontalFlip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxHorizontalFlip
release(handles.piAvatar)
handles.piAvatar.HorizontalFlip = hObject.Value;

for iter = 1:5
    step(handles.piAvatar,'Snapshot')
end
handles.axesImage.Children.CData = handles.piAvatar.img;

% Update handles
guidata(hObject,handles)

% --- Executes on button press in checkboxVerticalFlip.
function checkboxVerticalFlip_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxVerticalFlip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxVerticalFlip
release(handles.piAvatar)
handles.piAvatar.VerticalFlip = hObject.Value;

for iter = 1:5
    step(handles.piAvatar,'Snapshot')
end
handles.axesImage.Children.CData = handles.piAvatar.img;

% Update handles
guidata(hObject,handles)

% --- Executes on button press in pushbuttonStop.
function pushbuttonStop_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Stop avatar
handles.command = 'Neutral';

% Update GUI
hObject.Enable                                = 'off';
handles.pushbuttonStart.Enable                = 'on';
handles.pushbuttonDisconnect.Enable           = 'on';
%
handles.piState = 'Ready';
guidata(hObject,handles);
% handles = guidata(hObject);
% while(handles.isPiLocked)
% end
%
handles.textNoConnection.Enable               = 'off';
handles.textReady.Enable                      = 'on';
handles.textInProcess.Enable                  = 'off';
%
if handles.checkboxPiCamera.Value
    handles.popupmenuAvailableImageEffects.Enable = 'on';
    handles.checkboxHorizontalFlip.Enable         = 'on';
    handles.checkboxVerticalFlip.Enable           = 'on';
else
    handles.popupmenuAvailableImageEffects.Enable = 'off';
    handles.checkboxHorizontalFlip.Enable         = 'off';
    handles.checkboxVerticalFlip.Enable           = 'off';
end

% Control Monitor Panel
uiobjs = findobj('UserData','Control Monitor');
for idx = 1:length(uiobjs)
    uiobjs(idx).Enable = 'off';
end

% Turn off LEDs
step(handles.piAvatar,'Led1Off')
step(handles.piAvatar,'Led2Off')

% Release piAvatar
pause(0.1)
release(handles.piAvatar)

% Update handles
guidata(hObject,handles)

% --- Executes on button press in pushbuttonStart.
function pushbuttonStart_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Update GUI
hObject.Enable                                = 'off';
handles.pushbuttonStop.Enable                 = 'on';
handles.pushbuttonDisconnect.Enable           = 'off';
%
handles.piState = 'In process';
handles.textNoConnection.Enable               = 'off';
handles.textReady.Enable                      = 'off';
handles.textInProcess.Enable                  = 'on';
%
handles.popupmenuAvailableResolutions.Enable  = 'off';
handles.popupmenuAvailableImageEffects.Enable = 'off';
handles.checkboxHorizontalFlip.Enable         = 'off';
handles.checkboxVerticalFlip.Enable           = 'off';

% Control Monitor Panel
uiobjs = findobj('UserData','Control Monitor');
for idx = 1:length(uiobjs)
    uiobjs(idx).Enable = 'off';
end

% Update handles
guidata(hObject,handles)

% Control PiAvatar
axes(handles.axesImage)
precommand = 'Neutral';
step(handles.piAvatar,'Neutral')
while(strcmp(handles.piState,'In process'))
    handles = guidata(hObject);
    curcommand = handles.command;
    try
        if strcmp(curcommand,precommand)
            if handles.checkboxAccel.Value
                step(handles.piAvatar,'Acceleration')
            end
            if handles.checkboxPiCamera.Value
                step(handles.piAvatar,'Snapshot')
            end
            if handles.tglLed1 && strcmp(handles.textLed1.Enable,'off')
                handles.textLed1.Enable = 'on';
                step(handles.piAvatar,'Led1On')
            elseif ~handles.tglLed1 && strcmp(handles.textLed1.Enable,'on')
                handles.textLed1.Enable = 'off';                    
                step(handles.piAvatar,'Led1Off')
            end
            if handles.tglLed2 && strcmp(handles.textLed2.Enable,'off')
                handles.textLed2.Enable = 'on';
                step(handles.piAvatar,'Led2On')
            elseif ~handles.tglLed2 && strcmp(handles.textLed2.Enable,'on')
                handles.textLed2.Enable = 'off';
                step(handles.piAvatar,'Led2Off')
            end            
        else
            step(handles.piAvatar,curcommand)
            handles.textUparrow.Enable    = 'off';
            handles.textDownarrow.Enable  = 'off';
            handles.textLeftarrow.Enable  = 'off';
            handles.textRightarrow.Enable = 'off';
            handles.textBrake.Enable      = 'off';            
            switch (curcommand)
                case 'Forward'
                    handles.textUparrow.Enable    = 'on';
                case 'Reverse'
                    handles.textDownarrow.Enable  = 'on';
                case 'Turn left'
                    handles.textLeftarrow.Enable  = 'on';
                case 'Turn right'
                    handles.textRightarrow.Enable = 'on';
                case 'Brake'
                    handles.textBrake.Enable      = 'on';
            end
            precommand = curcommand;
        end
        if ~isempty(handles.piAvatar)
            if handles.checkboxPiCamera.Value
                % 画像取得
                img_ = handles.piAvatar.img;
                % 画像表示
                handles.axesImage.Children.CData = img_;
                uistack(handles.axesImage,'bottom')
            end
            if handles.checkboxAccel.Value
                % 加速度取得
                axl_ = handles.piAvatar.axl;
                % 加速度表示
                step(handles.agHandle,axl_);
            end
        end
    catch
        % http://jp.mathworks.com/help/matlab/ref/dialog.html
        d = dialog('Position',[300 300 250 150],...
            'Name','Warning: pushbuttonStart_Callback');
        uicontrol('Parent',d,...
            'Style','text',...
            'Position',[20 80 210 40],...
            'String','Communication has failed.');
        uicontrol('Parent',d,...
            'Position',[85 20 70 25],...
            'String','OK',...
            'Callback','delete(gcf)');
        waitfor(d)
    end
    %handles.isPiLocked = false;
    %guidata(hObject,handles);    
end

% --- Executes on button press in checkboxPiCamera.
function checkboxPiCamera_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxPiCamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxPiCamera
if hObject.Value
    handles.popupmenuAvailableResolutions.Enable  = 'on';
    handles.checkboxFaceDetection.Enable  = 'on';
    handles.checkboxHistogramEq.Enable    = 'on';        
else
    handles.popupmenuAvailableResolutions.Enable  = 'off';
    handles.checkboxFaceDetection.Enable  = 'off';
    handles.checkboxHistogramEq.Enable    = 'off';            
end

% --- Executes on button press in checkboxFaceDetection.
function checkboxFaceDetection_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxFaceDetection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxFaceDetection


% --- Executes on button press in checkboxAccel.
function checkboxAccel_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxAccel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxAccel
if hObject.Value
    release(handles.agHandle)
    step(handles.agHandle,[0 0 0])
    handles.axesAccel.Visible = 'on';
else
    handles.axesAccel.Visible = 'off';
end


% --- Executes on button press in checkboxHistogramEq.
function checkboxHistogramEq_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxHistogramEq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxHistogramEq
