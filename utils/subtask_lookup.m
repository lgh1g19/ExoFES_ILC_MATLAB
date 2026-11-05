function [subtask_name] = subtask_lookup(subtask_idx)
%SUBTASK LOOKUP 

subtasks=["WAIT START", "REST TO START", "START TO T1", "REST", "T1 TO START", "START TO REST", "T1 TO END", "END TO START", "FREE MOVEMENT", "START TO T2", "T2 TO START", "T2 TO END", "START TO T3", "T3 TO START", "T3 TO END", "REST NO SUC"];

subtask_name=subtasks(subtask_idx+1);
end