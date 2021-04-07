%%%%% (F) Spike frequency adaptation %%%%%

% parameters
a=0.01; b=0.2; c=-65; d=8;

% initial membrane potential
v = -70;

% input current (when not zero)
I = 30;

% length of the plot's x axis
len_x = 85;

% name of the nauro-computational feature (for plots)
name = "(F) Spike frequency adaptation";
izhikevich_step_input(a, b, c, d, v, I, len_x, name);