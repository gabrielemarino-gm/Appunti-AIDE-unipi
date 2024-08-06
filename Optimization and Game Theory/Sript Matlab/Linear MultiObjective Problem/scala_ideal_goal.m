% SCALARIZATION METHOD FOR MULTI-OBJECTIVE LINEAR PROGRAMMING PROBLEM
clc, clear, close all;

% Define the problem { min Cx, s.t. Ax <= b
% A è la matrice dei coefficienti del dominio X
A = [1 1 1
    -1 0 0
     0 1 0];

% b è il vettore dei termini noti
b = [4; 0; 0];

% c è la matrice dei coefficienti delle funzioni obiettivo
c = [1 -1 -1
    1 -2 0];

% solve the scalarized problem with 0 < alfa1 < 1
MINIMA = [ ]; % First column: value of alfa1
LAMBDA = [ ]; % First column: value of alfa1
for alfa1 = 0.01 : 0.01 : 0.99
    [x, fval, exitflag, output, lambda] = linprog(alfa1*c(1,:)+(1-alfa1)*c(2,:),A,b);
    MINIMA = [MINIMA; alfa1, x'];
    LAMBDA = [LAMBDA; alfa1, lambda.ineqlin'];

    disp(['alfa1: ', num2str(alfa1)]);
    disp(lambda.ineqlin');
end

% solve the scalarized problem with alfa1 = 0 and alfa1 = 1
alfa1 = 0;
[xalfa0, f0, exitflag, output, lambda0] = linprog(alfa1*c(1,:)+(1-alfa1)*c(2,:),A,b);
disp(['alfa1: ', num2str(alfa1)]);
disp(lambda0.ineqlin');

alfa1 = 1;
[xalfa1, f1, exitflag, output, lambda1] = linprog(alfa1*c(1,:)+(1-alfa1)*c(2,:),A,b);
disp(['alfa1: ', num2str(alfa1)]);
disp(lambda1.ineqlin');

% find the ideal point z
z = zeros(2, 1);
x = zeros(2, 2);
for i = 1:2
    [x_optimal, z(i), exitflag, output] = linprog(c(i, :)', A, b, [], [], [], []);
    x(i, :) = x_optimal(1:2)';
    
    % Print information about the optimal solution
    fprintf('Optimal solution for objective %d:\n', i);
    fprintf('Optimal z: %f\n', z(i));
    fprintf('Optimal x: ');
    disp(x_optimal');
    fprintf('Exit flag: %d\n', exitflag);
    fprintf('Number of iterations: %d\n', output.iterations);
    fprintf('\n');
end
% solve the quadratic problem with norm q=2
x = quadprog(c'*c,-c'*z,A,b,[],[],[],[]); 
disp(x);