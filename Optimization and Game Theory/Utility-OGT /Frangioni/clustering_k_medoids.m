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
medoids_idx = [initial_clusters{1}(1), initial_clusters{2}(1), initial_clusters{3}(1), initial_clusters{4}(1)];  % for example, choosing the first element of each initial cluster

% Assign points to nearest medoids initially
clusters = assignToNearestMedoids(X, medoids_idx);

% Maximum number of iterations
max_iterations = 100; % You can adjust this value

iteration = 0;
while true
    old_medoids_idx = medoids_idx;
    
    % Update Medoids
    for i=1:length(medoids_idx)
        medoids_idx(i) = findNewMedoid(X, clusters, i);
    end
    
    % Assign points to nearest medoids
    clusters = assignToNearestMedoids(X, medoids_idx);
    
    % Convergence check
    if all(medoids_idx == old_medoids_idx) || iteration >= max_iterations
        break;
    end
    
    iteration = iteration + 1;
end

% Calculate the total cost (Sum of L1 distances)
cost = 0;
for i=1:length(X)
    cost = cost + sum(abs(X(i,:) - X(medoids_idx(clusters(i)),:)));
end

disp('Final clusters:');
disp(clusters);
disp('Medoids:');
disp(X(medoids_idx,:));
disp('Total cost:');
disp(cost);
disp(['Number of iterations: ' num2str(iteration)]);

% Utils Function

function idx = assignToNearestMedoids(X, medoids_idx)
    idx = zeros(length(X), 1);
    for i = 1:length(X)
        [~, idx(i)] = min(sum(abs(X(i,:) - X(medoids_idx,:)), 2));
    end
end

function new_medoid = findNewMedoid(X, idx, medoid_cluster)
    cluster_points = X(idx == medoid_cluster, :);
    % Calculate distances of all points in the cluster to all other points in the cluster
    distances = sum(abs(cluster_points - cluster_points), 2);
    % Find the point with the minimum total distance to all other points (the new medoid)
    [~, min_idx] = min(sum(distances));
    cluster_indices = find(idx == medoid_cluster);  % Indices of all points in the cluster
    new_medoid = cluster_indices(min_idx);  % The actual index of the new medoid in the original dataset
end
