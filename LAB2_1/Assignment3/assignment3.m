% read the data
data = readmatrix("../lab2_1_data.csv");

% uniformly initialize weight vector
w = (1 + 1).*rand(height(data), 1) - 1;

% iterate over epochs
lr = 0.01;
epochs = 100;
n = ones(1, length(data(:,1)));
w_evolution = zeros(3, epochs*length(data));
idx = 1;
for epoch = 1 : epochs
    % shuffle the data
    data = data(:, randperm(length(data)));
    
    % iterate over the patterns
    for t = 1 : length(data)
        pattern = data(:, t);
        output = dot(w, pattern);
        term1 = output.*pattern;
        term2 = dot(n, pattern).*n ./ length(n);
        delta_w = term1 - term2';
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
[max_v, max_i] = max(eigvals);

% plot 1
figure()
plotv(eigvecs(:,max_i));
hold on
scatter(data(1,:), data(2,:))
hold on
plotv(w./norm(w), '-')
legend("Principal eigenvector of correlation matrix", "Training data points", "Weights vector")

% plot 2: 1st component of weights vector over time
figure()
plot(w_evolution(1,:))
xlabel("Time")
ylabel("1st component of weights vector")

% plot 3: 2nd component of weights vector over time
figure()
plot(w_evolution(2,:))
xlabel("Time")
ylabel("2nd component of weights vector")

% plot 4: norm of weights vector over time
figure()
plot(w_evolution(3,:))
xlabel("Time")
ylabel("Norm of weights vector")

% save evolution of weights vector in .mat format
w_evolution = w_evolution(1:2, :);
save('w_evolution.mat', 'w_evolution');
