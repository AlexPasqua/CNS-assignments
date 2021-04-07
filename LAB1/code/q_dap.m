%%%%% (Q) Depolarizing after-potential %%%%%
% parameters
a=1; b=0.2; c=-60; d=-21;
% initial membrane potential
v = -70;
% length of the plot's x axis
len_x = 50;
% name of the nauro-computational feature (for plots)
name = "(Q) Depolarizing after-potential";

inp_span = 2; inp_curr = 20; tau = 0.1;
t1=9;
inp_starts = [t1];
[tspan, v_array, u_array] = izhikevich_interval_inputs(a, b, c, d, v, ...
    len_x, inp_starts, inp_span, inp_curr, tau, "M");

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