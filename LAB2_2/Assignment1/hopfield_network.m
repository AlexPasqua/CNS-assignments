% function[] = hopfield_network()
% load the data into 3 vectors: p0, p1, p3 representing 3 images of digits
load lab2_2_data.mat p0 p1 p2
n_patterns = 3;
n_neurons = length(p0);
dataset = [p0, p1, p2];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STORAGE PHASE: (learning) set the net's weights
s = zeros(n_neurons, n_neurons);
for mu = 1 : n_patterns
    pattern = dataset(:, mu);
    s = s + pattern * pattern';
end
w = (s - n_patterns .* eye(n_neurons)) ./ n_neurons;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RETRIEVAL PHASE
% initialization
state = p0;     % p0 selected as "probe pattern"

% iterate over epochs
epochs = 100;
overlaps = zeros(n_patterns, epochs);
energies = zeros(1, epochs);
for ep = 1 : epochs
    % pick a random order of the neurons
    rand_order = randperm(n_neurons);
    
    % iterate over neurons in the random order to compute the state
    for j = rand_order
        weighted_sum = w(j,:) * state;        
        state(j) = sign(weighted_sum);
        % if the neuron's value is 0, set it to 1 (neurons can be either +1 or -1)
        if state(j) == 0
            state(j) = 1;
        end
    end
    
    % TODO: sostituisci indice ep con numero di pattern in overlaps e energies
    
    % computer overlap functions
    for mu = 1 : n_patterns
        pattern = dataset(:, mu);
        overlaps(mu, ep) = sum(pattern .* state) / n_neurons;
    end
    
    % compute energy function
    energies(ep) = sum(w .* (state * state'), 'all');
    
    % TODO: STOPPING CRITERION
    
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
plot(energies)