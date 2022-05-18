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
for conf = 1 : n_configs
    % ESN's parameters
    Nr = randi(max_Nr);
    inputScaling = rand;    % random uniform in [0,1]
    rho_desired = rand;     % random uniform in [0,1]
    lambda = 0.1 * rand;    % random uniform in [0, 0.1]
    mode = "ridge_reg"; % either "pinv" or "ridge_reg"

    % train ESN
    best_hyper_conf = get_hyperparams_conf(Nr, inputScaling, rho_desired, lambda, mode);
    reservoir_guesses = 10;
    initial_transient = 500;
    min_val_mse = Inf;
    for guess = 1 : reservoir_guesses
        % initialize ESN's Win and Wr
        [Win, Wr] = esn(inputScaling, 1, Nr, rho_desired);

        % compute the states for the training input sequence
        X = zeros(Nr, length(tr_input));   % states matrix
        for t = 1 : length(tr_input)
            prev_state = get_prev_state(X, t, zeros(Nr, 1));
            X(:,t) = tanh(Win*[tr_input(t);1] + Wr*prev_state);
        end

        % washout
        X = X(:, initial_transient+1 : end);
        tr_target_cut = tr_target(:, initial_transient+1 : end);

        % readout training
        X = [X; ones(1, length(tr_target_cut))];
        if mode == "pinv"
            % using pseudo-inverse
            Wout = tr_target_cut * pinv(X);
        else
            % using ridge regression
            Wout = tr_target_cut * X' * inv(X*X' + lambda*eye(Nr+1));
        end

        % evaluation
        for t = 1 : length(val_input)
            prev_state = get_prev_state(X(1:end-1, :), t, X(1:end-1, end));
            X(:, end+1) = [tanh(Win*[val_input(t); 1] + Wr*prev_state); 1];
        end
        val_output = Wout * X(:, end - length(val_input) + 1 : end);
        val_mse = immse(val_output, val_target);

        % select best hyperparameters configuration
        if val_mse < min_val_mse
            min_val_mse = val_mse;
            best_Win = Win;
            best_Wr = Wr;
            best_Wout = Wout;
            best_hyper_conf = get_hyperparams_conf(...
                Nr, inputScaling, rho_desired, lambda, mode);
        end
    end
end

% retrain the network on all the training data (tr + val)
inputScaling = best_hyper_conf('inputScaling');
Nr = best_hyper_conf('Nr');
rho_desired = best_hyper_conf('rho_desired');
[Win, Wr] = esn(inputScaling, 1, Nr, rho_desired);
tr_input = [tr_input val_input];
tr_target = [tr_target val_target];
tr_input = tr_input(:, initial_transient+1 : end);      % washout
tr_target = tr_target(:, initial_transient+1 : end);    % washout
for t = 1 : length(tr_input)
    
    
    % TODO: fill here the retraining cycle
    
    
end
        
% save the weights of the ESN corresponding top the best hyperparametrization
out_dir = "output";
save(fullfile(out_dir, 'Win_best_hyperparametrization.mat'), 'best_Win');
save(fullfile(out_dir, 'Wr_best_hyperparametrization.mat'), 'best_Wr');
save(fullfile(out_dir, 'Wout_best_hyperparametrization.mat'), 'best_Wout');
% save the containers.Map with the best hyperparametrization
save(fullfile(out_dir, 'best_hyperparametrization.mat'), 'best_hyper_conf');


% TODO: save training, validation and test MSE


% plot the target and outout signals
    % NOTE: plotting the VALIDATION output and target may bev incorrect/incomplete
figure
plot(val_output), hold on,
plot(val_target), hold off
legend("val output", "val target")
