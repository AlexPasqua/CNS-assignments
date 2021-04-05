%%%%% (A) Tonic spiking %%%%%
% parameters
a=0.02; b=0.2; c=-65; d=6;
% initial membrane potential
v = -70;
% input current (when not zero)
I = 14;
% length of the plot's x axis
len_x = 100;
% name of the nauro-computational feature (for plots)
name = "(A) Tonic spiking";
izhikevich_step_input(a, b, c, d, v, I, len_x, name);


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
izhikevich_step_input(a, b, c, d, v, I, len_x, name);


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
izhikevich_step_input(a, b, c, d, v, I, len_x, name);


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


%%%%% (G) Class 1 excitable %%%%%
% parameters
a=0.02; b=-0.1; c=-55; d=6;
% initial membrane potential
v = -60;
% length of the plot's x axis
len_x = 300;
% name of the nauro-computational feature (for plots)
name = "(G) Class 1 excitable ";
izhikevich_class1(a, b, c, d, v, len_x, name);


%%%%% (H) Class 2 excitable %%%%%
% parameters
a=0.2; b=0.26; c=-65; d=0;
% initial membrane potential
v = -64;
% length of the plot's x axis
len_x = 300;
% name of the nauro-computational feature (for plots)
name = "(H) Class 2 excitable ";
izhikevich_class2(a, b, c, d, v, len_x, name);
