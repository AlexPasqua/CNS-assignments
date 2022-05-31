function [conf] = get_rand_hyperparametrization(max_inputDelay, ...
    max_hiddenSize, max_n_hiddenLayers, train_funcs)
% returns a random hyperparametrization
inputDelays = randi(max_inputDelay);
hiddenSizes = randi(max_hiddenSize, [1 randi(max_n_hiddenLayers)]);
lr = rand;
trainFcn = train_funcs(randi(length(train_funcs)));
conf = struct('inputDelays', inputDelays, 'hiddenSizes', hiddenSizes, ...
    'lr', lr, 'trainFcn', trainFcn);
end

