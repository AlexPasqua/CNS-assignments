function [Nr, inputScaling, rho_desired, lambda, mode] = get_rand_hyperparametrization()
% returns a random hyperparametrization
Nr = randi(max_Nr);
inputScaling = 2 * rand;    % random uniform in [0,2]
rho_desired = rand;     % random uniform in [0,1]
lambda = 0.1 * rand;    % random uniform in [0, 0.1]
if mod(randi(100), 2) == 0
    mode = 'pinv';
else
    mode = 'ridge_reg';
end
end

