%%%%% (O) Threshold variability %%%%%
% parameters
a=0.03; b=0.25; c=-60; d=4;
% initial membrane potential
v = -64;
u = b * v;
% length of the plot's x axis
len_x = 100;
% name of the nauro-computational feature (for plots)
name = "(O) Threshold variability";

inp_span = 5; tau = 0.25; tspan = 0:tau:len_x;
t1=10; t2=80; t3=70;
inp_starts = [t1 t2];
idx = 1;
v_array = zeros(size(tspan));
u_array = zeros(size(tspan));

% Implementation of the Izhikevich model directly here (no func called)
for t = tspan
    for i = 1 : length(inp_starts)
        inp_start = inp_starts(i);
        if t > inp_start && t < inp_start + inp_span
            I = 1;
            break;
        elseif t > t3 && t < t3 + inp_span
            I = -6;
            break;
        else
            I = 0;
        end
    end
    v = v + tau*(0.04*v^2 + 5*v + 140 - u + I);
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

% plot
figure()
plot(tspan, v_array, [0 t1 t1 t1+inp_span t1+inp_span t3 t3 ...
    t3+inp_span t3+inp_span t2 t2 t2+inp_span t2+inp_span max(tspan)], ...
    -85+[0 0  5  5  0  0  -5 -5 0  0  5  5  0  0]);
title(name)
xlabel("Time")
ylabel("Membrane potential")
legend("Membrane potential", "Input current")

figure()
plot(v_array, u_array)
title(name + " phase portrait")
xlabel("Membrane potential variable")
ylabel("Recovery variable")