function [] = plot_error_conv(sum_err_cell, ILC_subtask_order, fig_nums, plot_abs)
%PLOT_ERROR_CONV Plots error convergence over multiple iterations
arguments
    sum_err_cell
    ILC_subtask_order = []
    fig_nums=[]
    plot_abs=1 %Whether to plot absolute value of error
end

if(isempty(fig_nums))
fig_nums=1:height(sum_err_cell);
end

num_reps=width(sum_err_cell);


for type=1:height(sum_err_cell)
    sum_err_arr=zeros(num_reps,4);
    for r=1:num_reps
        sum_err_arr(r,:)=sum_err_cell{type,r}(end,:);
    end
    figure(fig_nums(type));
        for i=[1,2,4]
            subplot(2,2,i)
            if plot_abs
                plot(1:num_reps, abs(sum_err_arr(:,i))); hold on
                ylabel("Joint "+i+" absolute error");
            else
                plot(1:num_reps, sum_err_arr(:,i)); hold on
                ylabel("Joint "+i+" error");
            end
            xlabel('Iterations');
            
        end
        if (~isempty(ILC_subtask_order))
            subplot(2,2,1); title(subtask_lookup(ILC_subtask_order(type)));
        end
end
end
