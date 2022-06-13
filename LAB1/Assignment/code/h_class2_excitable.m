%%%%% (H) Class 2 excitable %%%%%

% parameters
a=0.2; b=0.26; c=-65; d=0;

% length of the plot's x axis
% tau: time interval
% tspan: x axis for the plot
% t1: time at which the input current steps up
len_x = 300;
tau = 0.25;
tspan = 0:tau:len_x;
t1 = tspan(end) / 10;

% v: membrane potential
% u: membrane recovery variable
v = -64; u = b*v;
v_array = zeros(size(tspan));
u_array = zeros(size(tspan));

idx = 1;
for t = tspan
    if t <= t1
        I = -0.5;
    else
        I = -0.5 + 0.015 * (t - t1);
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
figure
tl = tiledlayout(1, 2);
title(tl, "(H) Class 2 excitable")
ax1 = nexttile;
plot(tspan, v_array, [0 t1 max(tspan) max(tspan)], -90+[0 0 20 0])
title(ax1, "Membrane potential dynamics")
xlabel("Time")
ylabel("Membrane potential")
legend("Membrane potential", "Input current")

ax2 = nexttile;
plot(v_array, u_array)
title("Phase portrait")
xlabel("Membrane potential variable")
ylabel("Recovery variable")
