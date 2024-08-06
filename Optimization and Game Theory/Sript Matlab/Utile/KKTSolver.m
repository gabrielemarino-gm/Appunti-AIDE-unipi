close all; clear; clc;

syms a x1 x2 l1 ;

f = a*(6*x1 - x2) - 2*l1 - 2*a + 2 == 0,
    a + l1 - a*(x1 - 2*x2) - 1 == 0,
    -l1*(2*x1 - x2 + 2) == 0,
    x2 - 2*x1 - 2 <= 0,
    0 <= l1,
    0<=a<=1;

solve(f,[x1; x2])