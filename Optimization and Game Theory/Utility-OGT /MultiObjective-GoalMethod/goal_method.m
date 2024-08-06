% Goal Method
clear all;

%% Data
C = [ 1  2 -3 ;
     -1 -1 -1 ;
     -4 -2  1 ];

% A
A = [ 1  1  1 ;
      0  0  1 ;
      -eye(3) ]; % -eye(3) = -I

b = [10; 5; 0; 0; 0];

%% Risoluzione applicando il Goal Method
% Calcolo del punto ideale z
p = size(C, 1);
n = size(C, 2);
m = size(A, 1);
options = optimset('Display', 'off');

z = zeros(p, 1);
for i = 1:p
    [~, z(i)] = linprog(C(i,:)', A, b, [], [], [], [], options);    
end
z;

%% Goal Method
% Norma 1
gm1 = linprog([zeros(n, 1); ones(p, 1)], [C -eye(p); -C -eye], [],[], [],[], [], options);
gm1 = gm1(1:n);

% Norma 2
gm2 = quadprog(C'*C, -C'*z, A, b, [], [], [], [], [], options);

% Norma Infinito
[gmInf, vinf] = linprog([zeros(n, 1); 1], [C -ones(p, 1);], [],[], [], [], [], options);
gmInf = gmInf(1:n);

% controllo se gmInf è un punto ottimo
c = [zeros(n, 1); -ones(p, 1)];
P = [C -eye(p); 
     A zeros(m, p);
     zeros(n,n) -eye(p)];
q = [C*gmInf; b; zeros(p, 1)];
[~, v_min] = linprog(c, P, q, [], [], [], [], [], options);
