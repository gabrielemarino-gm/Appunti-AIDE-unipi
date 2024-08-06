close all; clear; clc;

% Define the inequalities g_i(x) in terms of x(1), x(2), and x(3)
% Example: For g1(x) = x(1)^2 + x(2)^2 + x(3)^2 - 1 <= 0 (a sphere)
g{1} = @(x) x(1) - x(2) - x(3);
g{2} = @(x) - x(1);
g{3} = @(x) x(3) - 1;
% Define additional inequalities if needed

% Define the range of x1, x2, and x3
FINEZZA=150; % ATTENZIONE LA COMPLESSITÀ SPAZIALE SALE CON IL CUBO!!!
x1 = linspace(-3, 3, FINEZZA); % Adjust the range as needed
x2 = linspace(-3, 3, FINEZZA); % Adjust the range as needed
x3 = linspace(-3, 3, FINEZZA); % Adjust the range as needed

% Generate grid of points
[X1, X2, X3] = meshgrid(x1, x2, x3);
[n, m, p] = size(X1);

% Evaluate inequalities at each point on the grid
domain = ones(n, m, p);
for k = 1:numel(g)
    for i = 1:n
        for j = 1:m
            for l = 1:p
                x = [X1(i, j, l); X2(i, j, l); X3(i, j, l)];
                if g{k}(x) > 0
                    domain(i, j, l) = 0; % Point does not satisfy this inequality
                end
            end
        end
    end
end

% Plot the domain
figure;
isosurface(X1, X2, X3, domain, 0); % Plotting the domain as a surface
xlabel('x1');
ylabel('x2');
zlabel('x3');
title('Domain of the inequalities');
axis equal;

