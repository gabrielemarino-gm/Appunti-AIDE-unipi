clc, clear all

C = [
        2 4  1 3 -2;
        2 1  3 2  5;
        3 3 -2 3  1;
        3 5  5 4  3;
    ];

m = size(C,1);
n = size(C,2);
c = [zeros(m,1);1];
A = [C', -ones(n,1)]; 
b = zeros(n,1); 
Aeq = [ones(1,m),0]; 
beq = 1;
lb = [zeros(m,1);-inf];  
ub =[ ];

[sol, Val, exitflag, output, lambda] = linprog(c, A,b, Aeq, beq, lb, ub);
x = sol(1:m)
y = lambda.ineqlin