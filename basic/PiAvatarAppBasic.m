function varargout = PiAvatarAppBasic(varargin)
%PIAVATARAPPBASIC PiAvatarAppBasic.fig �pMATLAB �R�[�h
%GUIDE �����������R�[�h�i�ҏW�s�j
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
% GUI�������֐�
handles.piAvatar = [];              % PiAvatar�Q��
handles.piState  = 'No connection'; % ��ԏ�����
handles.command  = 'Neutral';       % �R�}���h������
handles.output = hObject;
guidata(hObject, handles);          % GUI�I�u�W�F�N�g�̍X�V

function varargout = PiAvatarApp_OutputFcn(hObject, ~, handles)
% GUI�o�͊֐�
varargout{1} = handles.output;

function pushbuttonConnect_Callback(hObject, ~, handles)
% Connect �{�^���̃R�[���o�b�N�֐�
ipAddress        = handles.editIpAddress.String;
handles.piAvatar = PiAvatarBasic('IpAddress',ipAddress);
handles.piState  = 'Ready';
handles.pushbuttonConnect.Enable    = 'off';
handles.pushbuttonDisconnect.Enable = 'on';
handles.pushbuttonStart.Enable      = 'on';
% �摜�̍X�V
for iter = 1:5 % �J�����ݒ�𔽉f���邽�߂̃A�C�h�����O
   handles.piAvatar.step('Snapshot')
end     
axes(handles.axesImage)       % �摜�\���̏�����	       
imshow(handles.piAvatar.img)
guidata(hObject,handles);     % GUI�I�u�W�F�N�g�̍X�V

function figure1_KeyPressFcn(hObject, eventdata, handles)
% �L�[�������̃R�[���o�b�N�֐� 
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
    guidata(hObject,handles); % GUI�I�u�W�F�N�g�̍X�V
end

function figure1_KeyReleaseFcn(hObject, ~, handles)
% �L�[������̃R�[���o�b�N�֐� 
if strcmp(handles.piState,'In process')
    handles.command = 'Neutral';
    guidata(hObject,handles); % GUI�I�u�W�F�N�g�̍X�V
end

function pushbuttonStart_Callback(hObject, ~, handles)
% Start �{�^���̃R�[���o�b�N�֐�
handles.piState = 'In process';
handles.pushbuttonStart.Enable       = 'off';
handles.pushbuttonStop.Enable        = 'on';
handles.pushbuttonDisconnect.Enable  = 'off';
guidata(hObject,handles); % GUI�I�u�W�F�N�g�̍X�V
% PiAvatar�̐���
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
    % �\���摜�̍X�V
    img_ = handles.piAvatar.img;
    handles.axesImage.Children.CData = img_;
end

function pushbuttonStop_Callback(hObject, ~, handles)
% Stop �{�^���̃R�[���o�b�N�֐�
handles.piState = 'Ready';
handles.command = 'Neutral';
handles.pushbuttonStop.Enable       = 'off';
handles.pushbuttonStart.Enable      = 'on';
handles.pushbuttonDisconnect.Enable = 'on';
guidata(hObject,handles); % GUI�I�u�W�F�N�g�̍X�V

function pushbuttonDisconnect_Callback(hObject, ~, handles)
% Disconnect �{�^���̃R�[���o�b�N�֐�
handles.piAvatar = [];
handles.piState = 'No connection';
handles.pushbuttonDisconnect.Enable = 'off';
handles.pushbuttonConnect.Enable    = 'on';
handles.pushbuttonStart.Enable      = 'off';
guidata(hObject,handles); % GUI�I�u�W�F�N�g�̍X�V

function editIpAddress_Callback(hObject, ~, handles)
% IpAddress�e�L�X�g���͂̃R�[���o�b�N�֐�

function editIpAddress_CreateFcn(hObject, ~, handles)
% IpAddress�e�L�X�g���͂̐����֐�
if ispc && isequal(get(hObject,'BackgroundColor'), ...
		   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
