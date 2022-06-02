function [Wout] = esn_readout_training(mode, target, X, lambda, Nr)
% Perform the training of the readout layer of the ESN with states X
if mode == "pinv"
    Wout = target * pinv(X); % using pseudo-inverse
else
    % using ridge regression
    Wout = target * X' * inv(X*X' + lambda * eye(Nr + 1));
end
end

