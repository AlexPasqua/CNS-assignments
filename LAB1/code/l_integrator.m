%%%%% (L) Integrator %%%%%

% parameters
a=0.02; b=-0.1; c=-55; d=6;

len_x = 100;    % length of the plot's x axis
tau = 0.25;     % time interval
tspan = 0:tau:len_x;    % x axis for the plot
t1 = tspan(end) / 11;
t2 = t1 + 5;
t3 = 0.7 * tspan(end);
t4 = t3 + 10;
stimulation_times = [t1 t2 t3 t4];
inp_span = 2;   % duration of the input stimulation
inp_curr = 9;    % input current (when not zero)

% v: membrane potential
% u: membrane recovery variable
v = -60; u = b*v;
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
            I = 0;
        end
    end
    
    % Izhikevich equations
    % (in this case I don't use the function izhikevich.m because the
    % values of the constants are different from all the other configurations)
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

% plot
figure
tl = tiledlayout(1, 2);
title(tl, "(L) Integrator")
ax1 = nexttile;
inp_x_axis = [
    0 t1 t1 t1+inp_span t1+inp_span ...
    t2 t2 t2+inp_span t2+inp_span ...
    t3 t3 t3+inp_span t3+inp_span ...
    t4 t4 t4+inp_span t4+inp_span max(tspan)];
inp_y_axis = -90+[0 0 10 10 0 0 10 10 0 0 10 10 0 0 10 10 0 0];
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
