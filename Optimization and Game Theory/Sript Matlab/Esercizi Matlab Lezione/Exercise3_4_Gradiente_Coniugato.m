clear; close all; clc;
% format short e

%% Quadratic Problem

% Problem definition
Q = [6 1 0 2; 
     1 2 0 0;
     0 0 4 2;
     2 0 2 8]

c = [ -1 8 6 9]';

disp('Eigenvalues of Q:')
eig(Q)

%% Parameters

x0 = [0, 0, 0, 0]';
tolerance = 10^(-6);


%% Conjugate Gradient method

% starting point
x = x0;
X = [];
for ITER = 1:10
    % valore e gradiente della funzione obiettivo
    v = 0.5*x'*Q*x + c'*x;
    g = Q*x + c;

    X = [X; ITER, x'];

    % stopping criterion
    if norm(g) < tolerance
        break
    end
    
    % search direction
    if ITER == 1
        d = -g; 
    else
        beta = (g'*Q*d_prev)/(d_prev'*Q*d_prev);
        d = -g + beta*d_prev;
    end
    
    % step size
    t = (-g'*d)/(d'*Q*d);
    
    % new point
    x = x + t*d; 

    % update search direction
    d_prev = d; 
end
X
disp('Gradient Norm')
norm(g)



