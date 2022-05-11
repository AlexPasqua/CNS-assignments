function [Win, Wr] = esn(inputScaling, Nu, Nr, rho_desired)
% ECHO STATE NETWORK

% initialize the state as a null state (all zeros)
init_state = zeros(1, Nr);

% initialize the input-to-reservoir weights
Win = inputScaling * (2*rand(Nr,Nu+1) - 1);

% initialize the recurrent reservoir weights
Wrandom = 2*rand(Nr,Nr)-1;  % fully-connected random uniform matrix
rho = max(abs(eig(Wrandom)));
Wr = Wrandom * (rho_desired / rho);  % rescale the matrix for echo state property
end

