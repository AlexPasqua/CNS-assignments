%%%%% (M) Rebound spike %%%%%

% parameters
a=0.03; b=0.25; c=-60; d=4;

len_x = 200;    % length of the plot's x axis
tau = 0.2;      % time interval
tspan = 0:tau:len_x;    % x axis for the plot
t1 = tspan(end) / 10;
inp_span = 5;   % duration of the input stimulation
inp_curr = -15;    % input current (when not zero)

% v: membrane potential
% u: membrane recovery variable
v = -64; u = b*v;
v_array = zeros(size(tspan));
u_array = zeros(size(tspan));

idx = 1;
for t = tspan
    if t > t1 && t < t1 + inp_span
        I = inp_curr;
    else
        I = 0;
    end
    
    % Izhikevich equations
    [v, u] = izhikevich(a, b, v, u, I, tau);
    
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
figure
tl = tiledlayout(1, 2);
title(tl, "(M) Rebound spike")
ax1 = nexttile;
plot(tspan, v_array, [0 t1 t1 t1+inp_span t1+inp_span max(tspan)], -90+[0 0 -5 -5 0 0]);
title(ax1, "Membrane potential dynamics")
xlabel("Time")
ylabel("Membrane potential")
legend("Membrane potential", "Input current")

ax2 = nexttile;
plot(v_array, u_array)
title("Phase portrait")
xlabel("Membrane potential variable")
ylabel("Recovery variable")
