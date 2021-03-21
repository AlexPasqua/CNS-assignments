%%%%% (A) Tonic spiking %%%%%

% parameters
a=0.02; b=0.2; c=-65; d=6;

% tau: time interval
% tspan: x axis for the plot
% t1: time at which the input current steps up
tau = 0.25;
tspan = 0:tau:100;
t1 = tspan(end) / 10;

% v: membrane potential
% u: membrane recovery variable
v = -70; u = b*v;
v_array = zeros(size(tspan));
u_array = zeros(size(tspan));

idx = 1;
for t = tspan
    if t <= t1
        I = 0;
    else
        I = 14;
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

plot(tspan, v_array, [0 t1 t1 max(tspan)], -90+[0 0 10 10])
title("(A) Tonic spiking")
xlabel("Time")
ylabel("Membrane potential")
legend("Membrane potential", "Input current")

figure()
plot(v_array, u_array)
title("(A) Tonic spiking phase portrait")
xlabel("Membrane potential")
ylabel("Membrane recovery")
