classdef PwmOutput < matlab.System ...
        & coder.ExternalDependency ...
        & matlab.system.mixin.Propagates ...
        & matlab.system.mixin.CustomIcon
    %
    % Write to a PWM output pin
    %
    % Reference:
    % - https://jp.mathworks.com/matlabcentral/fileexchange/39354-device-drivers
    %
    % Copyright (c) 2016-, Shogo MURAMATSU, All rights reserved.
    %
    % Contact address: Shogo MURAMATSU,
    %    Faculty of Engineering, Niigata University,
    %    8050 2-no-cho Ikarashi, Nishi-ku,
    %    Niigata, 950-2181, JAPAN
    
    %#codegen 
    properties (Nontunable)
        Pin     = 18
        Mode    = 0    % Mode(0:mark:space/1:balance)
        Divisor = 375
        Range   = 1024
    end
    
    properties (Constant, Hidden)
        AvailablePin = [12 13 18 19]
    end    

    methods
        % Constructor
        function obj = PwmOutput(varargin)
            coder.allowpcode('plain');
            
            % Support name-value pair arguments when constructing the object.            
            setProperties(obj,nargin,varargin{:});
        end
        
        function set.Pin(obj,value)
            %  Validation code            
            coder.extrinsic('sprintf') % Do not generate code for sprintf
            validateattributes(value,...
                {'numeric'},...
                {'real', 'positive', 'integer', 'scalar'},...
                '', ...
                'Pin');
            assert(any(value == obj.AvailablePin), ...
                'Invalid value for Pin. Pin must be one of the following: %s', ...
                sprintf('%d ', obj.AvailablePin));
            obj.Pin = value;
        end
    end
    
    methods (Access=protected)
        function setupImpl(obj)
            % Implement tasks that need to be performed only once,
            if coder.target('Rtw')
                coder.cinclude('pwmoutput_raspi.h');
                coder.ceval('pwmOutputSetup', obj.Pin, ...
                    obj.Mode, obj.Divisor, obj.Range);
            end            
        end
        
        function stepImpl(obj,u)
            % Device driver output
            if coder.target('Rtw')
                coder.ceval('writePwmPin', obj.Pin, u);
            end            
        end
        
        function releaseImpl(obj)
            % Termination code
        end
    end
    
    methods(Access = protected) 
        %% Simulink functions
        function num = getNumImputsImpl(~)
            num = 1;
        end
        
        function num = getNumOutputImpl(~)
            num = 0;
        end
        
        function flag = isInputSizeLockedImpl(~,~)
            flag = true;
        end

        function varargout = isInputFixedSizeImpl(~,~)
            varargout{1} = true;
        end
        
        function flag = isInputComplexityLockedImpl(~,~)
            flag = true;
        end
        
        function varargout = isInputComplexImpl(~)
            varargout{1} = false;
        end        
                
        function validateInputsImpl(~,u)
            if isempty(coder.target)
                % Run this always in Simulation
                validateattributes(u,{'numeric'},...
                    {'scalar','nonnegative','integer'},'','u')
            end
        end
        
        function icon = getIconImpl(obj)
            % Define a string as the icon for the System block in Simulink.
            icon = sprintf('PWM Write (%d)', obj.Pin);
        end        
    end
    
    methods (Static, Access=protected)
        function simMode = getSimulateUsingImpl(~)
            simMode = 'Interpreted execution';
        end
        
        function isVisible = showSimulateUsingImpl
            isVisible = false;
        end
    end
    
    methods (Static)
        function name = getDescriptiveName()
            name = 'PWM Write';
        end
        
        function b = isSupportedContext(context)
            b = context.isCodeGenTarget('rtw');
        end
        
        function updateBuildInfo(buildInfo, context)
            if context.isCodeGenTarget('rtw')
                % Update buildInfo
                rootDir = fullfile(fileparts(mfilename('fullpath')),'.','src');
                buildInfo.addIncludePaths(rootDir);
                buildInfo.addIncludeFiles('pwmoutput_raspi.h');
                buildInfo.addSourceFiles('pwmoutput_raspi.c',rootDir);
                buildInfo.addLinkFlags({'-lwiringPi'});
            end
        end
    end
end
