%% Plot Sperm Trajectories with Tail
% Mustafa U. Daloglu - 3/8/15

function [ skipped_tails ] = tail_plot_3d( tracksSimple, tail_tracks )
% tracksSimple contains the x,y,z coordinates of sperm trajectories
    


    % Tails with 'min_tail' or smaller number of nodes will not be plotted
    min_tail = 4; 

            
    track_num = length(tracksSimple);
    
    % Keep track of the framed where the tail was too short
    skipped_tails = repmat(skipped_tail_3d(),track_num,1);
    
    figure
    axis equal
    hold on
    
    % For each individual track
    for i = 1: track_num;
        tracksSimple(i).coor(:,1:2) = tracksSimple(i).coor(:,1:2)*(1.12/4)
    
        track_i = tracksSimple(i).coor;
%         track_i(1:2) = track_i(1:2)*(1.12/4);
        
        track_length_i = length(track_i(:,1));
        beg_frame = tracksSimple(i).start_frame;
        
        tail_list_i = tail_tracks{i};
        
        % Plot 3D head locations
        frames = beg_frame:track_length_i+beg_frame-1;
        plot3(track_i(:,1),track_i(:,2),track_i(:,3),'O','LineWidth',2)
%         for j=1:track_length_i
%             h = text(track_i(j,1),track_i(j,2),track_i(j,3),num2str(frames(j)),'FontSize',14);
%         end
        % For each point in the track
        color_map = jet(track_length_i);
        for j=1:track_length_i
                    
            
            tail_j = tail_list_i(j).mat;
            
            tail_length_j = length(tail_j(:,1));
            
            if(tail_length_j<min_tail)
                                
                display(['Too short tail: Frame #',int2str(j),' of Track #',int2str(i)])
        
                frame_hold = skipped_tails(i).frames;
                
                frame_hold(end+1) = j;
                
                skipped_tails(i).frames = frame_hold;
        
                continue               
            end
        
            
            % Attach the tail origin to the head
            tail_j = tail_j + repmat(track_i(j,:),tail_length_j,1) - ...
                repmat(tail_j(1,:),tail_length_j,1);
            
            % Plot tail for frame (or sperm head) #j of traj. #i
            plot3(tail_j(:,1),tail_j(:,2),tail_j(:,3),'color',color_map(j,:), 'LineWidth',2)
            
        end
        
        
        
    end
    
    
    xlabel('x (um)')
    ylabel('y (um)')
    zlabel('z (um)')
    title('Sperm Trajectories with Tails in 3D')
    grid on


end

