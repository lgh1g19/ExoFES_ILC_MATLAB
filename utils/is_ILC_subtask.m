function [ILC_subtask] = is_ILC_subtask(subtask_idx)
%IS_ILC_SUBTASK Establishes whether a particular subtask has the potential
%to have ILC applied during it

task_names=subtask_lookup(subtask_idx);

ILC_subtask=contains(task_names, "T1") | contains(task_names, "T2")| contains(task_names, "T3"); 

end