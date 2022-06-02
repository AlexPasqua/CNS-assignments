% import the dataset
load NARMA10timeseries.mat
input = cell2mat(NARMA10timeseries.input);
target = cell2mat(NARMA10timeseries.target);

% split data into training, validation and test sets
[tr_input, tr_target, val_input, val_target, ts_input, ts_target] = ...
    train_val_test_split(input, target, 4000, 1000);

% random search of hyperparameters
n_configs = 2;
max_Nr = 500;
reservoir_guesses = 2;
init_trans = 500;   % initial transient for the washout
for conf_idx = 1 : n_configs
    % ESN's (random) parameters
    conf = get_rand_hyperparams(max_Nr);
    inputScaling = conf.inputScaling;   Nr = conf.Nr;   mode = conf.mode;
    rho_desired = conf.rho_desired;     lambda = conf.lambda;

    % TRAIN ESN (for a certain number of reservoir guesses)
    best_conf = conf;   min_val_mse = Inf;
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
        val_output = Wout * X_val;
        val_mse(guess) = immse(val_output, val_target);
    end
    
    % average the validation performance over the reservoir guesses
    avg_val_mse = mean(val_mse);
        
    % SELECT BEST HYPER-PARAMETERIZATION
    if avg_val_mse < min_val_mse
        min_val_mse = avg_val_mse;
        best_conf = conf;
    end
end


% RETRAIN NETWORK ON DESIGN SET (tr + val) --------------------------------
% re-create the best network
[best_Win, best_Wr] = esn(best_conf.inputScaling, 1, best_conf.Nr, best_conf.rho_desired);

des_input = [tr_input val_input];   % input of the "design set" (tr + val)
des_target = [tr_target val_target];    % targets of the design set

% compute the states for the design set and test set input sequences
[X_des, X_ts] = esn_compute_states(des_input, ts_input, best_conf.Nr, best_Win, best_Wr);

% washout
X_des = X_des(:, init_trans + 1 : end);
des_target = des_target(:, init_trans+1 : end);

% readout training
best_Wout = esn_readout_training(best_conf.mode, des_target, X_des, best_conf.lambda, best_conf.Nr);

% evaluation
des_output = best_Wout * X_des;
ts_output = best_Wout * X_ts;
des_mse = immse(des_output, des_target);
ts_mse = immse(ts_output, ts_target);


% SAVE OUTPUTS ------------------------------------------------------------
% save the weights of the ESN corresponding top the best hyperparameterization
out_dir = "output";
save(fullfile(out_dir, 'best_Win.mat'), 'best_Win');
save(fullfile(out_dir, 'best_Wr.mat'), 'best_Wr');
save(fullfile(out_dir, 'best_Wout.mat'), 'best_Wout');
% save the struct with the best hyperparameterization
save(fullfile(out_dir, 'best_hyperparams.mat'), 'best_conf');


% TODO: save training, validation and test MSE


% plot the target and outout signals
    % NOTE: plotting the VALIDATION output and target may bev incorrect/incomplete
figure
plot(val_output), hold on,
plot(val_target), hold off
legend("val output", "val target")
