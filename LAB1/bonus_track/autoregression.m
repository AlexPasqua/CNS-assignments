% read the data
[train_inp, train_targets, val_inp, val_targets, test_inp, ...
    test_targets] = read_split_data;

% configurations to try the model with
% fields in order: Ne, Ni
configs = [800 200; 500 500; 300 700];
for i = 1 : 1 %height(configs)
    Ne = configs(i, 1);
    Ni = configs(i, 2);
    
    [train_states, ~] = modified_lsm(train_inp, Ne, Ni);
    [val_states, ~] = modified_lsm(val_inp, Ne, Ni);
    
    Wout = train_targets * pinv(train_states);
    train_output = Wout * train_states;
    val_output = Wout * val_states;
    
    %disp(mean(abs(train_output - train_targets)))
    disp(mean(abs(val_output - val_targets)))
end

plot(val_targets); hold on
plot(val_output); hold off
%figure
%plot(train_targets); hold on
%plot(train_output); hold off