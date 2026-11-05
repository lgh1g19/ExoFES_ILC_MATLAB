function [] = plot_shoulder_e_norm(sum_err_cell, ILC_subtask_order, fig_nums)
%PLOT_ERROR_CONV Plots convergence of error norm of the two shoulder joints
arguments
    sum_err_cell
    ILC_subtask_order = []
    fig_nums=[]
end

if(isempty(fig_nums))
    fig_nums=1:height(sum_err_cell);
end

num_reps=width(sum_err_cell);


for type=1:height(sum_err_cell)
    err_norm=zeros(num_reps,1);
    for r=1:num_reps
        err_norm(r,:)=norm(sum_err_cell{type,r}(end,1:2));
    end
    figure(fig_nums(type));
    plot(1:num_reps, err_norm); hold on
    ylabel("Shoulder error norm");
    xlabel('Iterations');

    if (~isempty(ILC_subtask_order))
        title(subtask_lookup(ILC_subtask_order(type)));
    end
end
end
