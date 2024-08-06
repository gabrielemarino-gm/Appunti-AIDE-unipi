%% Constrained optimization -- Barrier Method
clear; close all; clc;

%% data 
global Q c A b eps;
Q = [ 2 -1 0 ;-1 2 1; 0 1 2 ] ;
c = [ -3 ; -4; -5 ] ;
A = [2 1 1;-1 0 0; 0 1 0 ;0 0 -1 ]; b=[20;-2;3;-4 ];


delta = 1e-3 ;
tau = 0.5 ;
eps1 = 1 ;
x0 = [ 3; 2; 5];

%% Method
x = x0;
eps = eps1 ;
m = size(A,1) ;
SOL = [];

while true
    [x, pval] = fminunc(@logbar,x);
    gap = m*eps;
    SOL = [SOL;eps,x',gap,pval];
    if gap < delta
        break
    else
        eps = eps*tau;
    end
end
fprintf('\t eps \t x(1) \t x(2) \t gap \t  pval \n\n');
disp("SOL = [eps, x', gap, pval]");
disp(SOL);

%% logarithmic barrier function
function v = logbar(x)
    global Q c A b eps
    v = 0.5*x'*Q*x + c'*x ;
    for i = 1 : length(b)
        v = v - eps*log(b(i)-A(i,:)*x) ;
    end
end