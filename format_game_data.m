function [] = format_game_data(fileName)
%FORMAT_GAME_DATA Takes in data recorded from game and formats it as useful
%Matlab arrays


arguments (Input)
    fileName string
end

opts = detectImportOptions("Game_data/"+fileName, 'NumHeaderLines', 1); 
opts.VariableNamesLine = 1;

T_data=readtable("Game_data/"+fileName, opts);

% timeSeries=T_data{:,1};
% subtask=T_data{:,2};
% subtask_phase=T_data{:,3};
% performance=T_data{:,4};
% working_mode=T_data{:,5:8};
% position=T_data{:,9:12};
% des_pos=T_data{:,13:16};
% speed=T_data{:,17:20};
% torque=T_data{:,21:24};
% current=T_data{:,25:29};
% G=T_data{:,30:35};


full_data.timeSeries=T_data.timestamp;
full_data.subtask=T_data.subtask;
full_data.subtask_phase=T_data.subtask_phase;
full_data.performance=T_data.performance;
full_data.working_mode=[T_data.working_mode_1, T_data.working_mode_2, T_data.working_mode_3, T_data.working_mode_4];
full_data.position=[T_data.pos_1_deg, T_data.pos_2_deg, T_data.pos_3_deg, T_data.pos_4_deg];
full_data.des_pos=[T_data.pos_des_1_deg, T_data.pos_des_2_deg, T_data.pos_des_3_deg, T_data.pos_des_4_deg];
%full_data.target_pos=[T_data.target_pos_1, T_data.target_pos_2, T_data.target_pos_3, T_data.target_pos_4];
full_data.err_sum=[T_data.err_sum_1,T_data.err_sum_2,T_data.err_sum_3,T_data.err_sum_4];
full_data.speed=[T_data.speed_1_deg_per_s, T_data.speed_2_deg_per_s, T_data.speed_3_deg_per_s, T_data.speed_4_deg_per_s];
full_data.torque=[T_data.torque_1_Nm, T_data.torque_2_Nm, T_data.torque_3_Nm, T_data.torque_4_Nm];
full_data.current=[T_data.stim_current_1, T_data.stim_current_2, T_data.stim_current_3, T_data.stim_current_4, T_data.stim_current_5];
full_data.G=[T_data.gain_ILC_1, T_data.gain_ILC_2,T_data.gain_ILC_3,T_data.gain_ILC_4,T_data.gain_ILC_5];
full_data.G_APD=T_data.G_APD;
full_data.C=[T_data.coupling_matrix_1, T_data.coupling_matrix_2, T_data.coupling_matrix_3, T_data.coupling_matrix_4, T_data.coupling_matrix_5, T_data.coupling_matrix_6];
full_data.coupling_flag=[T_data.coupling_flag];
full_data.alpha=T_data.alfa;
full_data.impedance_profile=T_data.impedance_profile;
full_data.middle_stim_dir=T_data.middle_stim_dir;
%full_data.prev_trigger=T_data.prev_trigger;

if all(full_data.coupling_flag==full_data.coupling_flag(1))
    coupling_flag=full_data.coupling_flag(1);
else
    warning("Coupling flag changed mid-game");
    coupling_flag=NaN;
end

if all(full_data.middle_stim_dir==full_data.middle_stim_dir(1))
    middle_stim_dir=full_data.middle_stim_dir(1);
else
    warning("Middle stim direction changed mid-game");
    middle_stim_dir=NaN;
end

% if all(full_data.impedance_profile==full_data.impedance_profile(1))
%     impedance_profile=full_data.impedance_profile(1);
% else
%     warning("Impedance flag changed mid-game");
%     impedance_profile=NaN;
% end

if all(full_data.alpha==full_data.alpha(1))
    alpha=full_data.alpha(1);
else
    warning("ILC gain changed mid-game");
    coupling_flag=NaN;
end

if(all(all(full_data.C==full_data.C(end,:)|full_data.C==zeros(1,6))))
    C=full_data.C(end,:);
else
    warning("Coupling matrix changed mid-game");
    C=nan(1,6);
end

%%% Separate out into ILC trials
% First separate into sub-tasks
num_reps=detect_num_reps(full_data.subtask);

Y=[true; diff(full_data.subtask)~=0];
subtask_idx=full_data.subtask(Y);
full_data.subtask_names=subtask_lookup(subtask_idx);
num_phases=length(subtask_idx);

pos_cell=cell(num_phases,1);
des_pos_cell=cell(num_phases,1);
%target_pos_cell=cell(num_phases,1);
err_cell=cell(num_phases,1);
err_sum_cell=cell(num_phases,1);
subtask_phase_cell=cell(num_phases,1);
subtask_cell=cell(num_phases,1);
%prev_trigger_cell=cell(num_phases,1);

current_cell=cell(num_phases,1);
G_cell=cell(num_phases,1);
G_APD_cell=cell(num_phases,1);
%beta_patterns_cell=cell(num_phases,1);
work_mode_cell=cell(num_phases,1);

