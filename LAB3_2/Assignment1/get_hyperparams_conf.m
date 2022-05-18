function [best_hyper_conf] = ...
    get_hyperparams_conf(Nr, inputScaling, rho_desired, lambda, mode)
% given some hyperparameters' values, it returns a containers.Map
% associating each hyperparam's name to iuts value, creating a
% an object representing a complete hyperparameters configuration
best_hyper_conf = containers.Map;
best_hyper_conf('Nr') = Nr;
best_hyper_conf('inputScaling') = inputScaling;
best_hyper_conf('rho_desired') = rho_desired;
best_hyper_conf('lambda') = lambda;
best_hyper_conf('mode') = mode;
end

