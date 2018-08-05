classdef AccelGraphBasic < matlab.System
    % ACCELGRAPH�i�ȈՔŁj
    
    properties (Nontunable)
        AxesHandle
        NumberOfPlots = 4
        CameraPosition = [ 0 0 -8 ]
        CameraTarget   = [ 0 0 0 ]
        XDir           = 'normal'      
        YDir           = 'normal'
        ZDir           = 'normal'
    end

    properties (Hidden)
        seq
        sch
    end
    
    properties(DiscreteState)
        Count
    end
    
    methods
        % �R���X�g���N�^
        function obj = AccelGraphBasic(varargin)
            setProperties(obj,nargin,varargin{:});
            obj.seq = zeros(3,obj.NumberOfPlots);
        end
    end
    
    methods (Access = protected)
        
        function setupImpl(obj,u)
            if isempty(obj.AxesHandle)
                h = figure;
                obj.AxesHandle = axes(h);
            else
                axes(obj.AxesHandle)
            end
            x = u(1);
            y = u(2);
            z = u(3);
            %
            obj.seq = repmat([x y z].',1,obj.NumberOfPlots);
            obj.Count = 1;            
            obj.sch = scatter3(obj.seq(1,:),obj.seq(2,:),obj.seq(3,:),'o');
            obj.sch.MarkerEdgeColor = 'c';
            obj.sch.MarkerFaceColor = 'm';
            %
            obj.AxesHandle.CameraPosition      = obj.CameraPosition;
            obj.AxesHandle.CameraTarget        = obj.CameraTarget;
            obj.AxesHandle.CameraViewAngle     = 0;
            obj.AxesHandle.Projection          = 'perspective';
            obj.AxesHandle.Color               = 'none';            
            obj.AxesHandle.XLim                = [ -2 2 ];
            obj.AxesHandle.YLim                = [ -2 2 ];
            obj.AxesHandle.ZLim                = [ -2 2 ];            
            obj.AxesHandle.XDir                = obj.XDir;
            obj.AxesHandle.YDir                = obj.YDir;
            obj.AxesHandle.ZDir                = obj.ZDir;
            % ���̑��A�e��ݒ�
        end
        
        function stepImpl(obj,u)
            obj.Count = obj.Count+1; % �����I�ɃT���v�������J�E���g
            obj.Count = mod(obj.Count-1,obj.NumberOfPlots)+1; 
            obj.seq(:,obj.Count) = u(:);
            data = mean(obj.seq,2);  % �ߋ�NumberOfPlots�_�����̕���
            obj.sch.XData(obj.Count) = data(1); % �v���b�g�\�����X�V
            obj.sch.YData(obj.Count) = data(2);
            obj.sch.ZData(obj.Count) = data(3);
        end
        
        function resetImpl(obj)
            obj.Count = 1;
        end
        
    end
end
