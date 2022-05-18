function [tr_input, tr_target, val_input, val_target, ts_input, ...
    ts_target] = train_val_test_split(input, target, n_train, n_val)
%Split the whole time series into training, validation and test sets
%   n_train is the number of samples to put into the training set
%   n_val is analogous to n_train for the validation set
%   the final part of the ts (n_train + n_val + 1 : end) is the test set
n_devset = n_train + n_val; % 'development set': training + validation
dev_input = input(1 : n_devset);
dev_target = target(1 : n_devset);
tr_input = dev_input(1 : n_train);
tr_target = dev_target(1 : n_train);
val_input = dev_input(n_train + 1 : end);
val_target = dev_target(n_train + 1 : end);
ts_input = input(n_devset + 1 : end);
ts_target = target(n_devset + 1 : end);
end

