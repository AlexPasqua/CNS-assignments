function [filename] = create_filename(title_prefix, suffix)
% Create the filename of the pictures to be saved
filename = strcat(extractBetween(title_prefix, 1, 2), "_", ...
    extractBetween(title_prefix, 4, 7), "-", ...
    extractBetween(title_prefix, 9, strlength(title_prefix)), suffix);
end

