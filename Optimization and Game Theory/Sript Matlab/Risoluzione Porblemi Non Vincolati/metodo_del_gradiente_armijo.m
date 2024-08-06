%% Unconstrained optimization -- Exercise 3.3
clear; close all; clc; 

%% Data
alpha = 0.5;
gamma = 0.8;
tbar = 1;
x0 = [1, 2];
tolerance = 10^(-3) ;

%% Method: gradient method with inexact line search
X = [];
ITER = 1;
x = x0 ;

while true
    [v, g] = f(x);
    X = [X; ITER, x(1), x(2), v, norm(g)];
    
    % stopping criterion
    if norm(g) < tolerance
        break
    end
    
    % search direction
    d = -g;
    
    % Armijo inexact line search
    t = tbar;
    sinistra=f(x + t*d);
    destra=v + alpha * g' * d * t;
    while f(x + t*d) > v + alpha * g' * d * t
        t = gamma * t;
    end
        
    % new point
    x = x + t*d;
    ITER = ITER + 1;
end

disp('optimal solution')
x
v
norm(g)
ITER

% funzione per il calcolo del valore e del gradiente della funzione
function [v, g] = f(x) 
    % v è il valore della funzione obiettivo in x
    v = x(1)^2 + x(2)^2 - 2*x(1)*x(2) + (1/(x(1)+1));
    
    % g è il gradiente della funzione obiettivo in x
    g = [2*x(1) - 2*x(2) - (1/(x(1) + 1)^2); 2*x(2) - 2*x(1)];
end