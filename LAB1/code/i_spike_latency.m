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