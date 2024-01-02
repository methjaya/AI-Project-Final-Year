clc, close all, clear all

load fisheriris

dataset = meas;

% ----TASK 2.2 (1)----
% Randomly shuffling the dataset
rand_indices = randperm(size(dataset, 1));

% Initializing percentage for training
training_percentage = 0.6;
training_size = round(training_percentage * size(dataset, 1));

% Dividing the dataset into training and testing
training_dataset = dataset(rand_indices(1:training_size), :);
testing_dataset = dataset(rand_indices(training_size+1:end), :);

% Creating training and testing targets
training_target = double(categorical(species(rand_indices(1:training_size))));
testing_target = double(categorical(species(rand_indices(training_size+1:end))));


% Assigning hidden layer sizes and number of experiments
hidden_layer_sizes = [10, 15, 20];
experiments_count = 3; 

% ----TASK 2.2 (3)----
% Outer loop for hidden layer sizes
for l = 1:length(hidden_layer_sizes)
    hidden_layer_size = hidden_layer_sizes(l);
    
    accuracy_sum = 0;

    % ----TASK 2.2 (2)----
    % Initializing the feedforward neural network with hidden layer size     
    net = feedforwardnet(hidden_layer_size);

    % Inner loop for all the experiments
    for e = 1:experiments_count
    
        % ----TASK 2.2 (4)----
        % Training the neural network with training data and target
        net = train(net, training_dataset', training_target');
        % View trained net
        view(net);

        % ----TASK 2.2 (5)----
        % Getting the predictions from the trained net
        predictions = net(testing_dataset');
        predicted_labels = round(predictions);
        % Calculating the classifier accuracy
        classifier_accuracy = (sum(predicted_labels == testing_target') / length(testing_target)) * 100;

        % Displaying the performances
        disp(['Hidden layer size ' num2str(hidden_layer_size) ' Experiment ' num2str(e)]);
        disp(['Accuracy: ' num2str(classifier_accuracy)]);
        disp(' ');

        accuracy_sum = accuracy_sum + classifier_accuracy;
    end

    % ----TASK 2.2 (5)----
    % Calculating average performance
    disp(['Average percentage of correct classifications with ' num2str(hidden_layer_size) ' hidden layers and ' num2str(experiments_count) ' experiments : ' num2str(accuracy_sum/experiments_count) '%'])
    disp(' ');
    disp(' ');
end

