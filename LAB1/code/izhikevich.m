%%%%% IZHIKEVICH'S MODEL %%%%%

function [v, u] = izhikevich(a, b, v, u, I, tau)
% v: membrane potential
% u: membrane recovery variable
v = v + tau*(0.04*v^2 + 5*v + 140 - u + I);
u = u + tau*a*(b*v - u);
end