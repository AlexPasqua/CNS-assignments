function [prev_state] = get_prev_state(X, t, default_prev_state)
%Returns the previous state
if t == 1
    prev_state = default_prev_state;
else
    prev_state = X(:, t-1);
end
end

