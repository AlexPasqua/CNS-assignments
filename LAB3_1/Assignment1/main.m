% import the dataset
load("NARMA10timeseries.mat");
input = cell2mat(NARMA10timeseries.input);
target = cell2mat(NARMA10timeseries.target);

% split data into training, validation and test sets
[tr_input, tr_target, val_input, val_target, ts_input, ts_target] = ...
    train_val_test_split(input, target, 4000, 1000);

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
    
    % prepare the time series for the two nets
    [tdnn_Xs, tdnn_Xi, tdnn_Ai, tdnn_Ts, tdnn_EWs, tdnn_shift] = ...
        preparets(tdnn, tr_input, tr_target);
%     [rnn_Xs, rnn_Xi, rnn_Ai, rnn_Ts, rnn_EWs, rnn_shift] = ...
%         preparets(rnn, tr_input, tr_target);
%     
%     % train the nets
%     [trained_tdnn, tdnn_hist] = train(tdnn, tdnn_Xs, tdnn_Ts);
%     [trained_rnn, rnn_hist] = train(rnn, rnn_Xs, rnn_Ts);
end