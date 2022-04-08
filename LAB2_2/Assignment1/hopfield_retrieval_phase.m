function [] = hopfield_retrieval_phase(W, patterns, n_epochs)
% RETRIEVAL PHASE
% initialization
state = patterns(:, 1);     % first pattern selected as "probe pattern"

% iterate over epochs
overlaps = zeros(n_patterns, n_patterns);
energies = zeros(1, n_patterns);
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
        for mu = 1 : n_patterns
            pattern = patterns(:, mu);
            overlaps(mu, ep) = sum(pattern .* state) / n_neurons;
        end

        % compute energy function
        energies(ep) = sum(w .* (state * state'), 'all');
    end
    
    % TODO: STOPPING CRITERION
    
    
end 
end