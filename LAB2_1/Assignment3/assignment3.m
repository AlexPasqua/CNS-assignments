% read the data
data = readmatrix("../lab2_1_data.csv");

% uniformly initialize weight vector
w = (1 + 1).*rand(height(data), 1) - 1;

% iterate over epochs
lr = 0.01;
epochs = 100;
n = ones(1, length(data(:,1)));
w_evolution = [];
w_norm_evolution = [];
idx = 1;
for epoch = 1 : epochs
    % shuffle the data
    data = data(:, randperm(length(data)));
    
    % iterate over the patterns
    for t = 1 : length(data)
        pattern = data(:, t);
        output = dot(w, pattern);
        
        % weights update (subtractive normalization rule)
        term1 = output.*pattern;
        term2 = dot(n, pattern).*n ./ length(n);
        delta_w = term1 - term2';
        w_new = w + lr .* delta_w;
        
        w = w_new;
        idx = idx + 1;
    end
    
    w_evolution(:, end+1) = w_new;
    w_norm_evolution(end+1) = norm(w_new);
end

% correltion matrix and eigenvector
Q = data * data';
[eigvecs, eigvals] = eig(Q);
eigvals = diag(eigvals);
[max_v, max_i] = max(eigvals);

% P1
figure()
plotv(eigvecs(:, max_i), '-')
hold on
scatter(data(1,:), data(2,:))
hold on
plotv(w ./ norm(w), '--')
legend("Principal eigenvector of correlation matrix", "Training data points", "Weights vector")
title("P1")

% P2: 1st component of weights vector over time
figure()
plot(w_evolution(1,:))
xlabel("Time")
ylabel("1st component of the weights vector")
title("P2: 1st component of the weights vector over time")

% P2: 2nd component of weights vector over time
figure()
plot(w_evolution(2,:))
xlabel("Time")
ylabel("2nd component of the weights vector")
title("P2: 2nd component of the weights vector over time")

% P2: norm of weights vector over time
figure()
plot(w_norm_evolution)
xlabel("Time")
ylabel("Norm of the weights vector")
title("P2: norm of the weights vector over time")

% save evolution of weights vector in .mat format
save('w_evolution.mat', 'w_evolution');