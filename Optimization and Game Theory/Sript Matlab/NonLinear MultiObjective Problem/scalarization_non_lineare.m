% min (X_1 + 2X_2^2, X_1^2 + 4X_2^2)
% X_1^2 + 2X_2^2 -4 <= 0
%
% min alfa1(X_1 + 2X_2^2) + (1-alfa1)(X_1^2 + 4X_2^2) =
% = min X_1(alfa1 + X_1 - alfa1*X_1) + X_2(-2*alfa1*X_2 + 4X_2)

% solve the scalarized problem with 0 ≤ alfa1 ≤ 1

clc, clear, clear all;

MINIMA = [ ]; % First column: value of alfa1
for alfa1 = 0 : 0.1 : 1
    fun = @(x) (alfa1*(x(1)-2*x(2)) + (1-alfa1)*(-x(1)+3*x(2)));
    nonlcon = @(x) const(x);
    x0 = [0,0]';
    [x, fval, exitflag, output, lambda] = fmincon(fun, x0, [ ], [ ], [ ], [ ], [ ], [ ], nonlcon);
    MINIMA = [MINIMA; alfa1, x'];
end

% I LAMBDA nel caso non lineare non servono a niente
disp("alfa - soluzioni");
disp(MINIMA);

plot(MINIMA(:,2),MINIMA(:,3));

% Funzione Ausiliaria
function [C, Ceq] = const(x)
    C = [-x(1) + 2*x(2) + 1, 2*x(1) - 7*x(2) + 4, x(2) - 4]; % se più vincoli metterli in un vettore
    Ceq = [ ];
end