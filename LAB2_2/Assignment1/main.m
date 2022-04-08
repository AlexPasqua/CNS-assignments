% load the data into 3 vectors: p0, p1, p3 representing 3 images of digits
load lab2_2_data.mat p0 p1 p2
n_patterns = 3;
n_neurons = length(p0);
fundamental_memories = [p0, p1, p2];

% train the Hopfield network with the fundamental memories
W = hopfield_storage_phase(fundamental_memories);

% generate distorted version of the 3 patterns
dist_percs = [0.05 0.1 0.25];   % 3 distortion percentages
p0_dist = zeros(length(p0), length(dist_percs));
p1_dist = zeros(length(p1), length(dist_percs));
p2_dist = zeros(length(p2), length(dist_percs));
for i = 1 : length(dist_percs)
    p0_dist(:, i) = distort_image(p0, dist_percs(i));
    p1_dist(:, i) = distort_image(p1, dist_percs(i));
    p2_dist(:, i) = distort_image(p2, dist_percs(i));
end

