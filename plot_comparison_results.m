%% Plot comparison of updated ILC approach against original aproach, with all data related to a particular movement in the same figure



clear all
close all


ppt="005";


 name1=ppt+"_experiment_coupled.mat";
 name2=ppt+"_experiment_original.mat";
 calib_name="C_cal_data_"+ppt+".mat";


load("Game_data/"+name1, 'pos_cell_ILC', 'err_sum_cell_ILC', 'ILC_subtask_order', 'G_cell_ILC','G_APD_cell_ILC', 'C', 'curr_cell_ILC');


err_sum_coupling=err_sum_cell_ILC;
G_coupling=G_cell_ILC;
G_APD_coupling=G_APD_cell_ILC;

load("Game_data/"+name2, 'pos_cell_ILC', 'err_sum_cell_ILC', 'G_cell_ILC','G_APD_cell_ILC');
err_sum_decoupled=err_sum_cell_ILC;
G_decoupled=G_cell_ILC;
G_APD_decoupled=G_APD_cell_ILC;

err_cell_full={err_sum_coupling, err_sum_decoupled};
G_cell_full={G_coupling, G_decoupled};
G_APD_cell_full={G_APD_coupling, G_APD_decoupled};

tasks=[1,3,5];
task_names=["START TO T1", "START TO T2", "START TO T3"];

%%
conv_e_norm=zeros(length(tasks),length(err_cell_full)); %Save the converged error over the final 3 iterations for each movement


for t=1:length(tasks)
    f=figure;
    for e=1:length(err_cell_full) % Run through both approaches

        %%% Error norm plots
        err=err_cell_full{e}(tasks(t),:);
        num_reps=width(err);
        err_full=zeros(num_reps,4);
        e_norm_s=zeros(num_reps,1);
        for r=1:num_reps
            err_full(r,:)=err{r}(end,:);
            e_norm_s(r)=norm(err{r}(end,1:2));
        end

        if(height(e_norm_s)>2)
        conv_e_norm(t,e)=mean(e_norm_s(end-2:end));
        end

        %Plot error convergence
        subplot(2,3,1);
        plot(err_full(:,1), '-o'); hold on;
        xlabel('Iteration');
        ylabel('e_1');
        title(task_names(t));
        title("Horizontal ad/abduction error");


        subplot(2,3,2);
        plot(err_full(:,2), '-o'); hold on;
        xlabel('Iteration');
        ylabel('e_2');
        title("Elevation error");


        subplot(2,3,3);
        plot(e_norm_s, '-o');
        xlabel('Iteration');
        ylabel('||e_1^2+e_2^2||'); hold on;
        title("Combined shoulder error norm");


        %%% ILC input plots

        G=G_cell_full{e}(tasks(t),:);
        num_reps=width(G);
        G_full=zeros(num_reps,5);
        G_norm=zeros(num_reps,1);
        for r=1:num_reps
            G_full(r,:)=G{r}(end,:);
            G_norm(r)=norm(G{r}(end,1:3));
        end

        subplot(2,3,4);
        plot(G_full(:,1), '-o'); hold on;
        ylabel('G_{AD}');
        xlabel('Iteration');
        ylim([0,1]);
        title("Anterior deltoid gain");


        subplot(2,3,5);
        plot(G_full(:,2), '-o'); hold on;
        xlabel('Iteration');
        ylabel('G_{MD}');
        ylim([0,1]);
        title("Medial deltoid gain");

        subplot(2,3,6);
        plot(G_full(:,3), '-o'); hold on;
        ylabel('G_{PD}');
        xlabel('Iteration');
        ylim([0,1]);
        title("Posterior deltoid gain");

    end

    

        subplot(2,3,3)
        yl=ylim;
        ylim([0,yl(2)]);

        for i=1:2
        subplot(2,3,i);
        yline(0,'--');
        end

    subplot(2,3,1);
    legend('New approach', 'Original approach');
end

%% Same idea but plotting elbow data as well

