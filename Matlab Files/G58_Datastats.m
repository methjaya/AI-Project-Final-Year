clc, clear vars, close all

% ----TASK 2.1 A----
% Loading the dataset
load('fisheriris.mat');

% ----TASK 2.1 B----
% Displaying the total number of rows
total_rows = size(meas, 1);
disp(['Total number of rows : ' num2str(total_rows)]);
disp(' ');

features = size(meas,2);

% ----TASK 2.1 C----
% Statistics for each column
for i = 1:features

    feature = meas(:, i);

    % Column
    disp(['Column (Feature) ' num2str(i)]);
    disp(' ');

    % Mean
    disp(['Mean: ' num2str(mean(feature))]);

    % Standard deviation
    disp(['Standard deviation: ' num2str(std(feature))]);

    % Max
    disp(['Maximum: ' num2str(max(feature))]);

    % Min
    disp(['Minimum: ' num2str(min(feature))]);
    
    % Root Mean Square
    disp(['Root Mean Square: ' num2str(rms(feature))]);

    disp(' ');
end


