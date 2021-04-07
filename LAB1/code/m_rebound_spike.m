%%%%% (M) Rebound spike %%%%%
% parameters
a=0.03; b=0.25; c=-60; d=4;
% initial membrane potential
v = -64;
% length of the plot's x axis
len_x = 200;
% name of the nauro-computational feature (for plots)
name = "(M) Rebound spike";

inp_span = 5; inp_curr = -15; tau = 0.2;
t1=20;
inp_starts = [t1];
[tspan, v_array, u_array] = izhikevich_interval_inputs(a, b, c, d, v, ...
    len_x, inp_starts, inp_span, inp_curr, tau, "M");

% plot
figure()
plot(tspan, v_array, [0 t1 t1 t1+inp_span t1+inp_span max(tspan)], -90+[0 0 -5 -5 0 0]);
title(name)
xlabel("Time")
ylabel("Membrane potential")
legend("Membrane potential", "Input current")

figure()
plot(v_array, u_array)
title(name + " phase portrait")
xlabel("Membrane potential variable")
ylabel("Recovery variable")