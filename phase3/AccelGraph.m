classdef AccelGraph < matlab.System
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
    
    properties (Nontunable)
        AxesHandle
        NumberOfPlots = 8
    end

    properties 
        Denoising = 'on'
    end
    
    properties (Hidden)
        seq
        plh
    end
    
    properties(DiscreteState)
        Count
    end
    
    methods
        % コンストラクタ
        function obj = AccelGraph(varargin)
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
            %
            x = u(1);
            y = u(2);
            z = u(3);
            %
            obj.seq = repmat([x y z].',1,obj.NumberOfPlots);
            obj.Count = 1;            
            obj.plh = scatter3(obj.seq(1,:),obj.seq(2,:),obj.seq(3,:),'o');
            obj.plh.MarkerEdgeColor = 'c';
            obj.plh.MarkerFaceColor = 'm';
            xlabel('X')
            ylabel('Y')
            zlabel('Z')            
            %
            obj.AxesHandle.CameraPosition      = [ 0 0 -8 ];
            obj.AxesHandle.CameraPositionMode  = 'manual';
            obj.AxesHandle.CameraTarget        = [ 0 0 0 ];
            obj.AxesHandle.CameraTargetMode    = 'manual';
            obj.AxesHandle.CameraUpVectorMode  = 'auto';
            obj.AxesHandle.CameraViewAngle     = 0;
            obj.AxesHandle.CameraViewAngleMode = 'manual';
            obj.AxesHandle.Projection          = 'perspective';
            obj.AxesHandle.Color               = 'none';
            obj.AxesHandle.XLim                = [ -2 2 ];
            obj.AxesHandle.XTick               = -2:2;
            obj.AxesHandle.XDir                = 'normal';
            obj.AxesHandle.YLim                = [ -2 2 ];
            obj.AxesHandle.YTick               = -2:2;
            obj.AxesHandle.YDir                = 'normal';            
            obj.AxesHandle.ZLim                = [ -2 2 ];
            obj.AxesHandle.ZTick               = -2:2;
            obj.AxesHandle.ZDir                = 'normal';            
            obj.AxesHandle.Box                 = 'off';
            obj.AxesHandle.XColor              = [ 0 1 0 ];
            obj.AxesHandle.YColor              = [ 0 1 0 ];
            obj.AxesHandle.ZColor              = [ 0 1 0 ];
            obj.AxesHandle.GridColor           = [ 0 1 0 ];
            obj.AxesHandle.LineWidth           = 2;
        end
        
        function stepImpl(obj,u)
            obj.Count = obj.Count+1;
            obj.Count = mod(obj.Count-1,obj.NumberOfPlots)+1;
            obj.seq(:,obj.Count) = u(:);
            if strcmp(obj.Denoising,'on')
                data = mean(obj.seq,2);
            else
                data = u(:);
            end
            obj.plh.XData(obj.Count) = data(1);
            obj.plh.YData(obj.Count) = data(2);
            obj.plh.ZData(obj.Count) = data(3);
        end
        
        function resetImpl(obj)
        end
        
    end
    
end
