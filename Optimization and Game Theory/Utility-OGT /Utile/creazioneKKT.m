close all; clear; clc;

% CREARE IL KKT dati f, g e h:

syms x1 x2 x3 x4 l1 l2 l3 l4 mu1 mu2 mu3 a
% MODIFICARE
    f = 2*x1^2 + 3*x2^2 + 4*x3^2 + 3*x4^2 + x1*x3 - x1*x4 + 2*x2*x3 + x2*x4 + x3*x4 - 6*x1 - 3*x2 - 8*x3;;
    var = [x1, x2, x3, x4];
    g = [];%[2*x1+x2+x3-20, -x1+2, x2-3, -x3+4];
    h = [];
    l = [l1, l2, l3, l4];
    m = [mu1, mu2, mu3];

ng = length(g);
nh = length(h);

% Calcolare il gradiente di f
grad_f = expand(gradient(f, var));
eq = grad_f;


for i = 1:ng
    grad_g = gradient(g(i), var);
    eq = eq + l(i)*grad_g;
end

for i = 1:nh
    grad_h = gradient(h(i), var);
    eq = eq + m(i)*grad_h;
end


disp("KKT Equations:");
disp(eq==0);

for i = 1:ng
    disp(l(i)*(g(i)) == 0);
end
for i = 1:nh
    disp(m(i)*h(i) == 0);
end
for i = 1:ng
    disp(g(i) <= 0);
end
for i = 1:nh
    disp(h(i) == 0)
end
for i = 1:ng
    disp(l(i) >= 0);
end
for i = 1:nh
    disp(m(i) >= 0);
end
