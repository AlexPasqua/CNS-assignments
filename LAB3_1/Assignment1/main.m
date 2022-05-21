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
    lr = rand;
    trainFcn = cell2mat(datasample(train_funcs, 1));
    conf = struct('inputDelays', inputDelays, 'hiddenSizes', hiddenSizes, ...
        'lr', lr, 'trainFcn', trainFcn);
    
    % time delay neural network
    tdnn = timedelaynet(0:inputDelays, hiddenSizes, trainFcn);
    tdnn.divideFcn = "dividetrain";
    tdnn.trainParam.lr = lr;
%     view(tdnn)
    
    % recurrent neural network    
    rnn = layrecnet(1, hiddenSizes, trainFcn);
    rnn.divideFcn = "dividetrain";
    rnn.trainParam.lr = lr;
%     view(rnn)
    
    % prepare the time series for the two nets
    % TDNN training set
    [tdnn_Xs_tr, tdnn_Xi_tr, tdnn_Ai_tr, tdnn_Ts_tr, tdnn_EWs_tr, tdnn_shift] = ...
        preparets(tdnn, num2cell(tr_input), num2cell(tr_target));
    % RNN training set
    [rnn_Xs_tr, rnn_Xi_tr, rnn_Ai_tr, rnn_Ts_tr, rnn_EWs_tr, rnn_shift] = ...
        preparets(rnn, num2cell(tr_input), num2cell(tr_target));
    % TDNN validation set
    [tdnn_Xs_val, tdnn_Xi_val, tdnn_Ai_val, tdnn_Ts_val, tdnn_EWs_val, tdnn_shift] = ...
        preparets(tdnn, num2cell(tr_input), num2cell(tr_target));
    % RNN validation set
    [rnn_Xs_val, rnn_Xi_val, rnn_Ai_val, rnn_Ts_val, rnn_EWs_val, rnn_shift] = ...
        preparets(rnn, num2cell(tr_input), num2cell(tr_target));
    
    % train the nets
    [trained_tdnn, tdnn_hist] = train(tdnn, tdnn_Xs_tr, tdnn_Ts_tr, tdnn_Xi_tr, tdnn_Ai_tr);
    [trained_rnn, rnn_hist] = train(rnn, rnn_Xs_tr, rnn_Ts_tr, rnn_Xi_tr, rnn_Ai_tr);
    
    % validation
    tdnn_val_out = tdnn(tdnn_Xs_val, tdnn_Xi_val, tdnn_Ai_val);
    mse_val = immse(tdnn_val_out, tdnn_Ts_val);
end