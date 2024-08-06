%% Support Vector Machine with soft margin
clear; close all; clc;

A=[ 6.55 0.85
    6.55 1.71
    7.06 0.31
    2.76 0.46
    0.97 8.23
    9.50 0.34
    4.38 3.81
    1.86 4.89
    2.76 6.79
    6.55 1.22];

B=[ 9.59 3.40
    5.85 2.23
    7.51 2.55 
    5.05 7.00
    8.90 9.59
    8.40 2.54
    8.14 2.43
    9.30 3.45
    6.16 4.73
    3.51 8.30];

C = 10; 
 
nA = size(A,1); 
nB = size(B,1);

T = [A;B];
y = [ones(nA,1) ; -ones(nB,1)]; l = length(y);
Q = zeros(l,l);

for i = 1 : l
    for j = 1 : l
        % training points
        % labels
        Q(i,j) = y(i)*y(j)*(T(i,:))*T(j,:)';  % (minus) Dual Hessian
    end
end

% Solve the problem
la = quadprog(Q, -ones(l,1), [ ], [ ], y', 0, zeros(l,1), C*ones(l,1));
% compute vector w
w = zeros(2, 1); 

for i = 1 : l
    w = w + la(i)*y(i)*T(i,:)';
end

% compute scalar b
indpos = find(la > 0.001) ;      
ind = find(la(indpos) < C - 10^(-3));
i = indpos(ind(1)) ;
b = 1/y(i) - w'*T(i,:)';

disp("w = ");
disp(w);

disp("b = ");
disp(b);


%% plot the solution 
xx = 0:0.1:10;
uuD = (-w(1)/w(2)).*xx - b/w(2);
vvD = (-w(1)/w(2)).*xx + (1-b)/w(2);
vvvD = (-w(1)/w(2)).*xx + (-1-b)/w(2);

plot(A(:,1),A(:,2),'bo',B(:,1),B(:,2),'r*',...
     xx,uuD,'k-',xx,vvD,'b-',xx,vvvD,'r-','Linewidth',1)
axis([0 10 0 10])
title('Optimal separating hyperplane with soft margin')

% Compute the support vectors
supp = find(la > 10^(-3));
suppA = supp(supp <= nA);
suppB = supp(supp > nA);

% Compute the errors err
for i = 1 : nA+nB
    if la(i) > 0.001
        % ERRORE 
        err(i) = 1 - y(i) * (T(i,:)*w +b);
    else err(i) = 0;
    end
end