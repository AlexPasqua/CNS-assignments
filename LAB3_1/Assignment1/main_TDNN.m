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
max_inputDelay = 20;
max_hiddenSize = 20;
max_n_hiddenLayers = 10;
train_funcs = ["traingd", "traingdm", "traingdx", "trainrp", "trainlm"];
best_val_mse = Inf;
for i = 1 : n_trials
    % randomly select hyperparameters
    conf = get_rand_hyperparametrization(max_inputDelay, max_hiddenSize, ...
        max_n_hiddenLayers, train_funcs);
    
    % time delay neural network
    tdnn = timedelaynet(0:conf.inputDelays, conf.hiddenSizes, conf.trainFcn);
    tdnn.divideFcn = "dividetrain";
    tdnn.trainParam.lr = conf.lr;
%     view(tdnn)
    
    % prepare the time series for the net
    % TDNN training set
    [Xs_tr, Xi_tr, Ai_tr, Ts_tr, ~, ~] = ...
        preparets(tdnn, num2cell(tr_input), num2cell(tr_target));
    % TDNN validation set
    [Xs_val, Xi_val, Ai_val, Ts_val, ~, ~] = ...
        preparets(tdnn, num2cell(tr_input), num2cell(tr_target));
    
    % train TDNN
    [trained_tdnn, ~] = train(tdnn, Xs_tr, Ts_tr, Xi_tr, Ai_tr);
    tr_out = trained_tdnn(Xs_tr, Xi_tr, Ai_tr);
    tr_mse = immse(cell2mat(tr_out), cell2mat(Ts_tr));
    
    % validation TDNN
    val_out = trained_tdnn(Xs_val, Xi_val, Ai_val);
    val_mse = immse(cell2mat(val_out), cell2mat(Ts_val));
    if val_mse < best_val_mse
        % at the first time step, this condition will be true
        best_val_mse = val_mse;
        best_tr_mse = tr_mse;
        best_conf = conf;
    end
end

% best TDNN on validation
best_tdnn = timedelaynet(0:best_conf.inputDelays, best_conf.hiddenSizes, best_conf.trainFcn);
best_tdnn.divideFcn = "dividetrain";
best_tdnn.trainParam.lr = best_conf.lr;
view(best_tdnn)

% train best TDNN on the whole design (tr + val) set
des_input = [tr_input, val_input];
des_target = [tr_target, val_target];
[Xs_des, Xi_des, Ai_des, Ts_des, ~, ~] = ...
    preparets(best_tdnn, num2cell(des_input), num2cell(des_target));
[trained_tdnn, tdnn_hist] = train(best_tdnn, Xs_des, Ts_des, Xi_des, Ai_des);
save(fullfile("results", "TDNN_tr_record.mat"), "tdnn_hist")

% test best TDNN on test set
[Xs_ts, Xi_ts, Ai_ts, Ts_ts, ~, ~] = ...
    preparets(best_tdnn, num2cell(ts_input), num2cell(ts_target));
ts_out = trained_tdnn(Xs_ts, Xi_ts, Ai_ts);
ts_mse = immse(cell2mat(ts_out), cell2mat(Ts_ts));

% PLOTS
% tdnn learning curve
learning_curve = figure;
plot(tdnn_hist.perf)
title("TDNN learning curve on design set (tr+val)")
xlabel("Epochs")
ylabel("MSE")
saveas(learning_curve, fullfile("results", "TDNN_learning_curve.fig"));

% tdnn target and output signals
signals = figure;
plot(cell2mat(ts_out)), hold on,
plot(cell2mat(Ts_ts)), hold off,
legend("TDNN test output", "TDNN test target")
title("TDNN target and output signals over time")

% save results
save(fullfile("results", "TDNN_MSEs.mat"), "best_tr_mse", "best_val_mse", "ts_mse")
