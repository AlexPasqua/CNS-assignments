%%%%% (P) Bistability %%%%%
% parameters
a=0.1; b=0.26; c=-60; d=0;
% initial membrane potential
v = -61;
u = b * v;
% length of the plot's x axis
len_x = 300;
% name of the nauro-computational feature (for plots)
name = "(P) Bistability";

inp_span = 5; tau = 0.25; tspan = 0:tau:len_x;
t1=tspan(end)/8; t2=216;
inp_starts = [t1 t2];
idx = 1;
v_array = zeros(size(tspan));
u_array = zeros(size(tspan));

% Implementation of the Izhikevich model directly here (no func called)
for t = tspan
    for i = 1 : length(inp_starts)
        inp_start = inp_starts(i);
        if t > inp_start && t < inp_start + inp_span
            I = 1.24;
            break;
        else
            I = 0.24;
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
plot(tspan, v_array, [0 t1 t1 t1+inp_span t1+inp_span t2 t2 t2+inp_span ...
    t2+inp_span max(tspan)], -90+[0 0 10 10 0 0 10 10 0 0]);
title(name)
xlabel("Time")
ylabel("Membrane potential")
legend("Membrane potential", "Input current")

figure()
plot(v_array, u_array)
title(name + " phase portrait")
xlabel("Membrane potential variable")
ylabel("Recovery variable")