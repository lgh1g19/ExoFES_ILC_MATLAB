function [subtask_phase_name] = subtask_phase_lookup(subtask_phase_idx)
%SUBTASK_PHASE_LOOKUP Summary of this function goes here
%   Detailed explanation goes here

phases=["TO TORQUE", "IMPEDANCE CONTROL","TO POSITION","POSITION CORRECTION","SUBTASK COMPLETE"];

subtask_phase_name=phases(subtask_phase_idx+1);
end