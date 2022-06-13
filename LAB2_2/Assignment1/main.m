% load the data into 3 vectors: p0, p1, p3 representing 3 images of digits
load lab2_2_data.mat p0 p1 p2
n_patterns = 3;
n_neurons = length(p0);
fundam_mems = [p0, p1, p2];

% train the Hopfield network with the fundamental memories
W = hopfield_storage_phase(fundam_mems);

% generate distorted version of the 3 patterns
dist_patterns = distort_all_images(fundam_mems, [0.05 0.1 0.25]);

title_prefixes = ["P0 dist 0.05", "P0 dist 0.1", "P0 dist 0.25", "P1 dist 0.05", ...
    "P1 dist 0.1", "P1 dist 0.25", "P2 dist 0.05", "P2 dist 0.1", "P2 dist 0.25"];

% feed the Hopfield network with all the distorted patterns
figures_dir = "figures";
ener_dir = fullfile(figures_dir, "energy");
overlaps_dir = fullfile(figures_dir, "overlaps");
recontr_dir = fullfile(figures_dir, "reconstructions");
for i = 1 : size(dist_patterns, 2)
    % retrieval phase
    [energy, overlaps, state] = hopfield_retrieval_phase(W, fundam_mems, dist_patterns(:,i), 10);

    % plot energy
    fig_energy = figure;
    plot(energy)
    title(strcat(title_prefixes(i), ": Energy as function of time"))
    filename = create_filename(title_prefixes(i), "_energy.fig");
    saveas(fig_energy, fullfile(ener_dir, filename))
    
    % plot overlaps
    fig_overlaps = figure;
    plot(overlaps')
    title(strcat(title_prefixes(i), ": Overlaps with fundamental memories as a function of time"))
    legend("Overlap with p0", "Overlap with p1", "Overlap with p2")
    filename = create_filename(title_prefixes(i), "_overlaps.fig");
    saveas(fig_overlaps, fullfile(overlaps_dir, filename))
    
    % plot reconstructed image
    fig_recontr = figure;
    subplot(1, 2, 1)
    imshow(reshape(dist_patterns(:,i), 32, 32))
    title("Distorted image")
    subplot(1, 2, 2);
    imshow(reshape(state, 32, 32))
    title("Recontructed image")
    sgtitle(strcat(title_prefixes(i), ": Image recontruction"))
    filename = create_filename(title_prefixes(i), "_recontruction.fig");
    saveas(fig_recontr, fullfile(recontr_dir, filename))
end