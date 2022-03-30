function [train_inp, train_targets, val_inp, val_targets, test_inp, ...
    test_targets] = read_split_data()
%READ_SPLIT_DATA Reads and split the data (laser_dataset) into training,
%validation and test sets. Each one is divided into inputs and targets
load laser_dataset;
whole_dataset = cell2mat(laserTargets);
input_dataset = whole_dataset(:,1:end-1);
target_dataset = whole_dataset(:,2:end);
tr_ts_split = 1500;
train_set = [input_dataset(1:tr_ts_split); target_dataset(1:tr_ts_split)];
test_set = [input_dataset(tr_ts_split+1 : tr_ts_split+500); target_dataset(tr_ts_split+1: tr_ts_split+500)];
val_split = int16(20 * tr_ts_split / 100);
val_set = train_set(:, end - val_split + 1 : end);
train_set = train_set(:, 1 : end - val_split);

train_inp = train_set(1, :);
train_targets = train_set(2, :);
val_inp = val_set(1, :);
val_targets = val_set(2, :);
test_inp = test_set(1, :);
test_targets = test_set(2, :);
end

