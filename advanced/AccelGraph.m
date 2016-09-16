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
        NumberOfPlots = 4
        CameraPosition = [ 0 0 -8 ]
        CameraTarget   = [ 0 0 0 ]
        XDir           = 'normal'      
        YDir           = 'normal'
        ZDir           = 'normal'
    end

    properties 
        Denoising = 'on'
    end
    
    properties (Hidden)
        seq
        sch
        plh
        txt
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
            obj.sch = scatter3(obj.seq(1,:),obj.seq(2,:),obj.seq(3,:),'o');
            obj.sch.MarkerEdgeColor = 'c';
            obj.sch.MarkerFaceColor = 'm';
            %
            obj.AxesHandle.CameraPosition      = obj.CameraPosition; 
            obj.AxesHandle.CameraPositionMode  = 'manual';
            obj.AxesHandle.CameraTarget        = obj.CameraTarget;
            obj.AxesHandle.CameraTargetMode    = 'manual';
            obj.AxesHandle.CameraUpVectorMode  = 'auto';
            obj.AxesHandle.CameraViewAngle     = 0;
            obj.AxesHandle.CameraViewAngleMode = 'manual';
            obj.AxesHandle.Projection          = 'perspective';
            obj.AxesHandle.Color               = 'none';
            obj.AxesHandle.XLim                = [ -2 2 ];
            obj.AxesHandle.XTick               = -2:2;
            obj.AxesHandle.XDir                = obj.XDir;
            obj.AxesHandle.YLim                = [ -2 2 ];
            obj.AxesHandle.YTick               = -2:2;
            obj.AxesHandle.YDir                = obj.YDir;
            obj.AxesHandle.ZLim                = [ -2 2 ];
            obj.AxesHandle.ZTick               = -2:2;
            obj.AxesHandle.ZDir                = obj.ZDir;
            obj.AxesHandle.Box                 = 'off';
            obj.AxesHandle.XColor              = [ 0 1 0 ];
            obj.AxesHandle.YColor              = [ 0 1 0 ];
            obj.AxesHandle.ZColor              = [ 0 1 0 ];
            obj.AxesHandle.GridColor           = [ 0 1 0 ];
            obj.AxesHandle.LineWidth           = 2;
            %
            %%{
            hold on 
            obj.plh = plot3(...
                [ obj.seq(1,obj.Count) 2                    -2                   ],...
                [ 2                    obj.seq(2,obj.Count) 2                    ],...
                [ 2                    2                    obj.seq(3,obj.Count) ],...
                'o');
            obj.plh.MarkerEdgeColor = 'w';
            obj.plh.MarkerFaceColor = 'k';            
            obj.txt = cell(3,1);
            obj.txt{1} = text(obj.seq(1,obj.Count)+.2, 2.2, 2.2, num2str(obj.seq(1,obj.Count)));
            obj.txt{2} = text(2.2,obj.seq(2,obj.Count)+.2, 2.2, num2str(obj.seq(2,obj.Count)));
            obj.txt{3} = text(-1.8,2.2,obj.seq(1,obj.Count)+.2, num2str(obj.seq(3,obj.Count)));
            for idx = 1:3
                obj.txt{idx}.Color = [ 1 1 0 ];
                obj.txt{idx}.EdgeColor = [ 1 1 1 ];
                obj.txt{idx}.BackgroundColor = [ 0 0 0 ];
            end
            hold off
            %%}            
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
            obj.sch.XData(obj.Count) = data(1);
            obj.sch.YData(obj.Count) = data(2);
            obj.sch.ZData(obj.Count) = data(3);
            %
            obj.plh.XData = [data(1) 2       -2      ];
            obj.plh.YData = [2       data(2) 2      ];
            obj.plh.ZData = [2       2       data(3) ];
            %
            obj.txt{1}.Position = [(data(1)+.2) 2.2 2.2];
            obj.txt{1}.String   = num2str(data(1));
            obj.txt{2}.Position = [2.2 (data(2)+.2) 2.2];
            obj.txt{2}.String   = num2str(data(2));
            obj.txt{3}.Position = [-1.8 2.2 (data(3)+.2)];         
            obj.txt{3}.String   = num2str(data(3));
        end
        
        function resetImpl(obj)
        end
        
    end
    
end
