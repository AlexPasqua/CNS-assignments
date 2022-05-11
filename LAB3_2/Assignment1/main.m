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


% TODO: random search of hyperparameters


% train ESN
reservoir_guesses = 10;
initial_transient = 500;
for guess = 1 : reservoir_guesses
    [Win, Wr] = esn(inputScaling, 1, Nr, rho_desired);
    
    % compute the states for the training input sequence
    X = zeros(Nr, length(tr_input));   % states matrix
    for t = 1 : length(tr_input)
        if t == 1
            prev_state = zeros(Nr, 1);
        else
            prev_state = X(:, t-1);
        end
        X(:,t) = tanh(Win*[tr_input(t);1] + Wr*prev_state);
    end
    
    % washout
    X = X(:, initial_transient+1 : end);
    tr_target_cut = tr_target(:, initial_transient+1 : end);
    
    % readout training
    X = [X; ones(1, length(tr_target_cut))];
    Wout = tr_target_cut * pinv(X);
    
    % evaluation
    
end
