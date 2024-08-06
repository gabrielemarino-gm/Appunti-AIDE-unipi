clc, clear

% Given Data Points
X = [0.8 1.0
     0.9 0.5
     0.1 0.8
     0.9 0.1
     0.6 0.4
     0.1 0.9
     0.3 0.8
     0.5 1.0
     1.0 0.7
     1.0 0.0
     0.2 0.8
     1.0 0.9];

% Initial clusters' indexes
initial_clusters = { [1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12] };
medians_idx = [initial_clusters{1}(1), initial_clusters{2}(1), initial_clusters{3}(1), initial_clusters{4}(1)];  % for example, choosing the first element of each initial cluster

% Assign points to nearest medians initially
clusters = assignToNearestMedians(X, medians_idx);

% Maximum number of iterations
max_iterations = 100;

iteration = 0;
while true
    old_medians_idx = medians_idx;
    
    % Update Medians
    for i=1:length(medians_idx)
        medians_idx(i) = findNewMedian(X, clusters, i);
    end
    
    % Assign points to nearest medians
    clusters = assignToNearestMedians(X, medians_idx);
    
    % Convergence check
    if all(medians_idx == old_medians_idx) || iteration >= max_iterations
        break;
    end
    
    iteration = iteration + 1;
end

% Calculate the total cost (Sum of L1 distances)
cost = 0;
for i=1:length(X)
    cost = cost + sum(abs(X(i,:) - X(medians_idx(clusters(i)),:)));
end

disp('Final clusters:');
disp(clusters);
disp('Medians:');
disp(X(medians_idx,:));
disp('Total cost:');
disp(cost);
disp(['Number of iterations: ' num2str(iteration)]);

% Utils Function

function idx = assignToNearestMedians(X, medians_idx)
    idx = zeros(length(X), 1);
    for i = 1:length(X)
        [~, idx(i)] = min(sum(abs(X(i,:) - X(medians_idx,:)), 2));
    end
end

function new_median = findNewMedian(X, idx, median_cluster)
    cluster_points = X(idx == median_cluster, :);
    % Calculate L1 distance for all points in the cluster to all other points in the cluster
    % Note: This might be a computationally expensive step and there are more efficient ways to calculate it
    distances = pdist2(cluster_points, cluster_points, 'cityblock');
    total_distances = sum(distances, 2);  % Sum of distances to all other points
    [~, min_idx] = min(total_distances);  % Find the index of the new median
    cluster_indices = find(idx == median_cluster);  % Indices of all points in the cluster
    new_median = cluster_indices(min_idx);  % The actual index of the new median in the original dataset
end
