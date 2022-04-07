% read the data
[train_inp, train_targets, val_inp, val_targets, test_inp, test_targets] = read_split_data;

% configurations to try the model with
% fields in order: Ne, Ni
configs = [800 200; 500 500; 300 700];
for i = 1 : height(configs)
    Ne = configs(i, 1);
    Ni = configs(i, 2);
    
    % alternative 1
    % [train_states, ~] = modified_lsm(train_inp, Ne, Ni);
    % [val_states, ~] = modified_lsm(val_inp, Ne, Ni);
    % [test_states, ~] = modified_lsm(test_inp, Ne, Ni);
    
    % alternative 2
    [states, ~] = modified_lsm([train_inp, val_inp, test_inp], Ne, Ni);
    train_states = states(:, 1 : length(train_inp));
    val_states = states(:, length(train_inp)+1 : length(train_inp)+length(val_inp));
    test_states = states(:, end - length(test_inp) + 1 : end);
    
    Wout = train_targets * pinv(train_states);
    train_output = Wout * train_states;
    val_output = Wout * val_states;
    test_output = Wout * test_states;
    
    % display training, validation and test mean absolut error (MAE)
    tr_MAE = mean(abs(train_output - train_targets));
    val_MAE = mean(abs(val_output - val_targets));
    test_MAE = mean(abs(test_output - test_targets));
    disp(strcat("Ne: ", string(Ne), ", Ni: ", string(Ni), ...
        " => Training MAE: ", string(tr_MAE), ...
        " - Validation MAE: ", string(val_MAE), ...
        " - Test MAE: ", string(test_MAE)))
    
    % plot
    figure
    tl = tiledlayout(2, 2);
    title(tl, strcat("Ne: ", string(Ne), ", Ni: ", string(Ni)))
    ax1 = nexttile;
    plot(train_targets); hold on
    plot(train_output); hold off
    title(ax1, "Training targets and respective predictions")
    legend("Training targets", "Outputs")
   
    ax2 = nexttile;
    plot(val_targets); hold on
    plot(val_output); hold off
    title(ax2, "Validation targets and respective predictions")
    legend("Validation targets", "Outputs")
    
    ax3 = nexttile;
    plot(test_targets); hold on
    plot(test_output); hold off
    title(ax3, "Test targets and respective predictions")
    legend("Test targets", "Outputs")
    
    ax4 = nexttile;
    plot([train_targets, val_targets, test_targets]); hold on
    plot([train_output, val_output, test_output]); hold off
    title(ax4, "Concatenation of training, validation and test targets and respective predictions")
    legend("Targets", "Outputs")
end