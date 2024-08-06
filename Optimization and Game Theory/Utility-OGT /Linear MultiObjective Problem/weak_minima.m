% ex is P(1, -1) a weak minima?
%
% min (3X_1 + 2X_2, -X_1 - 2X_2)
% X_1 + 2X_2 <= 0
% -X_1 <= -1
% X_1 - 2X_2 <= 4
%
% max v
% v <= eps_1
% v <= eps_2
% 3X_1 + 2X_2 + eps_1 <= 1---> sostituire P nella prima funzione obiettivo
% -X_1 - 2X_2 + eps_2 <= 1---> sostituire P nella seconda funzione obb.
% X_1 + 2X_2 <= 0
% -X_1 <= -1
% X_1 - 2X_2 <= 4
% eps_1 >= 0
% eps_2 >= 0

clc, clear, close all;

% Coordinates of point P
P = [1; -1];

% Inequality constraints matrix
% X_1 X_2 eps_1 eps_2 v
A = [0 0 -1 0 1
     0 0 0 -1 1
     3 2 1 0 0
    -1 -2 0 1 0
     1 2 0 0 0
    -1 0 0 0 0
     1 -2 0 0 0
];

% Inequality constraints vector
b = [0; 0; 1; 1; 0; -1; 4];

% Objective function coefficients
c = [0; 0; 0; 0; -1];

% Equality constraints matrices
Aeq = [];

% Equality constraints vector
beq = [];

% Lower bounds for variables
% lb = [zeros(length(c) - 1, 1); -Inf]; solo se x e esp >= 0
lb = [-Inf; -Inf; 0; 0; -Inf];

% Upper bounds for variables
ub = [];

% Solve the linear programming problem
[x, fval] = linprog(c, A, b, Aeq, beq, lb, ub)

% Check if P is a weak minimum
if (fval == 0)
    disp('P is a weak minimum');
else
    disp('P is not a weak minimum');
end
