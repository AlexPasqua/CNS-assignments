%%%%% (A) Tonic spiking %%%%%

% parameters
a=0.02; b=0.2; c=-65; d=6;

% v: initial membrane potential
v = -70;

% input current (when not zero)
I = 14;

% length of the plot's x axis
len_x = 100;

% name of the nauro-computational feature (for plots)
name = "(A) Tonic spiking";

izhikevich(a, b, c, d, v, I, len_x, name);
