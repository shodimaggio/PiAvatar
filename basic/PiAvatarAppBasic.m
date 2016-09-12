function varargout = PiAvatarAppBasic(varargin)
%PIAVATARAPPBASIC PiAvatarAppBasic.fig 用MATLAB コード
%GUIDE 生成初期化コード（編集不可）
gui_Singleton = 1;
gui_State = struct('gui_Name',  mfilename, ...
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
      
function PiAvatarApp_OpeningFcn(hObject, ~, handles, varargin)
% GUI初期化関数
handles.piAvatar = [];              % PiAvatar参照
handles.piState  = 'No connection'; % 状態初期化
handles.command  = 'Neutral';       % コマンド初期化
handles.output = hObject;
guidata(hObject, handles);          % GUIオブジェクトの更新

function varargout = PiAvatarApp_OutputFcn(hObject, ~, handles)
% GUI出力関数
varargout{1} = handles.output;

function pushbuttonConnect_Callback(hObject, ~, handles)
% Connect ボタンのコールバック関数
ipAddress        = handles.editIpAddress.String;
handles.piAvatar = PiAvatarBasic('IpAddress',ipAddress);
handles.piState  = 'Ready';
handles.pushbuttonConnect.Enable    = 'off';
handles.pushbuttonDisconnect.Enable = 'on';
handles.pushbuttonStart.Enable      = 'on';
% 画像の更新
for iter = 1:5 % カメラ設定を反映するためのアイドリング
   handles.piAvatar.step('Snapshot')
end     
axes(handles.axesImage)       % 画像表示の初期化	       
imshow(handles.piAvatar.img)
guidata(hObject,handles);     % GUIオブジェクトの更新

function figure1_KeyPressFcn(hObject, eventdata, handles)
% キー押下時のコールバック関数 
if strcmp(handles.piState,'In process')
    switch(eventdata.Key)
        case 'uparrow'
            handles.command = 'Forward';
        case 'downarrow'
            handles.command = 'Reve rse';
        case 'leftarrow'
            handles.command = 'Turn left';
        case 'rightarrow'
            handles.command = 'Turn right';
        case 'space'
            handles.command = 'Brake';
    end
    guidata(hObject,handles); % GUIオブジェクトの更新
end

function figure1_KeyReleaseFcn(hObject, ~, handles)
% キー解放時のコールバック関数 
if strcmp(handles.piState,'In process')
    handles.command = 'Neutral';
    guidata(hObject,handles); % GUIオブジェクトの更新
end

function pushbuttonStart_Callback(hObject, ~, handles)
% Start ボタンのコールバック関数
handles.piState = 'In process';
handles.pushbuttonStart.Enable       = 'off';
handles.pushbuttonStop.Enable        = 'on';
handles.pushbuttonDisconnect.Enable  = 'off';
guidata(hObject,handles); % GUIオブジェクトの更新
% PiAvatarの制御
precommand = 'Neutral';
handles.piAvatar.step('Neutral')
while(strcmp(handles.piState,'In process'))
    handles = guidata(hObject);
    curcommand = handles.command;
    if strcmp(curcommand,precommand)
        handles.piAvatar.step('Snapshot')
    else
        handles.piAvatar.step(curcommand)
        precommand = curcommand;
    end
    % 表示画像の更新
    img_ = handles.piAvatar.img;
    handles.axesImage.Children.CData = img_;
end

function pushbuttonStop_Callback(hObject, ~, handles)
% Stop ボタンのコールバック関数
handles.piState = 'Ready';
handles.command = 'Neutral';
handles.pushbuttonStop.Enable       = 'off';
handles.pushbuttonStart.Enable      = 'on';
handles.pushbuttonDisconnect.Enable = 'on';
guidata(hObject,handles); % GUIオブジェクトの更新

function pushbuttonDisconnect_Callback(hObject, ~, handles)
% Disconnect ボタンのコールバック関数
handles.piAvatar = [];
handles.piState = 'No connection';
handles.pushbuttonDisconnect.Enable = 'off';
handles.pushbuttonConnect.Enable    = 'on';
handles.pushbuttonStart.Enable      = 'off';
guidata(hObject,handles); % GUIオブジェクトの更新

function editIpAddress_Callback(hObject, ~, handles)
% IpAddressテキスト入力のコールバック関数

function editIpAddress_CreateFcn(hObject, ~, handles)
% IpAddressテキスト入力の生成関数
if ispc && isequal(get(hObject,'BackgroundColor'), ...
		   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
