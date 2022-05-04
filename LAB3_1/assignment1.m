% import the dataset
load("NARMA10timeseries.mat");
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

% plot the time series
% figure
% plot(input), hold on
% plot(target), hold off
% legend("Input", "Target")

% random search of hyperparameters
n_trials = 10;
max_inputDelay = 10;
max_hiddenSize = 50;
max_n_hiddenLayers = 5;
train_funcs = {'traingd', 'traingdm', 'traingdx', 'trainrp', 'trainlm'};
for i = 1 : n_trials
    % randomly select hyperparameters
    inputDelays = randi(max_inputDelay);
    hiddenSizes = randi(max_hiddenSize, [1 randi(max_n_hiddenLayers)]);
    trainFcn = cell2mat(datasample(train_funcs, 1));
    conf = struct('inputDelays', inputDelays, 'hiddenSizes', hiddenSizes, 'trainFcn', trainFcn);
    
    % time delay neural network
    tdnn = timedelaynet(0:inputDelays, hiddenSizes, trainFcn);
    % view(tdnn)
    
    % recurrent neural network    
    rnn = layrecnet(1, hiddenSizes, trainFcn);
    % view(rnn)
    
    [tdnn_Xs, rdnn_Xi, tdnn_Ai, tdnn_Ts, tdnn_EWs, tdnn_shift] = ...
        preparets(tdnn, tr_input, tr_target);
end