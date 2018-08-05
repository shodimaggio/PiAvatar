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
drawnow

function varargout = PiAvatarApp_OutputFcn(~, ~, handles)
% GUI�o�͊֐�
varargout{1} = handles.output;

function pushbuttonConnect_Callback(hObject, ~, handles)
%fprintf('pushbuttonConnect\n')
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
drawnow

function figure1_KeyPressFcn(hObject, eventdata, handles)
%fprintf('figure1_KeyPressFcn\n')
% �L�[�������̃R�[���o�b�N�֐� 
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
    end
    guidata(hObject,handles); % GUI�I�u�W�F�N�g�̍X�V
    drawnow
end

function figure1_KeyReleaseFcn(hObject, ~, handles)
% �L�[������̃R�[���o�b�N�֐� 
if strcmp(handles.piState,'In process')
    handles.command = 'Neutral';
    guidata(hObject,handles); % GUI�I�u�W�F�N�g�̍X�V
    drawnow
end

function pushbuttonStart_Callback(hObject, ~, handles)
%fprintf('pushbuttonStart_Callback\n')
% Start �{�^���̃R�[���o�b�N�֐�
handles.piState = 'In process';
handles.pushbuttonStart.Enable       = 'off';
handles.pushbuttonStop.Enable        = 'on';
handles.pushbuttonDisconnect.Enable  = 'off';
guidata(hObject,handles); % GUI�I�u�W�F�N�g�̍X�V
drawnow
% PiAvatar�̐���
precommand = 'Neutral';
handles.piAvatar.step('Neutral')
while(strcmp(handles.piState,'In process'))
    handles = guidata(hObject);
    drawnow
    curcommand = handles.command
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
%fprintf('pushbuttonStop\n')
% Stop �{�^���̃R�[���o�b�N�֐�
handles.piState = 'Ready';
handles.command = 'Neutral';
handles.pushbuttonStop.Enable       = 'off';
handles.pushbuttonStart.Enable      = 'on';
handles.pushbuttonDisconnect.Enable = 'on';
guidata(hObject,handles); % GUI�I�u�W�F�N�g�̍X�V
drawnow

function pushbuttonDisconnect_Callback(hObject, ~, handles)
%fprintf('pushbuttonDisconnect\n')
% Disconnect �{�^���̃R�[���o�b�N�֐�
handles.piAvatar = [];
handles.piState = 'No connection';
handles.pushbuttonDisconnect.Enable = 'off';
handles.pushbuttonConnect.Enable    = 'on';
handles.pushbuttonStart.Enable      = 'off';
guidata(hObject,handles); % GUI�I�u�W�F�N�g�̍X�V
drawnow

function editIpAddress_Callback(~, ~, ~)
% IpAddress�e�L�X�g���͂̃R�[���o�b�N�֐�

function editIpAddress_CreateFcn(hObject, ~, ~)
% IpAddress�e�L�X�g���͂̐����֐�
if ispc && isequal(get(hObject,'BackgroundColor'), ...
		   get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbuttonStart.
function pushbuttonStart_ButtonDownFcn(hObject, eventdata, handles)
%fprintf('pushbuttonStart_ButtonDownFcn\n')
% hObject    handle to pushbuttonStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
