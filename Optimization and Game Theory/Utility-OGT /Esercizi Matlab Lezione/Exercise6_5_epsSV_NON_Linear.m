%% Regression problems - Exercise 6.5 - 𝜺-SV Non Lineare Duale

close all; clear; clc;

%% data

data = [
   -3.0000    4.58
   -2.8000    7.19
   -2.6000    8.22
   -2.4000   16.06
   -2.2000   16.42
   -2.0000   17.53
   -1.8000   11.48
   -1.6000   14.10
   -1.4000   16.82
   -1.2000   16.15
   -1.0000   11.68
   -0.8000    6.00
   -0.6000    7.82
   -0.4000    2.82
   -0.2000    2.71
         0    1.16
    0.2000   -1.42
    0.4000   -3.84
    0.6000   -4.71
    0.8000   -8.15
    1.0000   -7.33
    1.2000  -13.64
    1.4000  -15.26
    1.6000  -14.87
    1.8000   -9.92
    2.0000  -10.50
    2.2000   -7.72
    2.4000  -11.78
    2.6000  -10.26
    2.8000   -7.13
    3.0000   -2.11];

x = data(:,1) ;
y = data(:,2) ;
l = length(x) ; % number of points

%% nonlinear regression - dual problem

epsilon = 3 ;
C = 5;

% define the problem
X = zeros(l,l);
for i = 1 : l
    for j = 1 : l
        X(i,j) = kernel(x(i),x(j)) ;
    end
end
Q = [ X -X ; -X X ];   
c = epsilon*ones(2*l,1) + [-y;y]; 

% solve the problem
sol = quadprog(Q, ...
               c,[],[],...
               [ones(1,l) -ones(1,l)], ...
               0,...
               zeros(2*l, 1), ...
               C*ones(2*l, 1));
lap = sol(1:l);
lam = sol(l+1:2*l);

% compute b
ind = find(lap > 1e-3 & lap < C-1e-3);
if isempty(ind)==0
    i = ind(1);
    b = y(i) - epsilon;
    for j = 1 : l
        b = b - (lap(j)-lam(j))*kernel(x(i),x(j));
    end
else
    ind = find(lam > 1e-3 & lam < C-1e-3);
    i = ind(1);
    b = y(i) + epsilon ;
    for j = 1 : l
        b = b - (lap(j)-lam(j))*kernel(x(i),x(j));
    end
end

% find regression and epsilon-tube
z = zeros(l,1);
for i = 1 : l
    z(i) = b ;
    for j = 1 : l
        z(i) = z(i) + (lap(j)-lam(j))*kernel(x(i),x(j));
    end
end
zp = z + epsilon ;
zm = z - epsilon ;

%% plot the solution

% find support vectors
sv = [find(lap > 1e-3);find(lam > 1e-3)]; 
sv = sort(sv);

plot(x,y,'b.',x(sv),y(sv),...
    'ro',x,z,'k-',x,zp,'r-',x,zm,'r-');

legend('Data','Support vectors',...
    'regression','\epsilon-tube',...
    'Location','NorthWest')

%% kernel function
% Indexes of support vectors, support vectors, lambda_-, lambda_+
[ sv,                         x(sv), y(sv),    lam(sv),  lap(sv)]

function v = kernel(x,y)
    p = 4;
    v = (x'*y + 1)^p;
end