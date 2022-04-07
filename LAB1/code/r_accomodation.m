%%%%% (R) accomodation %%%%%

% parameters
a=0.02;  b=1; c=-55;  d=4;

len_x = 400;     % length of the plot's x axis
tau = 0.5;       % time interval
tspan = 0:tau:len_x;    % x axis for the plot
inp_span = 2;   % duration of the input stimulation

% v: membrane potential
% u: membrane recovery variable
v = -65; u = -16;
v_array = zeros(size(tspan));
u_array = zeros(size(tspan));
I_array = zeros(size(tspan));   % array to contain the input current for plotting

idx = 1;
for t=tspan
    if (t < 200)
        I = t / 25;
    elseif t < 300
        I = 0;
    elseif t < 312.5
        I = (t - 300) / 12.5 * 4;
    else
        I=0;
    end
    
    % Izhikevich equations
    % (u is modelled slightly differently in this configuration, therefore
    % we use the function "izhikevich" onbly for v and then model u
    % separately)
    [v, ~] = izhikevich(a, b, v, u, I, tau);   
    u = u + tau * a * (b * (v + 65));   
    
    if v > 30
        v_array(idx)=30;
        v = c;
        u = u + d;
    else
        v_array(idx) = v;
    end
    u_array(idx) = u;
    I_array(idx) = I;
    idx = idx + 1;
end

% plot
figure
tl = tiledlayout(1, 2);
title(tl, "(R) Accomodation")
ax1 = nexttile;
plot(tspan, v_array, tspan, I_array * 1.5 - 90);
title(ax1, "Membrane potential dynamics")
xlabel("Time")
ylabel("Membrane potential")
legend("Membrane potential", "Input current")

ax2 = nexttile;
plot(v_array, u_array)
title("Phase portrait")
xlabel("Membrane potential variable")
ylabel("Recovery variable")