for t=1:length(tasks)
    f=figure;
    for e=1:length(err_cell_full) % Run through both approaches

        %%% Error norm plots
        err=err_cell_full{e}(tasks(t),:);
        num_reps=width(err);
        err_full=zeros(num_reps,4);
        e_norm_s=zeros(num_reps,1);
        e_norm=zeros(num_reps,1);
        for r=1:num_reps
            err_full(r,:)=err{r}(end,:);
            e_norm_s(r)=norm(err{r}(end,1:2));
            e_norm(r)=norm(err{r}(end,[1:2,4]));
        end
        if(height(e_norm_s)>2)
        conv_e_norm(t,e)=mean(e_norm_s(end-2:end));
        end

        %Plot error convergence
        subplot(2,5,1);
        plot(err_full(:,1), '-o'); hold on;
        xlabel('Iteration');
        ylabel('e_1');
        title(task_names(t));
        title("Horizontal ad/abduction error");


        subplot(2,5,2);
        plot(err_full(:,2), '-o'); hold on;
        xlabel('Iteration');
        ylabel('e_2');
        title("Elevation error");


        subplot(2,5,3);
        plot(e_norm_s, '-o');
        xlabel('Iteration');
        ylabel('||e_1^2+e_2^2||'); hold on;
        title("Combined shoulder error norm");

        subplot(2,5,4);
        plot(err_full(:,4), '-o'); hold on;
        xlabel('Iteration');
        ylabel('e_4');
        title("Elbow error");

        subplot(2,5,5);
        plot(e_norm, '-o');
        xlabel('Iteration');
        ylabel('||e_1^2+e_2^2+e_4^2||'); hold on;
        title("Combined error norm");


        %%% ILC input plots

        G=G_cell_full{e}(tasks(t),:);
        num_reps=width(G);
        G_full=zeros(num_reps,5);
        G_norm=zeros(num_reps,1);
        for r=1:num_reps
            G_full(r,:)=G{r}(end,:);
            G_norm(r)=norm(G{r}(end,1:3));
        end

        subplot(2,5,6);
        plot(G_full(:,1), '-o'); hold on;
        ylabel('G_{AD}');
        xlabel('Iteration');
        ylim([0,1]);
        title("Anterior deltoid gain");


        subplot(2,5,7);
        plot(G_full(:,2), '-o'); hold on;
        xlabel('Iteration');
        ylabel('G_{MD}');
        ylim([0,1]);
        title("Medial deltoid gain");

        subplot(2,5,8);
        plot(G_full(:,3), '-o'); hold on;
        ylabel('G_{PD}');
        xlabel('Iteration');
        ylim([0,1]);
        title("Posterior deltoid gain");

        subplot(2,5,9);
        plot(G_full(:,4), '-o'); hold on;
        ylabel('G_{TR}');
        xlabel('Iteration');
        ylim([0,1]);
        title("Triceps gain");

        subplot(2,5,10);
        plot(G_full(:,5), '-o'); hold on;
        ylabel('G_{BI}');
        xlabel('Iteration');
        ylim([0,1]);
        title("Biceps gain");

    end

    for i=[3,5]
        subplot(2,5,i)
        yl=ylim;
        ylim([0,yl(2)]);
    end
        for i=[1:2,4]
        subplot(2,5,i);
        yline(0,'--');
        end

    subplot(2,5,1);
    legend('New approach', 'Original approach');
end



