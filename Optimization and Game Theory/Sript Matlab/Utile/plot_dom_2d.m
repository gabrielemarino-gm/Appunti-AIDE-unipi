close all; clear; clc;

% Define the inequalities g_i(x) in terms of x(1) and x(2)
% Example: For g1(x) = x(1) - 2*x(2) <= 0
g{1} = @(x) - 2*x(1) + x(2);
g{2} = @(x) - x(1) + x(2);
%g{3} = @(x) -x(1);
% Define additional inequalities if needed
% For example:
% g{2} = @(x) x(1) + x(2) - 3 <= 0;

% Define the range of x1 and x2
x1 = linspace(-10, 10, 1000); % Adjust the range as needed
x2 = linspace(-10, 10, 1000); % Adjust the range as needed

% Generate grid of points
[X1, X2] = meshgrid(x1, x2);
[n, m] = size(X1);

% Evaluate inequalities at each point on the grid
domain = ones(n, m);
for k = 1:numel(g)
    for i = 1:n
        for j = 1:m
            x = [X1(i, j); X2(i, j)];
            if g{k}(x) > 0
                domain(i, j) = 0; % Point does not satisfy this inequality
            end
        end
    end
end

% IN GIALLO IL DOMINIO
% Plot the domain
figure;
contourf(X1, X2, domain, [0, 1]); % Plotting the domain as a filled contour
xlabel('x1');
ylabel('x2');
title('Domain of the inequalities');
colorbar;
