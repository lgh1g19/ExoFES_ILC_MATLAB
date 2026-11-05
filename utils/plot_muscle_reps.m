function [] = plot_muscle_reps(muscle_cell, ILC_subtask_order)
%PLOT_POSITION_REPS Summary of this function goes here
%   Detailed explanation goes here
arguments
    muscle_cell 
    ILC_subtask_order =[]; 
end
num_reps=width(muscle_cell);

for type=1:height(muscle_cell)
    figure;
    for rep=1:num_reps
        data=muscle_cell{type,rep};
        N=height(data);
        timeSeries=(0:N-1)*0.01;
        for i=1:5
            subplot(2,3,i)
            plot(timeSeries, data(:,i)); hold on
            xlabel('Time (s)');
            ylabel("Muscle "+i);
        end
    end

    if (~isempty(ILC_subtask_order))
            subplot(2,3,1); title(subtask_lookup(ILC_subtask_order(type)));
    end

end


end