%% Plot calibration results
load("Calib_data\"+calib_name, "q_AD_data", "q_MD_data", "q_PD_data");

figure;
subplot(3,1,1)
scatter(q_AD_data.theta1_arr, q_AD_data.theta2_arr,'x'); hold on
%offset=plot_gradient(q_AD_data.theta1_arr, q_AD_data.theta2_arr,C(1));
%add_stim_direction(q_AD_data.theta1_arr, offset, C(1));
%legend('data','fitted C_1', 'Increased stimulation');
xlabel('\theta_1'); ylabel('\theta_2');
title("Anterior deltoid stimulation");

subplot(3,1,2)
scatter(q_MD_data.theta2_arr, q_MD_data.theta1_arr,'x'); hold on
%offset=plot_gradient(q_MD_data.theta2_arr, q_MD_data.theta1_arr,C(2));
%add_stim_direction(q_MD_data.theta2_arr, offset, C(2));
%legend('data','fitted C_2/C_3');
xlabel('\theta_2'); ylabel('\theta_1');
title("Medial deltoid stimulation");

subplot(3,1,3)
scatter(q_PD_data.theta1_arr,q_PD_data.theta2_arr,'x'); hold on
%offset=plot_gradient(q_PD_data.theta1_arr,q_PD_data.theta2_arr,C(4));
%add_stim_direction(q_PD_data.theta1_arr, offset, C(4));
%legend('data','fitted C_3');
xlabel('\theta_1'); ylabel('\theta_2');
title("Posterior deltoid stimulation");

%%
figure;
subplot(3,2,1)
scatter(q_AD_data.stim_curr, q_AD_data.theta1_arr,'x'); hold on
mc=polyfit(q_AD_data.stim_curr, q_AD_data.theta1_arr,1);
plot(q_AD_data.stim_curr([1,end]),mc(1)*q_AD_data.stim_curr([1,end])+mc(2));
%offset=plot_gradient(q_AD_data.stim_curr, q_AD_data.theta1_arr,C(1));
%legend('data','fitted C_1', 'Increased stimulation');
xlabel('Current'); ylabel('\theta_1');
title("Anterior deltoid stimulation");

subplot(3,2,2)
scatter(q_AD_data.stim_curr, q_AD_data.theta2_arr,'x'); hold on
mc=polyfit(q_AD_data.stim_curr, q_AD_data.theta2_arr,1);
plot(q_AD_data.stim_curr([1,end]),mc(1)*q_AD_data.stim_curr([1,end])+mc(2));
%offset=plot_gradient(q_AD_data.stim_curr, q_AD_data.theta1_arr,C(1));
%legend('data','fitted C_1', 'Increased stimulation');
xlabel('Current'); ylabel('\theta_2');
title("Anterior deltoid stimulation");


subplot(3,2,3)
scatter(q_MD_data.stim_curr, q_MD_data.theta1_arr,'x'); hold on
mc=polyfit(q_MD_data.stim_curr, q_MD_data.theta1_arr,1);
plot(q_MD_data.stim_curr([1,end]),mc(1)*q_MD_data.stim_curr([1,end])+mc(2));
%offset=plot_gradient(q_AD_data.stim_curr, q_AD_data.theta1_arr,C(1));
%legend('data','fitted C_1', 'Increased stimulation');
xlabel('Current'); ylabel('\theta_1');
title("Medial deltoid stimulation");

subplot(3,2,4)
scatter(q_MD_data.stim_curr, q_MD_data.theta2_arr,'x'); hold on
mc=polyfit(q_MD_data.stim_curr, q_MD_data.theta2_arr,1);
plot(q_MD_data.stim_curr([1,end]),mc(1)*q_MD_data.stim_curr([1,end])+mc(2));
%offset=plot_gradient(q_AD_data.stim_curr, q_AD_data.theta1_arr,C(1));
%legend('data','fitted C_1', 'Increased stimulation');
xlabel('Current'); ylabel('\theta_2');
title("Medial deltoid stimulation");

subplot(3,2,5)
scatter(q_PD_data.stim_curr, q_PD_data.theta1_arr,'x'); hold on
mc=polyfit(q_PD_data.stim_curr, q_PD_data.theta1_arr,1);
plot(q_PD_data.stim_curr([1,end]),mc(1)*q_PD_data.stim_curr([1,end])+mc(2));
%offset=plot_gradient(q_AD_data.stim_curr, q_AD_data.theta1_arr,C(1));
%legend('data','fitted C_1', 'Increased stimulation');
xlabel('Current'); ylabel('\theta_1');
title("Posterior deltoid stimulation");

subplot(3,2,6)
scatter(q_PD_data.stim_curr, q_PD_data.theta2_arr,'x'); hold on
mc=polyfit(q_PD_data.stim_curr, q_PD_data.theta2_arr,1);
plot(q_PD_data.stim_curr([1,end]),mc(1)*q_PD_data.stim_curr([1,end])+mc(2));
%offset=plot_gradient(q_AD_data.stim_curr, q_AD_data.theta1_arr,C(1));
%legend('data','fitted C_1', 'Increased stimulation');
xlabel('Current'); ylabel('\theta_2');
title("Posterior deltoid stimulation");
%% 
function [offset]=plot_gradient(x_points, y_points, grad)
x=[min(x_points)-1, max(x_points)+1];

offset=mean(y_points-x_points*grad);
y=x*grad+offset;

plot(x,y);
end

function []=add_stim_direction(x,c,m)
min_x=min(x)+2;
max_x=max(x)-2;
if x(end) > x(1)
    dx = max_x - min_x;
    x_start = min_x;
else
    dx = min_x - max_x;
    x_start = max_x;
end

dy = m*dx;
y_start = m*x_start + c;

% Add arrow
quiver(x_start, y_start, dx, dy, 0, ...
       'Color', 'k', 'LineStyle','--', ...
       'MaxHeadSize', 0.3);
end