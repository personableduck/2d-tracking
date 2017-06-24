%Structure for the frames that are skipped because the tail was too short
%Written by Mustafa U. Daloglu, 2015, Ozcan Lab


classdef skipped_tail_3d
    
    properties
        frames                 %Skipped frames
    end
    
    methods
        function obj = skipped_tail_3d()
            obj.frames  = [];
        end
    end
end