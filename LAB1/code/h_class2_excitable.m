%%%%% (H) Class 2 excitable %%%%%

% parameters
a=0.2; b=0.26; c=-65; d=0;

% initial membrane potential
v = -64;

% length of the plot's x axis
len_x = 300;

% name of the nauro-computational feature (for plots)
name = "(H) Class 2 excitable";
izhikevich_class2(a, b, c, d, v, len_x, name);