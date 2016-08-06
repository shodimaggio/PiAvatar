classdef PiAvatar < matlab.System
    % PIAVATAR
    %
    
    % Public, Tunable プロパティ
    properties
        IpAddress      = ''
        Id             = 'pi'
        Password       = 'raspberry'
        Motor1In1Pin   = 19 % Explorer pHat
        Motor1In2Pin   = 20
        Motor2In1Pin   = 21
        Motor2In2Pin   = 26
        Resolution     = '640x480'
        ImageEffect    = 'none'
        HorizontalFlip = false
        VerticalFlip   = false
    end
    
    %properties(DiscreteState)
    %end
    
    properties(Hidden, GetAccess = public, SetAccess = private)
        rpi
        cam
        img
    end
    
    methods

        % コンストラクタ
        function obj = PiAvatar(varargin)
            setProperties(obj,nargin,varargin{:});
            %
            obj.rpi = raspi(obj.IpAddress,obj.Id,obj.Password);
            %
            configurePin(obj.rpi, obj.Motor1In1Pin, 'DigitalOutput');             
            configurePin(obj.rpi, obj.Motor1In2Pin, 'DigitalOutput');             
            configurePin(obj.rpi, obj.Motor2In1Pin, 'DigitalOutput');             
            configurePin(obj.rpi, obj.Motor2In2Pin, 'DigitalOutput');                         
            %
            obj.cam = cameraboard(obj.rpi,'Resolution',obj.Resolution);
        end
    end
    
    methods(Access = protected)

        function setupImpl(obj)
            obj.cam.ImageEffect    = obj.ImageEffect;
            obj.cam.HorizontalFlip = obj.HorizontalFlip;
            obj.cam.VerticalFlip   = obj.VerticalFlip;
        end
        
        function stepImpl(obj,command)
            if strcmp(command,     'Forward')
                forward_(obj)
            elseif strcmp(command, 'Reverse')
                reverse_(obj)
            elseif strcmp(command, 'Turn right')
                turnRight_(obj)
            elseif strcmp(command, 'Trun left')
                turnLeft_(obj)
            elseif strcmp(command, 'Brake')
                brake_(obj)
            elseif strcmp(command, 'Neutral')
                neutral_(obj)
            elseif strcmp(command, 'Snapshot')
                obj.img = snapshot(obj.cam);
            else
                me = MException('PiAvatar:InvalidCommand',...
                    'Command "%s" is not supported.', command);
                throw(me);
            end
        end
        
        function resetImpl(obj)
        end

    end
    
    methods(Access = private)
        
        function forward_(obj)
            writeDigitalPin(obj.rpi, obj.Motor1In1Pin, 1);
            writeDigitalPin(obj.rpi, obj.Motor1In2Pin, 0);
            writeDigitalPin(obj.rpi, obj.Motor2In1Pin, 1);
            writeDigitalPin(obj.rpi, obj.Motor2In2Pin, 0);
        end
        
        function reverse_(obj)
            writeDigitalPin(obj.rpi, obj.Motor1In1Pin, 0);
            writeDigitalPin(obj.rpi, obj.Motor1In2Pin, 1);
            writeDigitalPin(obj.rpi, obj.Motor2In1Pin, 0);
            writeDigitalPin(obj.rpi, obj.Motor2In2Pin, 1);
        end
        
        function trunRight_(obj)
            writeDigitalPin(obj.rpi, obj.Motor1In1Pin, 1);
            writeDigitalPin(obj.rpi, obj.Motor1In2Pin, 0);
            writeDigitalPin(obj.rpi, obj.Motor2In1Pin, 0);
            writeDigitalPin(obj.rpi, obj.Motor2In2Pin, 1);
        end
        
        function trunLeft_(obj)
            writeDigitalPin(obj.rpi, obj.Motor1In1Pin, 0);
            writeDigitalPin(obj.rpi, obj.Motor1In2Pin, 1);
            writeDigitalPin(obj.rpi, obj.Motor2In1Pin, 1);
            writeDigitalPin(obj.rpi, obj.Motor2In2Pin, 0);
        end
        
        function brake_(obj)
            writeDigitalPin(obj.rpi, obj.Motor1In1Pin, 1);
            writeDigitalPin(obj.rpi, obj.Motor1In2Pin, 1);
            writeDigitalPin(obj.rpi, obj.Motor2In1Pin, 1);
            writeDigitalPin(obj.rpi, obj.Motor2In2Pin, 1);
        end
        
        function neutral_(obj)
            writeDigitalPin(obj.rpi, obj.Motor1In1Pin, 0);
            writeDigitalPin(obj.rpi, obj.Motor1In2Pin, 0);
            writeDigitalPin(obj.rpi, obj.Motor2In1Pin, 0);
            writeDigitalPin(obj.rpi, obj.Motor2In2Pin, 0);
        end
        
    end
end
