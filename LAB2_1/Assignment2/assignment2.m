% read the data
data = readmatrix("../lab2_1_data.csv");

% uniformly initialize weight vector over [-1, 1]
w = (1 + 1) .* rand(height(data), 1) - 1;

% iterate over epochs
lr = 0.01;
alpha = 0.1;
epochs = 50;
w_evolution = zeros(3, epochs*length(data));
converged = false;
idx = 1;
for epoch = 1 : epochs
    % shuffle the data
    data = data(:, randperm(length(data)));
    
    % iterate over the patterns
    for n = 1 : length(data)
        pattern = data(:, n);
        output = dot(w, pattern);
        
        % weights update
        delta_w = output .* pattern - alpha * output^2 .* w;
        w = w + lr .* delta_w;
        
        w_evolution(1, idx) = w(1);
        w_evolution(2, idx) = w(2);
        w_evolution(3, idx) = norm(w);
        idx = idx + 1;
    end
end

% correltion matrix and eigenvector
Q = data * data';
[eigvecs, eigvals] = eig(Q);
eigvals = diag(eigvals);
[~, max_i] = max(eigvals);

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
plot(w_evolution(3,:))
xlabel("Time")
ylabel("Norm of the weights vector")
title("P2: norm of the weights vector over time")

% save evolution of weights vector in .mat format
w_evolution = w_evolution(1:2, :);
save('w_evolution.mat', 'w_evolution');
