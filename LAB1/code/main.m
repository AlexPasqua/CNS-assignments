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
name = "(G) Class 1 excitable";
izhikevich_class1(a, b, c, d, v, len_x, name);


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


%%%%% (I) Spike latency %%%%%
% parameters
a=0.02; b=0.2; c=-65; d=6;
% initial membrane potential
v = -70;
% length of the plot's x axis
len_x = 100;
% name of the nauro-computational feature (for plots)
name = "(I) Spike latency";
t1 = 10; inp_span = 3; inp_curr = 7.04; tau = 0.2;
[tspan, v_array, u_array] = izhikevich_interval_inputs(a, b, c, d, v, ...
    len_x, [t1], inp_span, inp_curr, tau, "I");
% plot
figure()
plot(tspan, v_array, [0 t1 t1 t1+inp_span t1+inp_span max(tspan)], -90+[0 0 10 10 0 0]);
title(name)
xlabel("Time")
ylabel("Membrane potential")
legend("Membrane potential", "Input current")
figure()
plot(v_array, u_array)
title(name + " phase portrait")
xlabel("Membrane potential variable")
ylabel("Recovery variable")


%%%%% (J) Subthreshold oscillations %%%%%
% parameters
a=0.05; b=0.26; c=-60; d=0;
% initial membrane potential
v = -62;
% length of the plot's x axis
len_x = 200;
% name of the nauro-computational feature (for plots)
name = "(J) Subthreshold oscillations";
t1 = 20; inp_span = 5; inp_curr = 2; tau = 0.25;
[tspan, v_array, u_array] = izhikevich_interval_inputs(a, b, c, d, v, ...
    len_x, [t1], inp_span, inp_curr, tau, "J");
% plot
figure()
plot(tspan, v_array, [0 t1 t1 t1+inp_span t1+inp_span max(tspan)], -90+[0 0 10 10 0 0], ...
    tspan(220:end), -10+20*(v_array(220:end)-mean(v_array)));
title(name)
xlabel("Time")
ylabel("Membrane potential")
legend("Membrane potential", "Input current")
figure()
plot(v_array, u_array)
title(name + " phase portrait")
xlabel("Membrane potential variable")
ylabel("Recovery variable")


%%%%% (K) Resonator %%%%%
% parameters
a=0.1; b=0.26; c=-60; d=-1;
% initial membrane potential
v = -62;
% length of the plot's x axis
len_x = 400;
% name of the nauro-computational feature (for plots)
name = "(K) Resonator";
inp_span = 4; inp_curr = 0.65; tau = 0.25; tspan = 0:tau:len_x;
T1=tspan(end)/10; T2=T1+20; T3 = 0.7*tspan(end); T4 = T3+40;
inp_starts = [T1 T2 T3 T4];
[tspan, v_array, u_array] = izhikevich_interval_inputs(a, b, c, d, v, ...
    len_x, inp_starts, inp_span, inp_curr, tau, "K");
% plot
figure()
plot(tspan, v_array, [0 t1 t1 t1+inp_span t1+inp_span max(tspan)], -90+[0 0 10 10 0 0]);
title(name)
xlabel("Time")
ylabel("Membrane potential")
legend("Membrane potential", "Input current")
figure()
plot(v_array, u_array)
title(name + " phase portrait")
xlabel("Membrane potential variable")
ylabel("Recovery variable")


%%%%% (L) Integrator %%%%%
% parameters
a=0.02; b=-0.1; c=-55; d=6;
% initial membrane potential
v = -60;
% length of the plot's x axis
len_x = 100;
% name of the nauro-computational feature (for plots)
name = "(L) Integrator";
inp_span = 2; inp_curr = 9; tau = 0.25; tspan = 0:tau:len_x;
T1=tspan(end)/11; T2=T1+5; T3 = 0.7*tspan(end); T4 = T3+10;
inp_starts = [T1 T2 T3 T4];
[tspan, v_array, u_array] = izhikevich_interval_inputs(a, b, c, d, v, ...
    len_x, inp_starts, inp_span, inp_curr, tau, "L");
% plot
figure()
plot(tspan, v_array, [0 t1 t1 t1+inp_span t1+inp_span max(tspan)], -90+[0 0 10 10 0 0]);
title(name)
xlabel("Time")
ylabel("Membrane potential")
legend("Membrane potential", "Input current")
figure()
plot(v_array, u_array)
title(name + " phase portrait")
xlabel("Membrane potential variable")
ylabel("Recovery variable")