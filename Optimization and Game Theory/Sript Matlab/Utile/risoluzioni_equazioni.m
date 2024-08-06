close all; clear; clc;

syms x1 x2 x3 l1 l2 l3 alpha1
eq = 2*alpha1*x1 - 1 + alpha1 - l1 == 0;
x_1 = solve(eq, x1);
x_1

% Per mettere in evidenza una variabile usare: 
% collect(expr, var)

% Per espandere una funzione usare:
% expand(expr)

% Per risolvere un sistema di equazioni usare:
% solve(eq1, eq2, ...)

% Per sostituire una variabile con un valore usare:
% subs(expr, var, value)

% Arrotondare
% r = round(LAMBDA, 3)

% ax^2 + bx + c == a (x-x1) (x-x2)