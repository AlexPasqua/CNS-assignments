function [conf] = get_rand_hyperparams(max_Nr)
% returns a random configuration of hyperparameters
Nr = randi(max_Nr);
inputScaling = 2 * rand;    % random uniform in [0,2]
rho_desired = rand;     % random uniform in [0,1]
lambda = 0.1 * rand;    % random uniform in [0, 0.1]
modes = ["pinv", "ridge_reg"];
mode = modes(randi(length(modes)));
conf = struct('Nr', Nr, 'inputScaling', inputScaling, ...
    'rho_desired', rho_desired, 'lambda', lambda, 'mode', mode);
end

