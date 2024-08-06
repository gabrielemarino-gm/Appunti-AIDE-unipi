%% Unconstrained optimization -- Exercise 3.3
clear; close all; clc; 

%% Data
alpha = 0.1;
gamma = 0.8;
tbar = 1;
x0 = [ -10 ; 8];
tolerance = 10^(-6) ;

%% Method: gradient method with inexact line search
X = [];
ITER = 0 ;
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
    v = 2*x(1)^2 + x(2)^2 - x(1)*x(2) + exp(x(1)+2*x(2));
    g = [4*x(1)-x(2)+exp(x(1)+2*x(2));
         2*x(2)-x(1)+2*exp(x(1)+2*x(2))];
end