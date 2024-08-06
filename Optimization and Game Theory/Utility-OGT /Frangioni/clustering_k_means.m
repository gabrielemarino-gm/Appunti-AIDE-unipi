clc, clear

% Given data points
X = [0.7 0.8
     0.8 0.3
     0.3 0.5
     0.7 0.7
     0.7 0.9
     0.2 1.0
     0.1 0.5
     0.5 1.0
     1.0 0.1
     0.3 0.3
     0.6 0.8
     0.2 0.3];

% Initial clusters
clusters = [1 1 1 2 2 2 3 3 3 4 4 4];

% Initializing centroids
c = zeros(4, 2);
for p = 1:4
    c(p, :) = mean(X(clusters == p, :), 1);
end

% Initialize previous objective value to Inf
prev_v = Inf;

% Maximum number of iterations
max_iterations = 100;

% K-means Iteration
converged = false;
iteration = 0;
while ~converged && iteration < max_iterations
    % Assigning points to the nearest centroid
    for i = 1:12
        dist = vecnorm(c - X(i, :), 2, 2);
        [~, ci] = min(dist);
        clusters(i) = ci;
    end
    
    % Updating centroids
    for p = 1:4
        c(p, :) = mean(X(clusters == p, :), 1);
    end
    
    % Calculate the cost (objective function)
    v = sum(vecnorm(X - c(clusters, :), 2, 2).^2);
    
    % Check for convergence
    if abs(prev_v - v) < 1e-6 % or some small number as the threshold
        converged = true;
    else
        prev_v = v;
    end
    
    iteration = iteration + 1;
end

% Display the final clusters and centroids
disp('Final clusters:');
disp(clusters);
disp('Centroids:');
disp(c);
disp('Total cost:');
disp(v);
disp(['Number of iterations: ' num2str(iteration)]);
