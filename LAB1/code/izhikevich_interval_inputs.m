%%%%% IZHIKEVICH'S MODEL %%%%%

function [tspan, v_array, u_array] = izhikevich_interval_inputs(a, b, c, d, ...
    init_v, len_x, inputs_starts, inp_span, inp_curr, tau, conf)
%IZHIKEVICH Implementation of the Izhikevich model

% tspan: x axis for the plot
tspan = 0:tau:len_x;

% v: membrane potential
% u: membrane recovery variable
v = init_v; u = b*v;
v_array = zeros(size(tspan));
u_array = zeros(size(tspan));

idx = 1;
for t = tspan
    for i = 1 : length(inputs_starts)
        inp_start = inputs_starts(i);
        if t > inp_start && t < inp_start + inp_span
            I = inp_curr;
            break;
        else
            I = 0;
        end
    end
    if conf == "L"
        v = v + tau*(0.04*v^2 + 4.1*v + 108 - u + I);
    else
        v = v + tau*(0.04*v^2 + 5*v + 140 - u + I);
    end
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
end

