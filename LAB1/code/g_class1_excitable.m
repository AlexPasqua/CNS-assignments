%%%%% (G) Class 1 excitable %%%%%

% parameters
a=0.02; b=-0.1; c=-55; d=6;

% initial membrane potential
v = -60;

% input current (when not zero)
I = 30;

% length of the plot's x axis
len_x = 300;

% name of the nauro-computational feature (for plots)
name = "(G) Class 1 excitable ";

izhikevich("G", a, b, c, d, v, I, len_x, name);
