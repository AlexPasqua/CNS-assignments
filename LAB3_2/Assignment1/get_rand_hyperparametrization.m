function [Nr, inputScaling, rho_desired, lambda, mode] = get_rand_hyperparametrization(max_Nr)
% returns a random hyperparametrization
Nr = randi(max_Nr);
inputScaling = 2 * rand;    % random uniform in [0,2]
rho_desired = rand;     % random uniform in [0,1]
lambda = 0.1 * rand;    % random uniform in [0, 0.1]
modes = ["pinv", "ridge_reg"];
mode = modes(randi(length(modes)));
end

