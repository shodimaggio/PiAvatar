classdef SoftPwmOutput < matlab.System ...
        & coder.ExternalDependency ...        
        & matlab.system.mixin.Propagates ...
        & matlab.system.mixin.CustomIcon
    %
    % Write to a SoftPWM output pin
    %
    % References:
    %
    % - https://jp.mathworks.com/matlabcentral/fileexchange/39354-device-drivers
    % - http://wiringpi.com/reference/software-pwm-library/
    %
    % Copyright (c) 2016-, Shogo MURAMATSU, All rights reserved.
    %
    % Contact address: Shogo MURAMATSU,
    %    Faculty of Engineering, Niigata University,
    %    8050 2-no-cho Ikarashi, Nishi-ku,
    %    Niigata, 950-2181, JAPAN
    
    %#codegen 
    properties (Nontunable)
        Pin          = 19
        InitialValue = 0
        PwmRange     = 100
    end
    
    properties (Constant, Hidden)
        AvailablePin =  [4 5 6 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27]
    end    

    methods
        % Constructor
        function obj = SoftPwmOutput(varargin)
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
                ['Invalid value for Pin. ',...
                'Pin must be one of the following: %s'], ...
                sprintf('%d ', obj.AvailablePin));
            obj.Pin = value;
        end
    end
    
    methods (Access=protected)
        function setupImpl(obj)
            % Implement tasks that need to be performed only once,
            if coder.target('Rtw')
                coder.cinclude('softpwmoutput_raspi.h');
                coder.ceval('softPwmOutputSetup', obj.Pin, ...
                    obj.InitialValue, obj.PwmRange);
            end            
        end
        
        function stepImpl(obj,u)
            % Device driver output
            if coder.target('Rtw')
                coder.ceval('writeSoftPwmPin', obj.Pin, u);
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
            icon = sprintf('SoftPWM Write (%d)', obj.Pin);
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
            name = 'SoftPWM Write';
        end
        
        function b = isSupportedContext(context)
            b = context.isCodeGenTarget('rtw');
        end
        
        function updateBuildInfo(buildInfo, context)
            if context.isCodeGenTarget('rtw')
                % Update buildInfo
                rootDir = fullfile(fileparts(mfilename('fullpath')),'.','src');
                buildInfo.addIncludePaths(rootDir);
                buildInfo.addIncludeFiles('softpwmoutput_raspi.h');
                buildInfo.addSourceFiles('softpwmoutput_raspi.c',rootDir);
                buildInfo.addLinkFlags({'-lwiringPi'});
                buildInfo.addLinkFlags({'-lpthread'});
            end
        end
    end
end
