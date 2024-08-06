clc, clear, close all;

% The  Problem: min Cx, s.t. Ax <= b
C = [ 1 -1 -1; 1  -2 0] ;
A = [1 1 1; -1 0 0; 0 1 0];
b = [4, 0, 0]';

% % solve the scalarized problem with 0 =< alfa =< 1
MINIMA=[ ]; LAMBDA=[ ];  DEG=[ ];   % First column: value of alfa1

% Per tutti gli alfa, risolviamo il porblema
for alfa1 = 0 : 0.01 : 1
    [x, fval, exitflag, output, lambda] = linprog(alfa1*C(1,:)+(1-alfa1)*C(2,:), A, b);
    MINIMA = [MINIMA; alfa1, x'];
    LAMBDA = [LAMBDA; alfa1, lambda.ineqlin'];

    % find dual degenerate solutions
    S = find(lambda.ineqlin <0.01);
    if size(S,1)> 0.1
        DEG = [DEG; alfa1, x', lambda.ineqlin'];
    end
end