ptr=1;
len_phase=1;
p=1; % Current sub-task phase
while (ptr+len_phase<=height(full_data.position))
    while full_data.subtask(ptr+len_phase)==full_data.subtask(ptr)
        len_phase=len_phase+1;

        if(ptr+len_phase>height(full_data.position))
            break;
        end
    end
    pos_cell{p}=full_data.position(ptr:ptr+len_phase-1,:);
    des_pos_cell{p}=full_data.des_pos(ptr:ptr+len_phase-1,:);
    %target_pos_cell{p}=full_data.target_pos(ptr:ptr+len_phase-1,:);
    current_cell{p}=full_data.current(ptr:ptr+len_phase-1,:);
    %beta_patterns_cell{p}=full_data.beta_patterns(ptr:ptr+len_phase-1,:);
    G_cell{p}=full_data.G(ptr:ptr+len_phase-1,:);
    G_APD_cell{p}=full_data.G_APD(ptr:ptr+len_phase-1,:);
    err_sum_cell{p}=full_data.err_sum(ptr:ptr+len_phase-1,:);
    work_mode_cell{p}=full_data.working_mode(ptr:ptr+len_phase-1,:);
    subtask_phase_cell{p}=full_data.subtask_phase(ptr:ptr+len_phase-1,:);
    subtask_cell{p}=full_data.subtask(ptr:ptr+len_phase-1,:);
    %prev_trigger_cell{p}=full_data.prev_trigger(ptr:ptr+len_phase-1,:);

    ptr=ptr+len_phase;
    len_phase=1;
    p=p+1;
end

for p=1:num_phases
    err_cell{p}=pos_cell{p}-des_pos_cell{p};
end

%Extract only the sub-tasks where ILC is being applied, then rearrange these
%cell arrays so that each row corresponds to various repeats of the same movement
ILC_subtasks=subtask_idx(is_ILC_subtask(subtask_idx));
subtask_names_ILC=subtask_lookup(ILC_subtasks);

%%% Need to format subtask names as well

subtask_phase_cell_ILC=format_cell_arr(subtask_phase_cell(is_ILC_subtask(subtask_idx)),ILC_subtasks);
subtask_cell_ILC=format_cell_arr(subtask_cell(is_ILC_subtask(subtask_idx)),ILC_subtasks);
des_pos_cell_ILC=format_cell_arr(des_pos_cell(is_ILC_subtask(subtask_idx)),ILC_subtasks);
%target_pos_cell_ILC=format_cell_arr(target_pos_cell(is_ILC_subtask(subtask_idx)),ILC_subtasks);
pos_cell_ILC=format_cell_arr(pos_cell(is_ILC_subtask(subtask_idx)),ILC_subtasks);
curr_cell_ILC=format_cell_arr(current_cell(is_ILC_subtask(subtask_idx)),ILC_subtasks);
%b_pat_cell_ILC=format_cell_arr(beta_patterns_cell(is_ILC_subtask(subtask_idx)),ILC_subtasks);
err_cell_ILC=format_cell_arr(err_cell(is_ILC_subtask(subtask_idx)),ILC_subtasks);
G_cell_ILC=format_cell_arr(G_cell(is_ILC_subtask(subtask_idx)),ILC_subtasks);
G_APD_cell_ILC=format_cell_arr(G_APD_cell(is_ILC_subtask(subtask_idx)),ILC_subtasks);
err_sum_cell_ILC=format_cell_arr(err_sum_cell(is_ILC_subtask(subtask_idx)),ILC_subtasks);
%prev_trigger_cell_ILC=format_cell_arr(prev_trigger_cell(is_ILC_subtask(subtask_idx)),ILC_subtasks);

to_extract_cell=cell(size(pos_cell_ILC));
%Extract only the part of the array where we're in impedance control mode
for r=1:num_reps
    for task=1:length(unique(ILC_subtasks))
        to_extract_cell{task,r}=(subtask_phase_cell_ILC{task,r}==1); % Ideally we want these to all be the same length
    end
end

% This ensures all intervals are the same length
interval_lens=cellfun(@nnz,to_extract_cell);

        
for r=1:num_reps
    for task=1:length(unique(ILC_subtasks))
        min_len=min(interval_lens(task,:));
        to_extract_full=find(to_extract_cell{task,r});
        to_extract=to_extract_full(end-min_len+1:end);

        des_pos_cell_ILC{task,r}=des_pos_cell_ILC{task,r}(to_extract,:);
        %target_pos_cell_ILC{task,r}=target_pos_cell_ILC{task,r}(to_extract,:);
        pos_cell_ILC{task,r}=pos_cell_ILC{task,r}(to_extract,:);
        curr_cell_ILC{task,r}=curr_cell_ILC{task,r}(to_extract,:);
        %b_pat_cell_ILC{task,r}=b_pat_cell_ILC{task,r}(to_extract,:);
        err_cell_ILC{task,r}=err_cell_ILC{task,r}(to_extract,:);
        G_cell_ILC{task,r}=G_cell_ILC{task,r}(to_extract,:);
        G_APD_cell_ILC{task,r}=G_APD_cell_ILC{task,r}(to_extract,:);
        err_sum_cell_ILC{task,r}=err_sum_cell_ILC{task,r}(to_extract,:);
        %prev_trigger_cell_ILC{task,r}=prev_trigger_cell_ILC{task,r}(to_extract,:);
    end
end



% Checks to make sure everything is as expected
for r=1:num_reps
    for task=1:length(unique(ILC_subtasks))
        if ~(all(all(abs(des_pos_cell_ILC{task,1}-des_pos_cell_ILC{task,r})<1)))
            warning("Desired position changing between sub-tasks");
            %return
        end

        if ~all(G_cell_ILC{task,r}==G_cell_ILC{task,r}(1,:))
            warning("G values changing over a given iteration");
            return
        end
    end
end



% Get name of file without extension
[folder,name,~]=fileparts(fileName);

if ~isempty(folder)
    folder=folder+"/";
end

ILC_subtask_order=unique(ILC_subtasks);

save("Game_data/"+folder+name+".mat", 'full_data', 'C', 'coupling_flag', 'num_reps', 'alpha','middle_stim_dir', ... %'impedance_profile', ...
         'des_pos_cell_ILC','pos_cell_ILC','curr_cell_ILC','err_cell_ILC','err_sum_cell_ILC', 'G_cell_ILC', 'G_APD_cell_ILC', 'subtask_names_ILC', 'ILC_subtask_order', 'subtask_cell_ILC');
