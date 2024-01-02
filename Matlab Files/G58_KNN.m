clc, close all, clear all

% ----TASK 2.4 (1)----
load fisheriris


% ----TASK 2.4 (2)----
% Shuffling and taking 60% for training and 40% for testing from each
% species equally

% Assign species to a categorical array to derive different categories(species)
species_categorical = categorical(species);

% Get each category of species
unique_species = categories(species_categorical);

% Initialize variables to store training and testing data
training_dataset = zeros(length(species) * 0.6, 4); training_target = categorical();
testing_dataset = zeros(length(species) * 0.4, 4); testing_target = categorical();

% Data amount for each category
trn_percentage = (length(species) / length(unique_species)) * 0.6;
tst_percentage = (length(species) / length(unique_species)) * 0.4;

% Initializing variables to hold indices
training_data_indices = 1:1:trn_percentage;
testing_data_indices = 1:1:tst_percentage;

for i = 1 : length(unique_species)
    % Get indices of each species
    indcs = find(species_categorical == unique_species{i});

    % Shuffle the indices
    indcs = indcs(randperm(length(indcs)));

    %  Allocating 60% for training
    training_dataset(training_data_indices,:) = [meas(indcs(1:round(length(indcs)*0.6)),:)];
    training_target(training_data_indices,:) = [species_categorical(indcs(1:round(length(indcs)*0.6)),:)];

     % Allocating 40% for testing
    testing_dataset(testing_data_indices,:) = [meas(indcs(1+round(length(indcs)*0.6):end),:)];
    testing_target(testing_data_indices,:) = [ species_categorical(indcs(1+round(length(indcs)*0.6):end),:)];

    % Using if statement to prevent unnecessary increment of the indices in the last iteration
    if i <= length(unique_species)-1
    % Incrementing the indices
    training_data_indices = training_data_indices  + trn_percentage;
    testing_data_indices = testing_data_indices + tst_percentage;
    end
end


% Assigning K values
k_values = [5 7];


% Performing k-NN for all the K values using a loop
for i = 1:length(k_values)

    k_value = k_values(i);

    % ----TASK 2.4 (3)----
    % Training the k-NN classifier using fitcknn
    knn_mdl = fitcknn(training_dataset, training_target, 'NumNeighbors', k_value,'Standardize',1);
    % Predicting using testing data
    predicted_classifications = predict(knn_mdl, testing_dataset);
    
    % ----TASK 2.4 (4)----
    % Displaying the confusion matrix
    figure;
    confusion_chart = confusionchart(testing_target, predicted_classifications);
    confusion_chart.RowSummary = 'row-normalized';
    confusion_chart.ColumnSummary = 'column-normalized';
    confusion_chart.Title = ['Confusion chart for K = ' num2str(k_value)];

    % Displaying the percentage of correct classifications
    disp(['Correct classifications for K = ' num2str(k_value)]);
    disp(['Percentage of correct classifications: ' num2str((sum(testing_target == predicted_classifications) / length(testing_target)) * 100) '%']);
    disp(' ');

end

% ----TASK 2.4 (5)----
% Limitations/Drawbacks of KNN
fprintf('Because KNN uses distance metrics to measure how similar data points are, features with larger scales contribute more to the distance calculation than features with smaller scales. \nIf one feature has a much larger range than another, it can dominate the distance measure. This may produce biased results.\n\n')
fprintf('KNN does not work well with imbalanced data. It may biased toward the majority class in imbalanced datasets, since the majority class is likely to dominate the nearest neighbors. \nThis may result in the algorithm wrongly classifies the less common class.\n\n')
fprintf('Peforming KNN with larger datasets is computationally expensive. \nDue to when the algorithm making predictions for a new data point it needs to compute the distances between that point and all other points in the training dataset to identify the nearest neighbors. \nThis makes KNN algorithm time consuming and inefficient for larger datasets.\n\n')
fprintf('KNN depends on storing the entire dataset on memory because it needs to refer to the entire dataset when making predictions. \nSo KNN consumes more memory with larger datasets.\n\n')
fprintf('The value of a target variable is predicted by KNN based on the similarity of its features to those of its nearest neighbors. \nSo outliers can significantly influence the accuracy of KNN predictions.')










