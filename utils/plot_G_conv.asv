function [] = plot_G_conv(G_cell, ILC_subtask_order, fig_nums, plot_norm)
%PLOT_ERROR_CONV Plots the value of G over multiple iterations
arguments
    G_cell 
    ILC_subtask_order = [];
    fig_nums=[];
    plot_norm=0;
end
num_reps=width(G_cell);

if(isempty(fig_nums))
fig_nums=1:height(G_cell);
end

for type=1:height(G_cell)
    if plot_norm
        G_arr=zeros(num_reps,1);
    for r=1:num_reps
        G_arr(r)=norm(G_cell{type,r}(end,1:3));
    end
    else
    G_arr=zeros(num_reps,5);
    for r=1:num_reps
        G_arr(r,:)=G_cell{type,r}(end,:);
    end
    end
    figure(fig_nums(type));
    if plot_norm
        plot(1:num_reps, G_arr); hold on
            xlabel('Iterations');
            ylabel("norm of ILC input (||G||_2)");
        title(subtask_lookup(ILC_subtask_order(type)));
    else
        for i=1:5
            subplot(2,3,i)
            plot(1:num_reps, G_arr(:,i)); hold on
            ylim([0,1])
            xlabel('Iterations');
            ylabel("G_"+i);
        end

        if (~isempty(ILC_subtask_order))
            subplot(2,3,1); title(subtask_lookup(ILC_subtask_order(type)));
        end
    end
end
end
