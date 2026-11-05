function [] = plot_joint_reps(joint_cell, ILC_subtask_order)
%PLOT_JOINT_REPS Plots the position/ error etc. of each joint over multiple
%iterations
arguments
    joint_cell 
    ILC_subtask_order = []; 
end

num_reps=width(joint_cell);

for type=1:height(joint_cell)
    figure;
    for rep=1:num_reps
        data=joint_cell{type,rep};
        N=height(data);
        timeSeries=(0:N-1)*0.01;
        for i=[1,2,4]
            subplot(2,2,i)
            plot(timeSeries, data(:,i)); hold on
            xlabel('Time (s)');
            ylabel("Joint "+i);
        end
    end

    if (~isempty(ILC_subtask_order))
        subplot(2,2,1); title(subtask_lookup(ILC_subtask_order(type)));
    end
end