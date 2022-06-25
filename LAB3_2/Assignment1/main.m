% import the dataset
load NARMA10timeseries.mat
input = cell2mat(NARMA10timeseries.input);
target = cell2mat(NARMA10timeseries.target);

% split data into training, validation and test sets
[tr_input, tr_target, val_input, val_target, ts_input, ts_target] = ...
    train_val_test_split(input, target, 4000, 1000);

% random search of hyperparameters
n_configs = 10;
max_Nr = 500;
reservoir_guesses = 10;
init_trans = 500;   % initial transient for the washout
for conf_idx = 1 : n_configs
    % ESN's (random) parameters
    conf = get_rand_hyperparams(max_Nr);
    % aliases for cleaner code
    inputScaling = conf.inputScaling;   Nr = conf.Nr;   mode = conf.mode;
    rho_desired = conf.rho_desired;     lambda = conf.lambda;

    % TRAIN ESN (for a certain number of reservoir guesses)
    best_conf = conf;  min_val_mse = Inf;  min_tr_mse = Inf;
    tr_mse = zeros(1, reservoir_guesses);
    val_mse = zeros(1, reservoir_guesses);
    for guess = 1 : reservoir_guesses
        % INITIALIZE ESN's Win and Wr
        [Win, Wr] = esn(inputScaling, 1, Nr, rho_desired);

        % COMPUTE STATES for training and validation input sequences
        [X_tr, X_val] = esn_compute_states(tr_input, val_input, Nr, Win, Wr);

        % WASHOUT
        X_tr = X_tr(:, init_trans + 1 : end);
        tr_target_cut = tr_target(:, init_trans + 1 : end);
        
        % READOUT TRAINING
        Wout = esn_readout_training(mode, tr_target_cut, X_tr, lambda, Nr);

        % EVALUATION
        tr_out = Wout * X_tr;
        val_out = Wout * X_val;
        tr_mse(guess) = immse(tr_out, tr_target_cut);
        val_mse(guess) = immse(val_out, val_target);
    end
    
    % average the validation performance over the reservoir guesses
    avg_tr_mse = mean(tr_mse);
    avg_val_mse = mean(val_mse);
    disp(strcat("Conf ", string(conf_idx), "/", string(n_configs), ...
        ": tr_MSE: ", string(avg_tr_mse), ", val_MSE: ", string(avg_val_mse)))
        
    % SELECT BEST HYPER-PARAMETERIZATION based on validation performance
    if avg_val_mse < min_val_mse
        min_tr_mse = avg_tr_mse;
        min_val_mse = avg_val_mse;
        best_conf = conf;
    end
end


% RE-TRAIN NETWORK ON DESIGN SET (tr + val) -------------------------------
% re-create the best network
[best_Win, best_Wr] = esn(best_conf.inputScaling, 1, best_conf.Nr, ...
    best_conf.rho_desired);

% create "design set" (training + validation sets)
des_input = [tr_input val_input];
des_target = [tr_target val_target];

% compute the states for the input sequences of the design set and test set
[X_des, X_ts] = esn_compute_states(des_input, ts_input, best_conf.Nr, ...
    best_Win, best_Wr);

% washout
X_des = X_des(:, init_trans + 1 : end);
des_target = des_target(:, init_trans+1 : end);

% readout training
best_Wout = esn_readout_training(best_conf.mode, des_target, X_des, ...
    best_conf.lambda, best_conf.Nr);

% evaluation
des_out = best_Wout * X_des;
ts_out = best_Wout * X_ts;
des_mse = immse(des_out, des_target);
ts_mse = immse(ts_out, ts_target);


% SAVE OUTPUTS ------------------------------------------------------------
% save the weights of the ESN corresponding top the best hyperparameterization
out_dir = "output";
save(fullfile(out_dir, 'best_ESN_weights.mat'), 'best_Win', 'best_Wr', 'best_Wout');

% save the struct with the best hyper-parameterization
save(fullfile(out_dir, 'best_hyperparams.mat'), 'best_conf');

% save training, validation and test MSE
training_MSE = min_tr_mse;
validation_MSE = min_val_mse;
designset_MSE = des_mse;
test_MSE = ts_mse;
save(fullfile(out_dir, "MSEs.mat"), 'training_MSE', 'validation_MSE', ...
    'designset_MSE', 'test_MSE');

% plot the target and outout signals (design set)
des_signals = figure;
plot(des_out), hold on,
plot(des_target), hold off
legend("Output signal (design set)", "Target signal (design set)")
title("Target and output signals (design set)")
saveas(des_signals, fullfile(out_dir, "training_target-output_signals.fig"))

% plot the target and outout signals (test set)
ts_signals = figure;
plot(ts_out), hold on,
plot(ts_target), hold off
legend("Output signal (test set)", "Target signal (test set)")
title("Target and output signals (test set)")
saveas(des_signals, fullfile(out_dir, "test_target-output_signals.fig"))