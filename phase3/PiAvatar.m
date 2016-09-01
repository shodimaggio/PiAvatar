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
    
    % Public, Nontunable プロパティ
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
        FaceDetection  = true
        SpiCs          = 'CE0'
        SpiMode        = 0
        SpiSpeed       = 1000000
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
        
        % コンストラクタ
        function obj = PiAvatar(varargin)
            setProperties(obj,nargin,varargin{:});
            
            % Raspberry Pi オブジェクト生成
            obj.rpi = raspi(obj.IpAddress,obj.Id,obj.Password);
            
            % ディジタル出力端子(GPIO)初期化
            configurePin(obj.rpi, obj.Motor1In1Pin, 'DigitalOutput');
            configurePin(obj.rpi, obj.Motor1In2Pin, 'DigitalOutput');
            configurePin(obj.rpi, obj.Motor2In1Pin, 'DigitalOutput');
            configurePin(obj.rpi, obj.Motor2In2Pin, 'DigitalOutput');
            configurePin(obj.rpi, obj.Led1Pin,      'DigitalOutput');
            configurePin(obj.rpi, obj.Led2Pin,      'DigitalOutput');
            
            % PiCamera 初期化
            if obj.PiCamera
                obj.cam = cameraboard(obj.rpi,'Resolution',obj.Resolution);
                % 顔検出器の初期化
                if obj.FaceDetection && ...
                        exist('vision.CascadeObjectDetector','class')==8
                    obj.fcd = vision.CascadeObjectDetector;
                end
            else
                obj.FaceDetection = false;
            end
            
            % 加速度センサー(SPI) 初期化
            obj.l3d = spidev(obj.rpi,obj.SpiCs,obj.SpiMode,obj.SpiSpeed);
            
            % サーボモータ(GPIO)の動作を停止
            configurePin(obj.rpi, obj.Pwm0Pin, 'DigitalOutput');
            writeDigitalPin(obj.rpi, obj.Pwm0Pin, 0);
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
                    forward_(obj)
                case 'Reverse'
                    reverse_(obj)
                case 'Turn right'
                    turnRight_(obj)
                case 'Turn left'
                    turnLeft_(obj)
                case 'Brake'
                    brake_(obj)
                case 'Neutral'
                    neutral_(obj)
                case 'Led1On'
                    ledon_(obj,1)
                case 'Led1Off'
                    ledoff_(obj,1)
                case 'Led2On'
                    ledon_(obj,2)
                case 'Led2Off'
                    ledoff_(obj,2)
                case 'Snapshot'
                    if obj.PiCamera
                        img_ = snapshot(obj.cam);
                        if obj.FaceDetection % 顔検出
                            bboxes = step(obj.fcd, img_);
                            obj.img = insertObjectAnnotation(img_, ...
                                'rectangle', bboxes, 'Face');
                        else
                            obj.img = img_;
                        end
                    end
                case 'Acceleration'
                    obj.axl = l3dxyzread_(obj);
                otherwise
                    me = MException('PiAvatar:InvalidCommand',...
                        'Command "%s" is not supported.', command);
                    throw(me);
            end
        end
    end
    
    methods(Access = private)
        
        function forward_(obj) % 前進
            writeDigitalPin(obj.rpi, obj.Motor1In1Pin, 1);
            writeDigitalPin(obj.rpi, obj.Motor1In2Pin, 0);
            writeDigitalPin(obj.rpi, obj.Motor2In1Pin, 1);
            writeDigitalPin(obj.rpi, obj.Motor2In2Pin, 0);
        end
        
        function reverse_(obj) % 後退
            writeDigitalPin(obj.rpi, obj.Motor1In1Pin, 0);
            writeDigitalPin(obj.rpi, obj.Motor1In2Pin, 1);
            writeDigitalPin(obj.rpi, obj.Motor2In1Pin, 0);
            writeDigitalPin(obj.rpi, obj.Motor2In2Pin, 1);
        end
        
        function turnRight_(obj) % 右旋回
            writeDigitalPin(obj.rpi, obj.Motor1In1Pin, 0);
            writeDigitalPin(obj.rpi, obj.Motor1In2Pin, 1);
            writeDigitalPin(obj.rpi, obj.Motor2In1Pin, 1);
            writeDigitalPin(obj.rpi, obj.Motor2In2Pin, 0);
        end
        
        function turnLeft_(obj) % 左旋回
            writeDigitalPin(obj.rpi, obj.Motor1In1Pin, 1);
            writeDigitalPin(obj.rpi, obj.Motor1In2Pin, 0);
            writeDigitalPin(obj.rpi, obj.Motor2In1Pin, 0);
            writeDigitalPin(obj.rpi, obj.Motor2In2Pin, 1);
        end
        
        function brake_(obj) % ブレーキ
            writeDigitalPin(obj.rpi, obj.Motor1In1Pin, 1);
            writeDigitalPin(obj.rpi, obj.Motor1In2Pin, 1);
            writeDigitalPin(obj.rpi, obj.Motor2In1Pin, 1);
            writeDigitalPin(obj.rpi, obj.Motor2In2Pin, 1);
        end
        
        function neutral_(obj) % ニュートラル
            writeDigitalPin(obj.rpi, obj.Motor1In1Pin, 0);
            writeDigitalPin(obj.rpi, obj.Motor1In2Pin, 0);
            writeDigitalPin(obj.rpi, obj.Motor2In1Pin, 0);
            writeDigitalPin(obj.rpi, obj.Motor2In2Pin, 0);
        end
        
        function ledon_(obj,ledNumber)
            % LED 点灯
            if ledNumber == 1     % 白色LED
                writeDigitalPin(obj.rpi, obj.Led1Pin, 1);
            elseif ledNumber == 2 % 赤外線LED
                writeDigitalPin(obj.rpi, obj.Led2Pin, 1);
            end
        end
        
        function ledoff_(obj,ledNumber)
            % LED 消灯
            if ledNumber == 1     % 白色LED
                writeDigitalPin(obj.rpi, obj.Led1Pin, 0);
            elseif ledNumber == 2 % 赤外線LED
                writeDigitalPin(obj.rpi, obj.Led2Pin, 0);
            end
        end
        
        function l3dsetup_(obj)
            adCtrlReg1 = hex2dec('20'); % CTRL_REG1
            diCtrlReg1 = hex2dec('7F');
            writeRead(obj.l3d,[adCtrlReg1 diCtrlReg1]);
        end
        
        function axl = l3dxyzread_(obj)
            rwBit   = hex2dec('80'); % Read
            msBit   = hex2dec('40'); % Multple read
            %
            adOutXl = hex2dec('28');
            spiCom  = bitor(rwBit, msBit,  'uint8');
            spiCom  = bitor(spiCom,adOutXl,'uint8');
            spiCom  = [ spiCom repmat(hex2dec('00'),1,12) ];
            dat     = writeRead(obj.l3d,spiCom);
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
            axl = double([ x -y -z ])/(16*1024); % 重力加速度で正規化
        end
        
    end
    
    methods (Static, Access = private)
        function out = convdata_(high,low)
            out = int32(bitshift(uint16(high),8)+uint16(low));
            if bitand(high,hex2dec('80'))
                out = out - 2*hex2dec('8000'); % 負値への変換
            end
        end
    end
    
end