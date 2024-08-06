close all; clear; clc;
% Include the symbolic toolbox
syms a;

% Define the inequality expression
expr = (2*a^2 - 2*a + 1)^(1/2) - 3*a + 3;

% Find where the expression equals zero, this defines boundary points
boundary_points = solve(expr == 0, a, 'Real', true);

% Convert boundary points to numeric values if they are symbolic
boundary_points = double(boundary_points);

% Sort the boundary points
boundary_points = sort(boundary_points);

% Display the boundary points
disp('Boundary points:');
disp(boundary_points);

% Test points just to the left and right of each boundary point
epsilon = 1e-5;  % Small value to offset from the boundary point
SOL = [];

for i = 1:length(boundary_points)
    % Points to the left and right
    point_left = boundary_points(i) - epsilon;
    point_right = boundary_points(i) + epsilon;

    % Evaluate expression at these points
    value_left = double(subs(expr, a, point_left));
    value_right = double(subs(expr, a, point_right));

    % Determine sign changes
    if value_left >= 0 && value_right < 0
        SOL = [SOL; boundary_points(i), -1];  % -1 indicates positive to the left
    elseif value_left < 0 && value_right >= 0
        SOL = [SOL; boundary_points(i), 1];  % 1 indicates positive to the right
    end
end

% Display the results
disp('SOL = [Boundary Point, Positive Side]');
disp(SOL);
fplot(3 - sqrt(2*a^2 - 2*a + 1) - 3*a)