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
inp_x_axis = [
    0 T1 T1 T1+inp_span T1+inp_span ...
    T2 T2 T2+inp_span T2+inp_span ...
    T3 T3 T3+inp_span T3+inp_span ...
    T4 T4 T4+inp_span T4+inp_span max(tspan)];
inp_y_axis = -90+[0 0 10 10 0 0 10 10 0 0 10 10 0 0 10 10 0 0];
figure()
plot(tspan, v_array, inp_x_axis, inp_y_axis);
title(name)
xlabel("Time")
ylabel("Membrane potential")
legend("Membrane potential", "Input current")
figure()
plot(v_array, u_array)
title(name + " phase portrait")
xlabel("Membrane potential variable")
ylabel("Recovery variable")