%%%%% (D) Phasic bursting %%%%%

% parameters
a=0.02; b=0.25; c=-55; d=0.05;

% initial membrane potential
v = -64;

% input current (when not zero)
I = 0.6;

% length of the plot's x axis
len_x = 200;

% name of the nauro-computational feature (for plots)
name = "(D) Phasic bursting";

izhikevich(a, b, c, d, v, I, len_x, name);
