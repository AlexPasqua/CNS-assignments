%%%%% (R) accomodation %%%%%

% parameters
a=0.02;  b=1; c=-55;  d=4;

% initial membrane potential
v = -65;  u = -16;

% name of the nauro-computational feature (for plots)
name = "(R) Accomodation";

v_array = zeros(size(tspan));
u_array = zeros(size(tspan));
len_x = 400;
tau = 0.5; tspan = 0:tau:len_x;
idx = 1;
for t=tspan
    if (t < 200)
        I=t/25;
    elseif t < 300
        I=0;
    elseif t < 312.5
        I=(t-300)/12.5*4;
    else
        I=0;
    end
    v = v + tau*(0.04*v^2+5*v+140-u+I);
    u = u + tau*a*(b*(v+65));
    if v > 30
        v_array(idx)=30;
        v = c;
        u = u + d;
    else
        v_array(idx)=v;
    end
    u_array(idx)=u;
    II(idx)=I;
    idx = idx + 1;
end

% plot
figure()
plot(tspan, v_array, tspan,II*1.5-90);
title(name)
xlabel("Time")
ylabel("Membrane potential")
legend("Membrane potential", "Input current")

figure()
plot(v_array, u_array)
title(name + " phase portrait")
xlabel("Membrane potential variable")
ylabel("Recovery variable")