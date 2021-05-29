% load the data into 3 vectors: p0, p1, p3 representing 3 images of digits
load lab2_2_data.mat

m = 3;  % number of vectors
dataset = [p0, p1, p2];
state = p0;
w = zeros(length(state), length(state));

% iterate over epochs
epochs = 500;
overlaps = zeros(m, epochs);
range = 1 : length(state);
for i = 1 : epochs
    % pick a random order of neurons' update
    order = range(randperm(length(range)));
    
    % iterate over neurons in the random order
    for j = 1 : length(order)
        idx = order(j);
        sum = 0;
        for k = 1 : length(state)
            sum = sum + w(j,k) * state(k);
        end
        state(j) = sign(sum);
    end
    
    % computer overlap
    
    
    % update weights
    sum = zeros(length(state), length(state));
    for j = 1 : m
        sum = sum + dataset(:, j) * dataset(:, j)';
    end
    w = sum./length(state) - m.*eye(length(state));
end