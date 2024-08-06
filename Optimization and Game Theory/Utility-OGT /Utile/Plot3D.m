clc, clear, clear all;

[X, Y] = meshgrid(0:0.1:100);
Z = X.^2 + Y.^2 - 2*X.*Y + 1. ./ (X+1);
surf(X, Y, Z);
