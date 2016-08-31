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
% Copyright (c) 2016-, Shogo MURAMATSU
%
% All rights reserved.
%
% Contact address: Shogo MURAMATSU,
%    Faculty of Engineering, Niigata University,
%    8050 2-no-cho Ikarashi, Nishi-ku,
%    Niigata, 950-2181, JAPAN

% Edit the above text to modify the response to help PiAvatarApp

% Last Modified by GUIDE v2.5 07-Aug-2016 01:35:26

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
handles.command  = 'Neutral';

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

if strcmp(handles.textInProcess.Enable,'on')

    switch(eventdata.Key)
        case 'uparrow'
            handles.command = 'Forward';
        case 'downarrow'
            handles.command = 'Reverse';
        case 'leftarrow'
            handles.command = 'Turn left';
        case 'rightarrow'
            handles.command = 'Turn right';
        case 'b'
            handles.command = 'Brake';
        case 'space'
            handles.command = 'Neutral';
    end
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

hObject.String = raspi.internal.cameraboard.AvailableResolutions;

% --- Executes on button press in pushbuttonConnect.
function pushbuttonConnect_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonConnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Instantiation of PiAvatar
ipAddress = handles.editIpAddress.String;
id        = handles.editId.String;
password  = handles.editPassword.String;

idx       = handles.popupmenuAvailableResolutions.Value;
res       = handles.popupmenuAvailableResolutions.String{idx};
[swidth,res] = strtok(res,'x');
sheight  = strtok(res,'x');
width    = str2double(swidth);
height   = str2double(sheight);

try
    piAvatar = PiAvatar(...
        'IpAddress',ipAddress,...
        'Id',id,...
        'Password',password,...
        'Resolution',sprintf('%dx%d',width,height));
    handles.piAvatar = piAvatar;
    
    % Update GUI
    hObject.Enable                                = 'off';
    handles.editIpAddress.Enable                  = 'off';
    handles.editId.Enable                         = 'off';
    handles.editPassword.Enable                   = 'off';
    handles.popupmenuAvailableResolutions.Enable  = 'off';
    handles.pushbuttonDisconnect.Enable           = 'on';
    handles.textNoConnection.Enable               = 'off';
    handles.textReady.Enable                      = 'on';
    handles.textInProcess.Enable                  = 'off';
    handles.popupmenuAvailableImageEffects.Enable = 'on';
    handles.checkboxHorizontalFlip.Enable         = 'on';
    handles.checkboxVerticalFlip.Enable           = 'on';
    handles.pushbuttonStart.Enable                = 'on';
    handles.uipanelControlMonitor.Visible         = 'on';    
    
    % Update image
    idx = handles.popupmenuAvailableImageEffects.Value;
    val = handles.popupmenuAvailableImageEffects.String{idx};
    handles.piAvatar.ImageEffect = val;
    for iter = 1:5
        step(handles.piAvatar,'Snapshot')
    end
    axes(handles.axesImage)
    imshow(handles.piAvatar.img)
    
    % Update handles
    guidata(hObject,handles)
