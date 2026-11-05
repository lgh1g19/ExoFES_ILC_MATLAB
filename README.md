This repo contains code for analysing experimental data collected from the new proposed coupled approach to controlling ILC in the AllyArm exoskeleton, and comparing it to the original decoupled approach.

- Before running code add the 'utils/' folder to the MATLAB file path

- When collecting new data, add the .csv files downloaded from exofes.it to the 'Game_data' folder.
- This data can then be processed and converted to a .mat file by running `format_game_data("file_path.csv")`, where the file path specifies the path within the 'Game_data' folder
- Calibration data can be formatted by downloading the .csv file stored on the raspberry pi, and 




## Procedure for running the code
1. First run the general setup procedure to set the minimum and maximum current thresholds, as well as the antigravity
2. You then need to set the current values used for stimulation in the .main file. These are stored in the variables AD_test_currents/ MD_test_currents/ PD_test_currents. Enter whatever values you want to test out, between the pre-set minimum and maximum current levels. Save, re-build, and re-run the file.
3. The calibration procedure should then be run by clicking on button 5 in the Ally interface. (The names of these buttons might change depending on the particular interface being used). This applies the values you set in the previous step to each of the muscles and records the response in the C_cal_data.csv file. You can stop the calibration procedure at any time by clicking the calibration button again
4. Once the calibration is completed you can then run the game as normal. The code will work with the planet game, and should work for the rocket game as well. It might need a few modifications for the astronaut game to ensure that the ILC gains aren't re-updated during the hand-to-mouth movement (this would need checking)
5. The default mode is to run the game with the coupling matrix, but you can switch back to the original approach by clicking on button 6. (this toggles between the two different modes).


## Changes implemented from original approach
The new proposed approach implements two main changes:
- Lifting the assumption that each muscle will activate a single joint, and integrating a 'coupling matrix' into the ILC update to account for this
- Removing the need for the expected muscle to be pre-specified in the exercise map



