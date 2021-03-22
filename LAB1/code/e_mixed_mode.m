%%%%% (E) Mixed mode %%%%%

% parameters
a=0.02; b=0.2; c=-55; d=4;

% initial membrane potential
v = -70;

% input current (when not zero)
I = 10;

% length of the plot's x axis
len_x = 160;

% name of the nauro-computational feature (for plots)
name = "(E) Mixed mode";

izhikevich(a, b, c, d, v, I, len_x, name);