catch
    % http://jp.mathworks.com/help/matlab/ref/dialog.html
    d = dialog('Position',[300 300 250 150],...
        'Name','Warning: pushbuttonConnect_Callback');
    txt = uicontrol('Parent',d,...
        'Style','text',...
        'Position',[20 80 210 40],...
        'String','Connecton failed. Please retry.');
    btn = uicontrol('Parent',d,...
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
handles.editIpAddress.Enable                  = 'on';
handles.editId.Enable                         = 'on';
handles.editPassword.Enable                   = 'on';
handles.pushbuttonConnect.Enable              = 'on';
handles.textNoConnection.Enable               = 'on';
handles.textReady.Enable                      = 'off';
handles.textInProcess.Enable                  = 'off';
handles.popupmenuAvailableResolutions.Enable  = 'on';
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

% Update GUI
hObject.Enable                                = 'off';
handles.pushbuttonStart.Enable                = 'on';
handles.textNoConnection.Enable               = 'off';
handles.textReady.Enable                      = 'on';
handles.textInProcess.Enable                  = 'off';
handles.popupmenuAvailableImageEffects.Enable = 'on';
handles.checkboxHorizontalFlip.Enable         = 'on';
handles.checkboxVerticalFlip.Enable           = 'on';
%
handles.textUparrow.Enable                    = 'off';
handles.textDownarrow.Enable                  = 'off';
handles.textLeftarrow.Enable                  = 'off';
handles.textRightarrow.Enable                 = 'off';
handles.textBrake.Enable                      = 'off';
handles.textNeutral.Enable                    = 'off';

% Stop avatar
pause(0.1)
step(handles.piAvatar,'Neutral')

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
hObject.Enable                                = 'off';
handles.pushbuttonStop.Enable                 = 'on';
handles.textNoConnection.Enable               = 'off';
handles.textReady.Enable                      = 'off';
handles.textInProcess.Enable                  = 'on';
handles.popupmenuAvailableResolutions.Enable  = 'off';
handles.popupmenuAvailableImageEffects.Enable = 'off';
handles.checkboxHorizontalFlip.Enable         = 'off';
handles.checkboxVerticalFlip.Enable           = 'off';
%
handles.textUparrow.Enable                    = 'off';
handles.textDownarrow.Enable                  = 'off';
handles.textLeftarrow.Enable                  = 'off';
handles.textRightarrow.Enable                 = 'off';
handles.textBrake.Enable                      = 'off';
handles.textNeutral.Enable                    = 'on';

% Update handles
guidata(hObject,handles)

% Control PiAvatar
axes(handles.axesImage)
precommand = 'Neutral';
step(handles.piAvatar,'Neutral')
while(strcmp(handles.textInProcess.Enable,'on'))
    handles = guidata(hObject);
    curcommand = handles.command;
    try
        if strcmp(curcommand,precommand)
            step(handles.piAvatar,'Snapshot')
        else
            step(handles.piAvatar,curcommand)
            if strcmp(precommand,'Forward')
                handles.textUparrow.Enable    = 'off';
            elseif strcmp(precommand,'Reverse')
                handles.textDownarrow.Enable  = 'off';
            elseif strcmp(precommand,'Turn left')
                handles.textLeftarrow.Enable  = 'off';
            elseif strcmp(precommand,'Turn right')                
                handles.textRightarrow.Enable = 'off';
            elseif strcmp(precommand,'Brake')
                handles.textBrake.Enable      = 'off';
            else
                handles.textNeutral.Enable    = 'off';            
            end
            if strcmp(curcommand,'Forward')
                handles.textUparrow.Enable    = 'on';
            elseif strcmp(curcommand,'Reverse')
                handles.textDownarrow.Enable  = 'on';
            elseif strcmp(curcommand,'Turn left')
                handles.textLeftarrow.Enable  = 'on';
            elseif strcmp(curcommand,'Turn right')                
                handles.textRightarrow.Enable = 'on';
            elseif strcmp(curcommand,'Brake')
                handles.textBrake.Enable      = 'on';
            else
                handles.textNeutral.Enable    = 'on';            
            end            
            precommand = curcommand;
        end
    catch
        % http://jp.mathworks.com/help/matlab/ref/dialog.html
        d = dialog('Position',[300 300 250 150],...
            'Name','Warning: pushbuttonStart_Callback');
        txt = uicontrol('Parent',d,...
            'Style','text',...
            'Position',[20 80 210 40],...
            'String','Communication has failed.');
        btn = uicontrol('Parent',d,...
            'Position',[85 20 70 25],...
            'String','OK',...
            'Callback','delete(gcf)');
        waitfor(d)
    end
    handles.axesImage.Children.CData = handles.piAvatar.img;
    drawnow
end
