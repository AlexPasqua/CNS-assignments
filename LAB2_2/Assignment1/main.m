% load the data into 3 vectors: p0, p1, p3 representing 3 images of digits
load lab2_2_data.mat p0 p1 p2
n_patterns = 3;
n_neurons = length(p0);
fundam_mems = [p0, p1, p2];

% train the Hopfield network with the fundamental memories
W = hopfield_storage_phase(fundam_mems);

% generate distorted version of the 3 patterns
dist_percs = [0.05 0.1 0.25];   % 3 distortion percentages
p0_dist1 = distort_image(p0, dist_percs(1));
p0_dist2 = distort_image(p0, dist_percs(2));
p0_dist3 = distort_image(p0, dist_percs(3));
p1_dist1 = distort_image(p1, dist_percs(1));
p1_dist2 = distort_image(p1, dist_percs(2));
p1_dist3 = distort_image(p1, dist_percs(3));
p2_dist1 = distort_image(p2, dist_percs(1));
p2_dist2 = distort_image(p2, dist_percs(2));
p2_dist3 = distort_image(p2, dist_percs(3));
dist_patterns = [p0_dist1 p0_dist2 p0_dist3 p1_dist1 p1_dist2 p1_dist3 ...
    p2_dist1 p2_dist2 p2_dist3];
title_prefixes = ["P0 dist 0.05", "P0 dist 0.1", "P0 dist 0.25", "P1 dist 0.05", ...
    "P1 dist 0.1", "P1 dist 0.25", "P2 dist 0.05", "P2 dist 0.1", "P2 dist 0.25"];

% feed the Hopfield network with all the distorted patterns
for i = 1 : size(dist_patterns, 2)
    % retrieval phase
    [energy, overlaps, state] = hopfield_retrieval_phase(W, fundam_mems, dist_patterns(:,i), 2);

    % plot energy
    figure
    plot(energy)
    title(strcat(title_prefixes(i), ": Energy as function of time"))
    
    % plot overlaps
    figure
    plot(overlaps')
    title(strcat(title_prefixes(i), ": Overlaps with fundamental memories as a function of time"))
    legend("Overlap with p0", "Overlap with p1", "Overlap with p2")
    
    % plot reconstructed image
    figure
    imshow(reshape(state, 32, 32))
    title(strcat(title_prefixes(i), ": Reconstructed image"))
end