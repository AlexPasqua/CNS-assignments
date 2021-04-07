%%%%% (B) Phasic spiking %%%%%

% parameters
a=0.02; b=0.25; c=-65; d=6;

% initial membrane potential
v = -64;

% input current (when not zero)
I = 0.5;

% length of the plot's x axis
len_x = 200;

% name of the nauro-computational feature (for plots)
name = "(B) Phasic spiking";
izhikevich_step_input(a, b, c, d, v, I, len_x, name);