clc, clear, clear all;

% Date due matrici calcolare il KKT per trovare i punti di equilibrio misti
syms x1 x2 x3 x4 y1 y2 y3 y4

% MODIFICARE
    C1 = [2 0 2; 
          1 3 -1];
    C2 = [3 1 2; 
          2 4 1];
    
    C1r = [0 2; 3 -1];
    C2r = [1 2; 4 1];
    
    % MODIFICARE I VETTORI x E y CON LE INCOGNITE CORRETTE
    x = [x1 x2]; 
    y = [y2; y3];

%% PLAYER 1
f1 = x*C1r*y;

disp("Funzione Obiettivo Player 1:");
disp(f1);

% Sostituire il valore di x(2) con 1 - x(1), e y(2) con 1 - y(1)
disp("Sostituire il valore di " + char(x(2)) + " = 1 - " + char(x(1)));
f1 = subs(f1, x(2), 1 - x(1));
disp(f1)

disp("Sostituire il valore di " + char(y(2)) +" = 1 - " + char(y(1)));
f1 = subs(f1, y(2), 1 - y(1));
disp(f1);

disp("Espandere la funzione obiettivo");
f1 = expand(f1);
disp(f1);

% mettere in evidenza la funzione obiettivo x(1)
disp("Mettere in evidenza la funzione obiettivo " +  char(x(1)));
f1 = collect(f1, x(1));
disp(f1);

% Risolvere il sistema di equazioni per la variabile 0 <= x(1) <= 1, e y(1) parametro libero
% per trovare i punti di equilibrio misti
eq1 = diff(f1, x(1)) == 0;
sol1 = solve(eq1, y(1));
sol1_str = char(sol1); % Converti sol1 in una stringa

% Sostituisco a f1: y(1) = 0, e poi controllo la derivata se è positiva o
% negativa, dato che si tratta di una retta (Il suo coefficente angolare)
disp("ATTENZIONE: La seguente soluzione potrebbe essere errata, controllare facendo i conti a mano");
disp("BEST RESPONSE MAPPING:");
if (diff(subs(f1, y(1), 0), x(1)) >= 0) % Se la retta ha pendenza positiva
    disp("{ B1(" + char(y(1)) + ") = 0,          per " + char(y(1)) + " = [0, " + sol1_str + ")"); 
    x_0 = 0;
else
    disp("{ B1(" + char(y(1)) + ") = 1,          per " + char(y(1)) + " = [0, " + sol1_str + ")");
    x_0 = 1;
end

disp("{ B1(" + char(y(1)) + ") = [0, 1],         per " + char(y(1)) + " = " + sol1_str);
y_sol = sol1;

% Sostituisco a f1: y(1) = 1
if (diff(subs(f1, y(1), 1), x(1)) >= 0) % Se la retta ha pendenza positiva
    disp("{ B1(" + char(y(1)) + ") = 0,          per " + char(y(1)) + " = (" + sol1_str + ", 1]");
    x_1 = 0;
else
    disp("{ B1(" + char(y(1)) + ") = 1,          per " + char(y(1)) + " = (" + sol1_str + ", 1]");
    x_1 = 1;
end

%% PLAYER 2
f2 = x*C2r*y;

disp(" ");
disp(" ");
disp("Funzione Obiettivo Player 2:");
disp(f2);

% Sostituire il valore di x(1) con 1 - x(2), e y(1) con 1 - y(2)
disp("Sostituire il valore di " + char(x(2)) + " = 1 - " + char(x(1)));
f2 = subs(f2, x(2), 1 - x(1));
disp(f2);

disp("Sostituire il valore di " + char(y(2)) +" = 1 - " + char(y(1)));
f2 = subs(f2, y(2), 1 - y(1));
disp(f2);

disp("Espandere la funzione obiettivo");
f2 = expand(f2);
disp(f2);

% mettere in evidenza la funzione obiettivo x(1)
disp("Mettere in evidenza la funzione obiettivo y(1)");
f2 = collect(f2, y(1));
disp(f2);

