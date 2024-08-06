%% Unconstrained optimization -- Exercise 3.3 (Modified for Constraints)
clear; close all; clc;

%% Data
alpha = 0.5;
gamma = 0.8;
tbar = 1;
x0 = [1; 2];
tolerance = 10^(-3);

%% Method: gradient method with inexact line search and projection

X = [];
ITER = 1;
x = x0;
while true
    [v, g] = f(x);
    X = [X; ITER, x(1), x(2), v, norm(g)];

    % Stopping criterion
    if norm(g) < tolerance
        break;
    end

    % Search direction
    d = -g;

    % Projection onto the feasible region (x1 > 0, x2 > 0)
    d = project_feasible(d, x);  % New function for projection

    % Armijo inexact line search
    t = tbar;
    while f(x + t * d) > v + alpha * g' * d * t
        t = gamma * t;
    end

    % New point
    x = project_feasible(x + t * d, x);  % Project again after update

    ITER = ITER + 1;
end

disp('Optimal solution (subject to constraints)');
x
v
norm(g)
ITER

% Function for objective value and gradient
function [v, g] = f(x)
    v = x(1)^2 + x(2)^2 - 2*x(1)*x(2) + (1/(x(1)+1));
    g = [2*x(1) - 2*x(2) - (1/(x(1) + 1)^2), 2*x(2) - 2*x(1)];
end

% Function for projection onto the feasible region (x1 > 0, x2 > 0)
function y = project_feasible(x, prev_x)
    y = max(0, x(1));  % Enforce non-negativity for x1
    y = [y; max(0, x(2))];  % Enforce non-negativity for x2 (vectorized)

    % Handle potential issues at the boundary (e.g., very small positive values)
    if (prev_x(1) > 0 && y(1) < 1e-6) || (prev_x(2) > 0 && y(2) < 1e-6)
        warning('Solution might be very close to the constraint boundary.');
    end
end
