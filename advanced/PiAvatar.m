classdef PiAvatar < matlab.System
    % PIAVATAR
    %
    % Copyright (c) 2016-, Shogo MURAMATSU
    %
    % All rights reserved.
    %
    % Contact address: Shogo MURAMATSU,
    %    Faculty of Engineering, Niigata University,
    %    8050 2-no-cho Ikarashi, Nishi-ku,
    %    Niigata, 950-2181, JAPAN
    
    % Public, Nontunable �v���p�e�B
    properties (Nontunable)
        IpAddress      = ''
        Id             = 'pi'
        Password       = 'raspberry'
        Pwm0Pin        = 18
        Motor1In1Pin   = 19
        Motor1In2Pin   = 20
        Motor2In1Pin   = 21
        Motor2In2Pin   = 26
        Led1Pin        = 24
        Led2Pin        = 23
        PiCamera       = false
        Resolution     = '640x480'
        ImageEffect    = 'none'
        HorizontalFlip = false
        VerticalFlip   = false
        FaceDetection  = false
        SpiCs          = 'CE0'
        SpiMode        = 0
        SpiSpeed       = 1000000
    end
    
    properties
        HistogramEq    = false
    end
    
    %properties(DiscreteState)
    %end
    
    properties(Hidden, GetAccess = public, SetAccess = private)
        rpi
        cam
        l3d
        fcd
        img
        axl
    end
    
    methods
        
        % �R���X�g���N�^
        function obj = PiAvatar(varargin)
            setProperties(obj,nargin,varargin{:});
            
            % Raspberry Pi �I�u�W�F�N�g����
            obj.rpi = raspi(obj.IpAddress,obj.Id,obj.Password);
            
            % �f�B�W�^���o�͒[�q(GPIO)������
            obj.rpi.configurePin(obj.Motor1In1Pin, 'DigitalOutput');
            obj.rpi.configurePin(obj.Motor1In2Pin, 'DigitalOutput');
            obj.rpi.configurePin(obj.Motor2In1Pin, 'DigitalOutput');
            obj.rpi.configurePin(obj.Motor2In2Pin, 'DigitalOutput');
            obj.rpi.configurePin(obj.Led1Pin,      'DigitalOutput');
            obj.rpi.configurePin(obj.Led2Pin,      'DigitalOutput');
            
            % PiCamera ������
            if obj.PiCamera
                obj.cam = obj.rpi.cameraboard('Resolution',obj.Resolution);
                % �猟�o��̏�����
                if obj.FaceDetection && ...
                        exist('vision.CascadeObjectDetector','class')==8
                    obj.fcd = vision.CascadeObjectDetector;
                end
            else
                obj.FaceDetection = false;
            end
            
            % �����x�Z���T�[(SPI) ������
            obj.l3d = obj.rpi.spidev(obj.SpiCs,obj.SpiMode,obj.SpiSpeed);
            
            % �T�[�{���[�^(GPIO)�̓�����~
            obj.rpi.configurePin(obj.Pwm0Pin, 'DigitalOutput');
            obj.rpi.writeDigitalPin(obj.Pwm0Pin, 0);
        end
    end
    
    methods(Access = protected)
        
        function setupImpl(obj)
            obj.cam.ImageEffect    = obj.ImageEffect;
            obj.cam.HorizontalFlip = obj.HorizontalFlip;
            obj.cam.VerticalFlip   = obj.VerticalFlip;
            %
            l3dsetup_(obj);
        end
        
        function stepImpl(obj,command)
            
            switch(command)
                case 'Forward'
                    obj.forward_()
                case 'Reverse'
                    obj.reverse_()
                case 'Turn right'
                    obj.turnRight_()
                case 'Turn left'
                    obj.turnLeft_()
                case 'Brake'
                    obj.brake_()
                case 'Neutral'
                    obj.neutral_()
                case 'Led1On'
                    obj.ledon_(1)
                case 'Led1Off'
                    obj.ledoff_(1)
                case 'Led2On'
                    obj.ledon_(2)
                case 'Led2Off'
                    obj.ledoff_(2)
                case 'Snapshot'
                    if obj.PiCamera
                        img_ = obj.cam.snapshot();
                        if obj.HistogramEq   % �q�X�g�O�����ϓ���
                            img_ = rgb2hsv(img_);
                            img_(:,:,3) = histeq(img_(:,:,3));
                            img_ = hsv2rgb(img_);
                        end                        
                        if obj.FaceDetection % �猟�o
                            bboxes = obj.fcd.step(img_);
                            img_ = insertObjectAnnotation(img_, ...
                                'rectangle', bboxes, 'Face');
                        end
                        obj.img = img_;
                    end
                case 'Acceleration'
                    obj.axl = obj.l3dxyzread_();
                otherwise
                    me = MException('PiAvatar:InvalidCommand',...
                        'Command "%s" is not supported.', command);
                    throw(me);
            end
        end
    end
    
    methods(Access = private)
        
        function forward_(obj) % �O�i
            obj.motor1_(1,0);
            obj.motor2_(1,0);
        end

        function neutral_(obj) % �j���[�g����
            obj.motor1_(0,0);
            obj.motor2_(0,0);
        end	
        
        function reverse_(obj) % ���
            obj.motor1_(0,1);
            obj.motor2_(0,1);
        end	
        
        function turnRight_(obj) % �E����
            obj.motor1_(0,1);
            obj.motor2_(1,0);
        end	
        
        function turnLeft_(obj) % ������
            obj.motor1_(1,0);
            obj.motor2_(0,1);
        end	
        
        function brake_(obj) % �u���[�L
            obj.motor1_(1,1);
            obj.motor2_(1,1);
        end	
        
        function motor1_(obj,in1,in2) % DC���[�^1
            obj.rpi.writeDigitalPin(obj.Motor1In1Pin, in1);
            obj.rpi.writeDigitalPin(obj.Motor1In2Pin, in2);
        end	
        
        function motor2_(obj,in1,in2)  % DC���[�^2
            obj.rpi.writeDigitalPin(obj.Motor2In1Pin, in1);
            obj.rpi.writeDigitalPin(obj.Motor2In2Pin, in2);
        end	   
        
        function ledon_(obj,ledNumber)
            % LED �_��
            if ledNumber == 1     % ���FLED
                obj.rpi.writeDigitalPin(obj.Led1Pin, 1);
            elseif ledNumber == 2 % �ԊO��LED
                obj.rpi.writeDigitalPin(obj.Led2Pin, 1);
            end
        end
        
        function ledoff_(obj,ledNumber)
            % LED ����
            if ledNumber == 1     % ���FLED
                obj.rpi.writeDigitalPin(obj.Led1Pin, 0);
            elseif ledNumber == 2 % �ԊO��LED
                obj.rpi.writeDigitalPin(obj.Led2Pin, 0);
            end
        end
        
        function l3dsetup_(obj)
            adCtrlReg1 = hex2dec('20'); % CTRL_REG1
            diCtrlReg1 = hex2dec('7F');
            obj.l3d.writeRead([adCtrlReg1 diCtrlReg1]);
        end
        
        function axl = l3dxyzread_(obj)
            rwBit   = hex2dec('80'); % Read
            msBit   = hex2dec('40'); % Multple read
            %
            adOutXl = hex2dec('28');
            spiCom  = bitor(rwBit, msBit,  'uint8');
            spiCom  = bitor(spiCom,adOutXl,'uint8');
            spiCom  = [ spiCom repmat(hex2dec('00'),1,12) ];
            dat     = obj.l3d.writeRead(spiCom);
            xl = dat(3);
            xh = dat(5);
            x = obj.convdata_(xh,xl);
            yl = dat(7);
            yh = dat(9);
            y = obj.convdata_(yh,yl);
            zl = dat(11);
            zh = dat(13);
            z = obj.convdata_(zh,zl);
            %
            axl = double([ x -y -z ])/(16*1024); % �d�͉����x�Ő��K��
        end
        
    end
    
    methods (Static, Access = private)
        function out = convdata_(high,low)
            out = int32(bitshift(uint16(high),8)+uint16(low));
            if bitand(high,hex2dec('80'))
                out = out - 2*hex2dec('8000'); % ���l�ւ̕ϊ�
            end
        end
    end
    
end