%% Unconstrained optimization - Newton method with (inesact) line search
clear; close all;  

%% data 
alpha = 0.1;
gamma = 0.9;
tbar = 1;
x0 = [0;0];
tolerance = 10^(-3) ;
x = x0 ;

for ITER = 0:100
    [v, g, H] = f(x);
    % stopping criterion
    if norm(g) < tolerance % || norm(g) == 0
        break
    end
    
    % search direction
    d = -inv(H)*g;
    t = tbar;
    while (f(x+t*d) > f(x)+alpha*t*d'*g)
        t = gamma*t;
    end

    % new point
    x = x + t*d; 
end

x
v
norm(g)

% funzione che restituisce il valore, il gradiente e l'hesseiano della funzione
function [v, g, H] = f(x) 
    % v è il valore della funzione obiettivo in x
    v = 2*x(1)^4 + 3*x(2)^4 + 2*x(1)^2 + 4*x(2)^2 + x(1)*x(2) - 3*x(1) - 2*x(2);

    % g è il gradiente della funzione obiettivo in x
    g = [ 8*x(1)^3 + 4*x(1) + x(2) - 3
        12*x(2)^3 + 8*x(2) + x(1) - 2];

    % H è l'hesseiano della funzione obiettivo in x
    H = [ 24*x(1)^2+4   1
          1        36*x(2)^2+8];

end