function[W] = hopfield_storage_phase(fundamental_memories)
% STORAGE PHASE: (learning) set the net's weights
n_neurons = size(fundamental_memories, 1);
n_patterns = size(fundamental_memories, 2);
S = zeros(n_neurons, n_neurons);
for mu = 1 : n_patterns
    pattern = fundamental_memories(:, mu);
    S = S + pattern * pattern';
end
W = (S - n_patterns .* eye(n_neurons)) ./ n_neurons;
end