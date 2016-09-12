function vargout = PiAvatarAppBasic(varargin)
%PIAVATARAPP �i�ȈՔŁjPiAvatarAppBasic.fig �p��MATLAB �R�[�h�t�@�C��
% GUIDE �����������R�[�h�i�ҏW�s�j
gui_Singleton = 1;
gui_State = struct('gui_Name',  mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @PiAvatarAppBasic_OpeningFcn, ...
    'gui_OutputFcn',  @PiAvatarAppBasic_OutputFcn, ...
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
      
function PiAvatarAppBasic_OpeningFcn(hObject, eventdata, handles, varargin)
% �֐��Ԃ̋��L����ێ�����\���̃f�[�^ handles ��������
handles.piAvatar = [];              % PiAvatar�Q��
handles.piState  = 'No connection'; % ��ԏ�����
handles.command  = 'Neutral';       % �R�}���h������
handles.output = hObject;
guidata(hObject, handles);          % GUI�I�u�W�F�N�g�̍X�V

function varargout = PiAvatarAppBasic_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

function pushbuttonConnect_Callback(hObject, eventdata, handles)
% PiAvatar�@�̂Ƃ̐ڑ��Ə�Ԃ̍X�V
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
% �摜�\���̏�����	      
axes(handles.axesImage)
imshow(handles.piAvatar.img)
% GUI�I�u�W�F�N�g�̍X�V
guidata(hObject,handles) 

function figure1_KeyPressFcn(hObject, eventdata, handles)
%   
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
    guidata(hObject,handles);
end

function figure1_KeyReleaseFcn(hObject, eventdata, handles)
% 
if strcmp(handles.piState,'In process')
    handles.command = 'Neutral';
    guidata(hObject,handles);
end

function pushbuttonStart_Callback(hObject, eventdata, handles)
% 
handles.piState = 'In process';
handles.pushbuttonStart.Enable       = 'off';
handles.pushbuttonStop.Enable        = 'on';
handles.pushbuttonDisconnect.Enable  = 'off';
guidata(hObject,handles)

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
    % �摜�\���X�V
    img_ = handles.piAvatar.img;
    handles.axesImage.Children.CData = img_;
end

function pushbuttonStop_Callback(hObject, eventdata, handles)
% 
handles.piState = 'Ready';
handles.command = 'Neutral';
handles.pushbuttonStop.Enable       = 'off';
handles.pushbuttonStart.Enable      = 'on';
handles.pushbuttonDisconnect.Enable = 'on';
guidata(hObject,handles);

function pushbuttonDisconnect_Callback(hObject, eventdata, handles)
%
handles.piAvatar = [];
handles.piState = 'No connection';
handles.pushbuttonDisconnect.Enable = 'off';
handles.pushbuttonConnect.Enable    = 'on';
handles.pushbuttonStart.Enable      = 'off';
guidata(hObject,handles)

function editIpAddress_Callback(hObject, eventdata, handles)
%

function editIpAddress_CreateFcn(hObject, eventdata, handles)
%
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
