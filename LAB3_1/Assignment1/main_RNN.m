% import the dataset
load("NARMA10timeseries.mat");
input = cell2mat(NARMA10timeseries.input);
target = cell2mat(NARMA10timeseries.target);

% split data into training, validation and test sets
[tr_input, tr_target, val_input, val_target, ts_input, ts_target] = ...
    train_val_test_split(input, target, 4000, 1000);

% random search of hyperparameters
n_trials = 10;
max_inputDelay = 20;    % unused, but necessary param for 'get_rand_hyperparametrization'
max_hiddenSize = 20;
max_n_hiddenLayers = 5;
train_funcs = ["traingd", "traingdm", "traingdx", "trainrp", "trainlm"];
best_val_mse = Inf;
for i = 1 : n_trials
    % randomly select hyperparameters
    conf = get_rand_hyperparametrization(max_inputDelay, max_hiddenSize, ...
        max_n_hiddenLayers, train_funcs);
    
    % recurrent neural network    
    rnn = layrecnet(1, conf.hiddenSizes, conf.trainFcn);
    rnn.divideFcn = "dividetrain";
    rnn.trainParam.lr = conf.lr;
    % view(rnn)
    
    % prepare the time series for the two nets
    % RNN training set
    [Xs_tr, Xi_tr, Ai_tr, Ts_tr, ~, ~] = ...
        preparets(rnn, num2cell(tr_input), num2cell(tr_target));
    % RNN validation set
    [Xs_val, Xi_val, Ai_val, Ts_val, ~, ~] = ...
        preparets(rnn, num2cell(tr_input), num2cell(tr_target));
        
    % train RNN
    [trained_rnn, ~] = train(rnn, Xs_tr, Ts_tr, Xi_tr, Ai_tr);
    tr_out = trained_rnn(Xs_tr, Xi_tr, Ai_tr);
    tr_mse = immse(cell2mat(tr_out), cell2mat(Ts_tr));
    
    % validation
    val_out = trained_rnn(Xs_val, Xi_val, Ai_val);
    val_mse = immse(cell2mat(val_out), cell2mat(Ts_val));
    if val_mse < best_val_mse
        % at the first time step, this condition will be true
        best_val_mse = val_mse;
        best_tr_mse = tr_mse;
        best_conf = conf;
    end
end

% best RNN on validation
best_rnn = layrecnet(1, best_conf.hiddenSizes, best_conf.trainFcn);
rnn.divideFcn = "dividetrain";
rnn.trainParam.lr = best_conf.lr;
view(best_rnn)

% train best RNN on the whole design (tr + val) set
des_input = [tr_input, val_input];
des_target = [tr_target, val_target];
[Xs_des, Xi_des, Ai_des, Ts_des, ~, ~] = ...
    preparets(best_rnn, num2cell(des_input), num2cell(des_target));
[trained_rnn, rnn_hist] = train(best_rnn, Xs_des, Ts_des, Xi_des, Ai_des);
des_out = trained_rnn(Xs_des, Xi_des, Ai_des);
des_mse = immse(cell2mat(des_out), cell2mat(Ts_des));

% save training record
save(fullfile("results", "RNN", "RNN_tr_record.mat"), "rnn_hist");

% test best RNN on test set
[Xs_ts, Xi_ts, Ai_ts, Ts_ts, ~, ~] = ...
    preparets(best_rnn, num2cell(ts_input), num2cell(ts_target));
ts_out = trained_rnn(Xs_ts, Xi_ts, Ai_ts);
ts_mse = immse(cell2mat(ts_out), cell2mat(Ts_ts));

% save results
save(fullfile("results", "RNN", "RNN_MSEs.mat"), ...
    "best_tr_mse", "best_val_mse", "des_mse", "ts_mse")


% PLOTS -------------------------------------------------------------------
% RNN learning curve
learning_curve = figure;
plot(rnn_hist.perf)
title("RNN learning curve on design set (tr+val)")
xlabel("Epochs")
ylabel("MSE")
saveas(learning_curve, fullfile("results", "RNN", "RNN_learning_curve.fig"));

% RNN target and output signals (designn set)
des_signals = figure;
plot(cell2mat(des_out)), hold on,
plot(cell2mat(Ts_des)), hold off,
legend("RNN output (design set)", "RNN target (design set)")
title("RNN target and output signals over time (design set)")
saveas(des_signals, fullfile("results", "RNN", "RNN_train_target-output_signals.fig"))

% RNN target and output signals (test set)
ts_signals = figure;
plot(cell2mat(ts_out)), hold on,
plot(cell2mat(Ts_ts)), hold off,
legend("RNN test output", "RNN test target")
title("RNN target and output signals over time (test set)")
saveas(ts_signals, fullfile("results", "RNN", "RNN_test_target-output_signals.fig"))
