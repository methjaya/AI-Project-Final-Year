clc, clear vars, close all;

% ----TASK 2.3 (1)----
% Load Kmeans data
load('kmeansdata.mat');

% Assign data
data_set = X;

% Clusters
clusters = [3, 4, 5];

% Initializing variables to store results
mean_silhouette_values = zeros(length(clusters), 1);
colors = [1 0 0;0 1 0;0 0 1;1 0 1;0.9290 0.6940 0.1250];
silhouette_figure = figure;

% ----TASK 2.3 (2)----
% k-means clustering for different number of clusters
for i = 1:length(clusters)
    k = clusters(i);

    % k-means clustering
    [idx, centroids] = kmeans(data_set, k);

    % ----TASK 2.3 (3)----
    % Plot silhoutte for each cluster
    figure(silhouette_figure);
    subplot(2,2,i);
    [silhouette_values,h]=silhouette(data_set, idx);
    title(['Number of clusters = ' int2str(k)]);
    xlabel 'Silhouette Value ';
    ylabel 'Cluster';
    hold on;    

    % Store mean silhouette value
    mean_silhouette_values(i) = mean(silhouette_values);
    
    % ----TASK 2.3 (3)----
    % Display mean silhoutte values for each cluster
    disp(['Cluster ' num2str(i) ' Mean silhoutte value : ' num2str(mean_silhouette_values(i))]);

    % ----TASK 2.3 (4)----
    % Plot clusters and centroids
    figure;
    gscatter(data_set(:, 1), data_set(:, 2), idx,colors,'.', 8);
    hold on;
    plot(centroids(:, 1), centroids(:, 2), 'kx', 'MarkerSize', 15, 'LineWidth', 3);
    title(['K-Means Clustering with K = ' num2str(k)]);

    % Adding the legend for different clusters
    if k==3
        legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Centroids','Location', 'NW');
    elseif k==4
        legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4','Centroids','Location', 'NW');
    elseif k==5
        legend('Cluster 1', 'Cluster 2', 'Cluster 3','Cluster 4','Cluster 5', 'Centroids','Location', 'NW');
    end
    hold off;
end
disp(' ');

% ----TASK 2.3 (4)----
% Stopping criteria for Kmeans
disp('When there are no changes in cluster centroids between iterations.');
disp('When there are no changes in cluster assignments between iterations.');
disp('When the algorithm reaches the predefined maximum iterations.');


% ----TASK 2.3 (5)----
% Best number of clusters
[best_silhouette, best_cluster_index] = max(mean_silhouette_values);
best_cluster = clusters(best_cluster_index);
disp(['The best number of clusters : ' num2str(best_cluster)]);
disp(['Mean silhouette value for the best cluster: ' num2str(best_silhouette)]);
disp(' ');

% ----TASK 2.3 (5)----
% Explanation for the best number of clusters
fprintf(['In k-means clustering, the silhoutte is used to measure the effectiveness of the clustering.\n' ...
    'A high silhouette value indicates that the object is well matched to its own cluster.\n' ...
    'Because of that this code calculates the mean silhouette value for all the clusters and selects the cluster with maximum mean silhouette value as the best number of clusters.\n' ...
    'The best number of clusters are ' num2str(best_cluster) ' because the mean silhoutte value for this cluster is ' num2str(best_silhouette) '\n' ...
    'which is the highest and indicates that the objects are well separated compared to other clusters.\n']);
fprintf('\n');


% ----TASK 2.3 (6)----
% Limitations/Drawbacks of k-means clustering
fprintf('1. One disadvantage of the K-means algorithm is that we must specify the number of clusters in advance.\nChoosing the wrong number of clusters may lead to inaccurate results.\n\n');
fprintf('2. Another disadvantage is K-means algorithm cannot handle non numerical or categorical data.\nK-means algorithm works only with numerical data to determine distances between data points.\nIf categorical data needs to be used it has to be converted to numerical data, which can be difficult or not possible with every dataset.\n\n');
fprintf('3. K-means clustering is sensitive to the initial centroid placements.\nThe final clusters are formed by starting with randomly placing centroids and iteratively updating the centroids, reassigning data points based on their proximity to the centroids.\nDifferent initializations may lead to different cluster outcomes and makes the K-means algorithm less reliable and reproducible.\n\n');
fprintf('4. When using high dimentional datasets with k-means clustering, the distance between any two data points gets more similar \nand makes it difficult to identify meaningful patterns or relationships in the data as the number of dimensions increases.\n\n');
fprintf('5. Since the complexity of k-means algorithm is determined by number of clusters, the number of data points, and the number of dimentions, \nwhen using high dimentional datasets makes it computationally expensive and time-consuming because it requires multiple iterations and distance calculations.\n\n');
fprintf('6. K-means is sensitive to outliers. Outliers may drag the centroids, or they may form their own cluster rather than being ignored. \nBecause of this a single outlier can drastically affect the locations of centroids and distort the resulting clusters.');
