% read the data
data = readmatrix("../lab2_1_data.csv");

% uniformly initialize weight vector
w = (1 + 1).*rand(height(data), 1) - 1;

% iterate over epochs
lr = 0.1;
epochs = 10;
for epoch = 1 : epochs
    % shuffle the data
    data = data(:, randperm(length(data)));
    
    % iterate over the patterns
    for n = 1 : length(data)
        pattern = data(:, n);
        output = dot(w, pattern);
        w = w + (lr * output).*pattern;
    end
end

Q = data * data';
[eigvecs, eigvals] = eig(Q);
eigvals = diag(eigvals);
[max_v, max_i] = max(eigvals);
plotv(eigvecs(:,max_i));
hold on
w = w./norm(w);
scatter(data(1,:), data(2,:))
hold on
plotv(w, '-')