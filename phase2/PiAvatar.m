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
            configurePin(obj.rpi, obj.Led1Pin,      'DigitalOutput');
            configurePin(obj.rpi, obj.Led2Pin,      'DigitalOutput');
            %
            if obj.PiCamera
                obj.cam = cameraboard(obj.rpi,'Resolution',obj.Resolution);
            end
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
            elseif strcmp(command, 'Turn left')
                turnLeft_(obj)
            elseif strcmp(command, 'Brake')
                brake_(obj)
            elseif strcmp(command, 'Neutral')
                neutral_(obj)
            elseif strcmp(command, 'Led1On')
                ledon_(obj,1)
            elseif strcmp(command, 'Led1Off')
                ledoff_(obj,1)
            elseif strcmp(command, 'Led2On')
                ledon_(obj,2)
            elseif strcmp(command, 'Led2Off')
                ledoff_(obj,2)
            elseif obj.PiCamera && strcmp(command, 'Snapshot')
                obj.img = snapshot(obj.cam);
            else
                me = MException('PiAvatar:InvalidCommand',...
                    'Command "%s" is not supported.', command);
                throw(me);
            end
            
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
        
        function turnRight_(obj)
            writeDigitalPin(obj.rpi, obj.Motor1In1Pin, 0);
            writeDigitalPin(obj.rpi, obj.Motor1In2Pin, 1);
            writeDigitalPin(obj.rpi, obj.Motor2In1Pin, 1);
            writeDigitalPin(obj.rpi, obj.Motor2In2Pin, 0);
        end
        
        function turnLeft_(obj)
            writeDigitalPin(obj.rpi, obj.Motor1In1Pin, 1);
            writeDigitalPin(obj.rpi, obj.Motor1In2Pin, 0);
            writeDigitalPin(obj.rpi, obj.Motor2In1Pin, 0);
            writeDigitalPin(obj.rpi, obj.Motor2In2Pin, 1);
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
        
        function ledon_(obj,ledNumber)
            if ledNumber == 1
                writeDigitalPin(obj.rpi, obj.Led1Pin, 1);
            elseif ledNumber == 2
                writeDigitalPin(obj.rpi, obj.Led2Pin, 1);
            end
        end
        
        function ledoff_(obj,ledNumber)
            if ledNumber == 1
                writeDigitalPin(obj.rpi, obj.Led1Pin, 0);
            elseif ledNumber == 2
                writeDigitalPin(obj.rpi, obj.Led2Pin, 0);
            end
        end
        
    end
end