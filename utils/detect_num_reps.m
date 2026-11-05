function [num_reps, num_distinct_subtasks] = detect_num_reps(subtask_arr)
%DETECT_NUM_REPS Returns the number of repetitions of a movement carried
%out based on the time-series subtask array

Y=[true; diff(subtask_arr)~=0];
subtask_idx=subtask_arr(Y);

ILC_subtasks=subtask_idx(is_ILC_subtask(subtask_idx));

ILC_unique=unique(ILC_subtasks);
num_distinct_subtasks=length(ILC_unique);

if(mod(length(ILC_subtasks), length(ILC_unique))==0)
    num_reps=length(ILC_subtasks)/length(ILC_unique);
else
    warning("Non-integer number of repetitions detected, returning zero");
    num_reps=0;
end

end