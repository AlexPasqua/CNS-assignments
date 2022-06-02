function [X_tr, X_ts] = esn_compute_states(tr_inp, ts_inp, Nr, Win, Wr)
% Computes the state sequence of the ESN given the input sequence and the weights
whole_inp = [tr_inp, ts_inp];
tot_len = length(whole_inp);
X = zeros(Nr, tot_len);     % states matrix
for t = 1 : tot_len
    prev_state = get_prev_state(X, t, zeros(Nr, 1));
    X(:,t) = tanh(Win*[whole_inp(t);1] + Wr*prev_state);
end
X = [X; ones(1, tot_len)];  % add ones for bias
X_tr = X(:, 1 : length(tr_inp));
X_ts = X(:, length(tr_inp) + 1 : end);
end

