function [energies, overlaps] = hopfield_retrieval_phase(W, fundam_mems, dist_pattern, n_epochs)
% RETRIEVAL PHASE
% initialization
state = dist_pattern;     % initialization of the state with "probe pattern"

% iterate over epochs
n_neurons = length(dist_pattern);
% n_patterns = size(pattern, 2);
n_fundam_mems = size(fundam_mems, 2);
overlaps = zeros(n_fundam_mems, n_epochs * n_neurons);
energies = zeros(1, n_epochs * n_neurons);
t = 1;
for ep = 1 : n_epochs
    % pick a random order of the neurons
    rand_order = randperm(n_neurons);
    
    % iterate over neurons in the random order to compute the state
    for j = rand_order
        weighted_sum = W(j,:) * state;
        state(j) = sign(weighted_sum);
        % if the neuron's value is 0, set it to 1 (neurons can be either +1 or -1)
        if state(j) == 0
            state(j) = 1;
        end
        
        % computer overlap functions
        overlaps(:, t) = (fundam_mems' * state) / n_neurons;

        % compute energy function
        energies(t) = -0.5 * sum(W .* (state * state'), 'all');
        
        t = t + 1;
    end
    
    % TODO: STOPPING CRITERION
    
end
end