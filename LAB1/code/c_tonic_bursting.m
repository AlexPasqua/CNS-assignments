%%%%% (C) Tonic bursting %%%%%

% parameters
a=0.02; b=0.2; c=-50; d=2;

% initial membrane potential
v = -70;

% input current (when not zero)
I = 15;

% length of the plot's x axis
len_x = 220;

% name of the nauro-computational feature (for plots)
name = "(C) Tonic bursting";
izhikevich_step_input(a, b, c, d, v, I, len_x, name);