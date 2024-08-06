close all; clear; clc;

syms x p
% Definisci la tua disequazione
a = -7; % Coefficiente del termine x^2
b = 16; % Coefficiente del termine x
c = -8; % Coefficiente del termine costante
diseq = "maggiore";

% Converti la disequazione in un'equazione
eq = a*x^2  + b*x + c  == 0;

% Risolvi l'equazione
sol = roots([a b c]);
x1 = sol(1);
x2 = sol(2);
x1, x2

% Calcolo del delta
delta = b^2 - 4*a*c;

if strcmp(diseq, "maggiore")
    if a > 0     
        if delta > 0
            disp("La disequazione è soddisfatta se x < " + x1 + ", x > " + x2);
        elseif delta == 0
            disp("La disequazione è soddisfatta se x != " + x1);
        else
            disp("La disequazione è soddisfatta per ogni x");
        end
    elseif a < 0
        if delta > 0
            disp("La disequazione è soddisfatta se " + x1 + " < x < " + x2);
        elseif delta <= 0
            disp("La disequazione IMPOSSIBILE");
        end
    end
end

if strcmp(diseq, "minore")
    if a > 0     
        if delta > 0
            disp("La disequazione è soddisfatta se " + x1 + " < x < " + x2);
        elseif delta == 0
            disp("La disequazione è soddisfatta se x = " + x1);
        else
            disp("La disequazione è soddisfatta per ogni x");
        end
    elseif a < 0
        if delta > 0
            disp("La disequazione è soddisfatta se x < " + x1 + ", x > " + x2);
        elseif delta <= 0
            disp("La disequazione IMPOSSIBILE");
        end
    end
end

if strcmp(diseq, "maggiore_uguale")
    if a > 0     
        if delta > 0
            disp("La disequazione è soddisfatta se x <= " + x1 + ", x >= " + x2);
        elseif delta == 0
            disp("La disequazione è soddisfatta se x = " + x1);
        else
            disp("La disequazione è soddisfatta per ogni x");
        end
    elseif a < 0
        if delta > 0
            disp("La disequazione è soddisfatta se x >= " + x1 + ", x <= " + x2);
        elseif delta <= 0
            disp("La disequazione IMPOSSIBILE");
        end
    end
end

if strcmp(diseq, "minore_uguale")
    if a > 0     
        if delta > 0
            disp("La disequazione è soddisfatta se x >= " + x1 + ", x <= " + x2);
        elseif delta == 0
            disp("La disequazione è soddisfatta se x = " + x1);
        else
            disp("La disequazione è soddisfatta per ogni x");
        end
    elseif a < 0
        if delta > 0
            disp("La disequazione è soddisfatta se x <= " + x1 + ", x >= " + x2);
        elseif delta <= 0
            disp("La disequazione IMPOSSIBILE");
        end
    end
end