function [dist_images] = distort_all_images(images, dist_percs)
% Distort all the images by the specified distortion percentages
[~, n_imgs] = size(images);
dist_images = [];
for i = 1 : n_imgs
    img = images(:, i);
    for j = 1 : length(dist_percs)
        dist_images(:, end+1) = distort_image(img, dist_percs(j));
    end
end
end