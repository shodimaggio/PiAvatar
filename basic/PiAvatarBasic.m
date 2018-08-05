classdef PiAvatarBasic < matlab.System
    % PIAVATAR（簡易版）

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
        Resolution     = '640x480'
        ImageEffect    = 'none'
    end
    
    properties(Hidden, GetAccess = public, SetAccess = private)
        rpi
        cam
        img
        srv
    end
    
    methods
        % コンストラクタ
        function obj = PiAvatarBasic(varargin)
            setProperties(obj,nargin,varargin{:});
            % Raspberry Pi オブジェクト生成
            obj.rpi = raspi(obj.IpAddress,obj.Id,obj.Password);
            % ディジタル出力端子(GPIO)初期化
            obj.rpi.configurePin(obj.Motor1In1Pin, 'DigitalOutput');
            obj.rpi.configurePin(obj.Motor1In2Pin, 'DigitalOutput');
            obj.rpi.configurePin(obj.Motor2In1Pin, 'DigitalOutput');
            obj.rpi.configurePin(obj.Motor2In2Pin, 'DigitalOutput');
            % PiCamera 初期化
            obj.cam = obj.rpi.cameraboard('Resolution',obj.Resolution);
       
            % サーボモータの設定
            if verLessThan('matlab','9.1')  
                obj.rpi.configurePin(obj.Pwm0Pin, 'DigitalOutput');
                obj.rpi.writeDigitalPin(obj.Pwm0Pin, 0);
                obj.srv = [];
            else
                obj.srv = obj.rpi.servo(obj.Pwm0Pin,...
                    'MaxPulseDuration',2e-3,...
                    'MinPulseDuration',7e-4);
            end
        end
    end
    
    methods(Access = protected)
        
        function setupImpl(obj)
            obj.cam.ImageEffect    = obj.ImageEffect;
            if verLessThan('matlab','9.1')              
                obj.rpi.system('sudo python /home/pi/servoclear.py');                
            else
                att_ = 90;
                obj.srv.writePosition(att_);
            end
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
                case 'Snapshot'
                    obj.img = obj.cam.snapshot();
                otherwise
                    me = MException('PiAvatar:InvalidCommand',...
                        'Command "%s" is not supported.', command);
                    throw(me);
            end
        end
    end
    
    methods(Access = private)
        
        function forward_(obj) % 前進
            obj.motor1_(1,0);
            obj.motor2_(1,0);
        end

        function neutral_(obj) % ニュートラル
            obj.motor1_(0,0);
            obj.motor2_(0,0);
        end	
        
        function reverse_(obj) % 後退
            obj.motor1_(0,1);
            obj.motor2_(0,1);
        end	
        
        function turnRight_(obj) % 右旋回
            obj.motor1_(0,1);
            obj.motor2_(1,0);
        end	
        
        function turnLeft_(obj) % 左旋回
            obj.motor1_(1,0);
            obj.motor2_(0,1);
        end	
        
        function brake_(obj) % ブレーキ
            obj.motor1_(1,1);
            obj.motor2_(1,1);
        end	
        
        function motor1_(obj,in1,in2)  
            obj.rpi.writeDigitalPin(obj.Motor1In1Pin, in1);
            obj.rpi.writeDigitalPin(obj.Motor1In2Pin, in2);
        end	
        
        function motor2_(obj,in1,in2)  
            obj.rpi.writeDigitalPin(obj.Motor2In1Pin, in1);
            obj.rpi.writeDigitalPin(obj.Motor2In2Pin, in2);
        end	        
    end
end
