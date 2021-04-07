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