% Risolvere il sistema di equazioni per la variabile 0 <= x(1) <= 1, e y(1) parametro libero
% per trovare i punti di equilibrio misti
eq2 = diff(f2, y(1)) == 0;
sol2 = solve(eq2, x(1));
sol2_str = char(sol2); % Converti sol2 in una stringa

disp("ATTENZIONE: La seguente soluzione potrebbe essere errata, controllare facendo i conti a mano");
disp("BEST RESPONSE MAPPING:");
if (diff(subs(f2, x(1), 0), y(1)) >= 0) % Se la retta ha pendenza positiva
    disp("{ B2(" + char(x(1)) + ") = 0,          per " + char(x(1)) + " = [0, " + sol2_str + ")");
    y_0 = 0;
else
    disp("{ B2(" + char(x(1)) + ") = 1,          per " + char(x(1)) + " = [0, " + sol2_str + ")");
    y_0 = 1;
end

disp("{ B2(" + char(x(1)) + ") = [0, 1],         per " + char(x(1)) + " = " + sol2_str);
x_sol = sol2;

if (diff(subs(f2, x(1), 1), y(1)) >= 0) % Se la retta ha pendenza positiva
    disp("{ B2(" + char(x(1)) + ") = 0,          per " + char(x(1)) + " = (" + sol2_str +  ", 1]");
    y_1 = 0;
else
    disp("{ B2(" + char(x(1)) + ") = 1,          per " + char(x(1)) + " = (" + sol2_str +  ", 1]");
    y_1 = 1;
end


% Risolti i sistemi di equazioni, si ottengono i punti di equilibrio misti per i due giocatori. 
disp("ATTENZIONE: La seguente soluzione potrebbe essere errata, controllare facendo i conti a mano");
disp(" ");
disp("Le coppie di punti (" + char(x(1)) + ", " + char(y(1)) + ") tale per cui " + char(x(1)) + " € B1(" + char(y(1)) + ") e " + char(y(1)) + " € B2(" + char(x(1)) + ") sono:");
disp(char(x(1)) + " = " + x_0 + ", " + char(y(1)) + " = " + y_0 );
disp(char(x(1)) + " = " + char(x_sol) + ", " + char(y(1)) + " = " + char(y_sol));
disp(char(x(1)) + " = " + x_1 + ", " + char(y(1)) + " = " + y_1);

disp(" ");
disp(" ");
disp(" ");
disp(" ");
disp(" ");
mixedKKT(C1, C2);


function mixedKKT(C1, C2)
    [m, n] = size(C1);
    
    H = [zeros(m, m), C1 + C2, ones(m, 1), zeros(m, 1); 
         (C1 + C2)', zeros(n, n), zeros(n, 1), ones(n, 1); 
         ones(1, m), zeros(1, n + 2); 
         zeros(1, m), ones(1, n), 0, 0];
     
    Ain = [-C2', zeros(n, n), zeros(n, 1), -ones(n, 1); 
           zeros(m, m), -C1, -ones(m, 1), zeros(m, 1)]; 
    bin = zeros(n + m, 1);
    
    Aeq = [ones(1, m), zeros(1, n + 2); 
           zeros(1, m), ones(1, n), 0, 0];

    numColonne = size(Aeq, 2);

    if mod(numColonne, 2) == 0
        primoValore = numColonne / 2;
        secondoValore = numColonne / 2;
    else
        primoValore = floor(numColonne / 2);
        secondoValore = ceil(numColonne / 2);
    end

    X0 = [rand(primoValore, 1); 10 - 20 * rand(secondoValore, 1)];
       
    beq = [1; 1];
    LB = [zeros(m + n, 1); -Inf; -Inf];
    UB = [ones(m + n, 1); Inf; Inf];
    
    [sol, fval, exitflag, output] = fmincon(@(X) 0.5 * X' * H * X, X0, Ain, bin, Aeq, beq, LB, UB);
    
    x = sol(1:m);
    disp("x:")
    disp(x)
    y = sol(m + 1:m + n);
    disp("y:")
    disp(y)
end
