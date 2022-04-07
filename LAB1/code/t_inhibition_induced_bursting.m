%%%%% (T) Inhibition-induced bursting %%%%%

% parameters
a=-0.026; b=-1; c=-45; d=-2;

% length of the plot's x axis
% tau: time interval
% tspan: x axis for the plot
% t1: time at which the input current steps up
len_x = 350;
tau = 0.5;
tspan = 0:tau:len_x;
t1 = 50;
inp_span = 200;

% v: membrane potential
% u: membrane recovery variable
v = -63.8; u = b*v;
v_array = zeros(size(tspan));
u_array = zeros(size(tspan));

idx = 1;
for t = tspan
    if t < t1 || t > t1 + inp_span
        I=80;
    else
        I=75;
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
title(tl, "(T) Inhibition-induced bursting");
ax1 = nexttile;
inp_x_axis = [0 t1 t1 t1+inp_span t1+inp_span max(tspan)];
inp_y_axis = -80+[0 0 -10 -10 0 0]; 
plot(tspan, v_array, inp_x_axis, inp_y_axis);
title(ax1, "Membrane potential dynamics")
xlabel("Time")
ylabel("Membrane potential")
legend("Membrane potential", "Input current")

ax2 = nexttile;
plot(v_array, u_array)
title("Phase portrait")
xlabel("Membrane potential variable")
ylabel("Recovery variable")
