function [] = format_calib_data(fileName)
%FORMAT_CALIB_DATA Format data from C matrix calibration

% Read data from file
opts = detectImportOptions("Calib_data/"+fileName, 'NumHeaderLines', 1); 
opts.VariableNamesLine = 1;

T_data=readtable("Calib_data/"+fileName, opts);

timeSeries=T_data.timestamp;
current=[T_data.stim_current_1, T_data.stim_current_2, T_data.stim_current_3, T_data.stim_current_4, T_data.stim_current_5];
position=[T_data.pos_1_deg, T_data.pos_2_deg];

% Extract currents and mean joint angles from each pulse

N_mean=100;

[q_AD_data, q_MD_data, q_PD_data, ~] = process_stim_cal_data(current, position, N_mean);


% Save data in .mat file


[~,name,~]=fileparts(fileName);
save("Calib_data/"+name+".mat","current","position","timeSeries", "q_AD_data", "q_MD_data", "q_PD_data");
end