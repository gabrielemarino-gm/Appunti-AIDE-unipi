clear; close all; 

% Definizione del problema di ottimizzazione
Q = [6 0 -4 0; 0 6 0 -4; -4 0  6 0; 0 -4 0 6]
c = [ 1 -1 2 -3]';

disp('eigenvalues of  Q:')
eig(Q)

% Parameters
x0 = [0 0 0 0]';
tolerance = 10^(-6);

% Gradient method with exact line search

% starting point
x = x0 ;
% X serve per salvare la storia delle iterazioni, lo inizializzo con una riga a inifinito
X = [Inf, Inf, Inf, Inf, Inf, Inf, Inf];
% iterazioni da 1 a 1000
for ITER = 1:1000
    % v = valore della funzione obiettivo in x
    v = 0.5*x'*Q*x + c'*x;
    % g = gradiente della funzione obiettivo in x
    g = Q*x + c ;

    % Salvo la storia delle iterazioni, aggiungendo una riga a X contenente
    % il numero di iterazione, il punto x, il valore della funzione obiettivo, il gradiente
    X = [X;ITER,x',v,norm(g)];

    % stopping criterion
    if norm(g) < tolerance
        break;
    end
    
    % search direction
    d = -g;
    
    % exact line search
    t = norm(g)^2/(d'*Q*d);
        
    % new point
    x = x + t*d;
end

disp('optimal solution');
x;
disp('optimal value');
v;
disp('gradient norm at the solution');
norm(g);