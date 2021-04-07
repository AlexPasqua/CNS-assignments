%%%%% (S) Inhibition-induced spiking %%%%%
% parameters
a=-0.02; b=-1; c=-60; d=8;
% initial membrane potential
v = -63.8;
u = b * v;
% length of the plot's x axis
len_x = 350;
% name of the nauro-computational feature (for plots)
name = "(S) Inhibition-induced spiking";

inp_span = 200; tau = 0.5; tspan = 0:tau:len_x;
t1=50;
idx = 1;
v_array = zeros(size(tspan));
u_array = zeros(size(tspan));

% Implementation of the Izhikevich model directly here (no func called)
for t=tspan
    if t < t1 || t > t1 + inp_span
        I=80;
    else
        I=75;
    end
    v = v + tau*(0.04*v^2 + 5*v + 140 - u + I);
    u = u + tau*a*(b*v - u);
    if v > 30
        v_array(idx) = 30;
        v = c;
        u = u + d;
    else
        v_array(idx) = v;
    end
    u_array(idx) = u;
    idx = idx + 1;
end

% plot
figure()
plot(tspan, v_array, [0 t1 t1 t1+inp_span t1+inp_span max(tspan)], ...
    -80+[0 0 -10 -10 0 0]);
title(name)
xlabel("Time")
ylabel("Membrane potential")
legend("Membrane potential", "Input current")

figure()
plot(v_array, u_array)
title(name + " phase portrait")
xlabel("Membrane potential variable")
ylabel("Recovery variable")