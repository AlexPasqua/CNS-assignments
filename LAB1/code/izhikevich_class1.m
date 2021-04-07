%%%%% IZHIKEVICH'S MODEL %%%%%

function [] = izhikevich_class1(a, b, c, d, init_v, len_x, plot_title)
%IZHIKEVICH Implementation of the Izhikevich model

% tau: time interval
% tspan: x axis for the plot
% t1: time at which the input current steps up
tau = 0.25;
tspan = 0:tau:len_x;
t1 = tspan(end) / 10;

% v: membrane potential
% u: membrane recovery variable
v = init_v; u = b*v;
v_array = zeros(size(tspan));
u_array = zeros(size(tspan));

idx = 1;
for t = tspan
    if t <= t1
        I = 0;
    else
        I = 0.075 * (t - t1);
    end
    v = v + tau*(0.04*v^2 + 4.1*v + 108 - u + I);
    u = u + tau*a*(b*v - u);
    if v >= 30
        v_array(idx) = 30;
        v = c;
        u = u + d;
    else
        v_array(idx) = v;
    end
    u_array(idx) = u;
    idx = idx + 1;
end

figure()
plot(tspan, v_array, [0 t1 max(tspan) max(tspan)], -90+[0 0 20 0])
title(plot_title)
xlabel("Time")
ylabel("Membrane potential")
legend("Membrane potential", "Input current")

figure()
plot(v_array, u_array)
title(plot_title + " phase portrait")
xlabel("Membrane potential variable")
ylabel("Recovery variable")

end

