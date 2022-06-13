%%%%% (P) Bistability %%%%%

% parameters
a=0.1; b=0.26; c=-60; d=0;

len_x = 300;    % length of the plot's x axis
tau = 0.25;     % time interval
tspan = 0:tau:len_x;    % x axis for the plot
t1 = tspan(end) / 8;
t2 = 216;
stimulation_times = [t1 t2];
inp_span = 5;   % duration of the input stimulation
inp_curr = 1.24;    % input current (when not zero)

% v: membrane potential
% u: membrane recovery variable
v = -61; u = b*v;
v_array = zeros(size(tspan));
u_array = zeros(size(tspan));

idx = 1;
for t = tspan
    for i = 1 : length(stimulation_times)
        stim_time = stimulation_times(i);
        if t > stim_time && t < stim_time + inp_span
            I = inp_curr;
            break;
        else
            I = 0.24;
        end
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
title(tl, "(P) Bistability")
ax1 = nexttile;
inp_x_axis = [0 t1 t1 t1+inp_span t1+inp_span t2 t2 t2+inp_span t2+inp_span max(tspan)];
inp_y_axis = -90+[0 0 10 10 0 0 10 10 0 0];
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
