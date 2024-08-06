%% Exercise 3 - Multiobjective optimization
clear all; close all; clc;

% Hessiane delle varie objectives
Q1 = [0 1; 1 0];
Q2 = [2 0; 0 4];

% Coefficienti variabili lineari
c1 = [0 0]';
c2 = [0 -2]';

% Ax <= b
A = [0 0];
b = 0;

%% Solve the scalarized problem with  alfa1 in [0,1] 
MINIMA = [ ]; % First column: value of alfa1 
LAMBDA = [ ]; 

for alfa1 = 0.01 : 0.001 : 1
    [x, fval, exitflag, output, lambda] = quadprog( alfa1*Q1+(1-alfa1)*Q2, ...
                                                    alfa1*c1+(1-alfa1)*c2, ...
                                                    A, ...
                                                    b); 
    MINIMA = [MINIMA; alfa1 x'];
    LAMBDA = [LAMBDA; alfa1, lambda.ineqlin'];
end

%% Plot
plot(MINIMA(:,2),MINIMA(:,3), 'r*')