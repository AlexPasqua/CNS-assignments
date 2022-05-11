% import the dataset
load NARMA10timeseries.mat
input = cell2mat(NARMA10timeseries.input);
target = cell2mat(NARMA10timeseries.target);

% split data into training, validation and test sets
dev_input = input(1 : 5000);
dev_target = target(1 : 5000);
tr_input = dev_input(1 : 4000);
tr_target = dev_target(1 : 4000);
val_input = dev_input(4001 : end);
val_target = dev_target(4001 : end);
ts_input = input(5001 : end);
ts_target = target(5001 : end);
clear dev_input dev_target

% create ESN
Nr = 50;
inputScaling = 0.1;
rho_desired = 0.1;
[Win, Wr] = esn(inputScaling, 1, Nr, rho_desired);

% train ESN
