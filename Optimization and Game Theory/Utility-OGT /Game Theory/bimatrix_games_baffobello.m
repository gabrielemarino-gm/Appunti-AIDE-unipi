%ATTENZIONE: GLI INDICI PER LA PURE E IL BEST RESPONSE FANNO RIFERIMENTO
%            ALLA MATRICE RIDOTTA
%            GLI INDICI DEL KKT FANNO INVECE RIFERIMENTO ALLA MATRICE
%            ORIGINALE

function bimatrix_games()

    clc, clear all;

    % Matrici di gioco
    C1 = [2 0 2; 
          1 3 -1];
    C2 = [3 1 2; 
          2 4 1];
    
    stable = false;
    
    salva1 = C1;
    salva2 = C2;

    % Eliminazione delle strategie dominate
    while ~stable
        [C1_new, C2_new] = strictly_dominated_strategies(C1, C2);
        stable = isequal(C1, C1_new) && isequal(C2, C2_new);

        C1 = C1_new;
        C2 = C2_new;
    end

    C1 = salva1;
    C2 = salva2;
    
    disp('Matrice C1 dopo l''eliminazione:');
    disp(C1_new);
    
    disp('Matrice C2 dopo l''eliminazione:');
    disp(C2_new);
    
    pureNashEquilibria(C1_new, C2_new);

    disp("Mixed for C1:")
    mixedNashEquilibria(C1_new, 0);

    disp("Mixed for C2:")
    mixedNashEquilibria(C2_new, 1);

    disp("Mixed with KKT:")
    mixedKKT(C1, C2);

end

% Funzione per eliminare le strategie dominate
function [C1_new, C2_new] = strictly_dominated_strategies(C1, C2)
    % Inizializza le matrici C1_new e C2_new con le stesse dimensioni di C1 e C2
    C1_new = C1;
    C2_new = C2;

    % Elimina le righe in base alla condizione specificata
    for i = 1:size(C1, 1)
        % Se esiste una riga C1(i, :) tale che tutti gli elementi di C1 sono minori
        if any(all(C1 < C1(i, :), 2)) 
            % Elimina la riga i-esima
            C1_new(i, :) = [];
            C2_new(i, :) = [];
            % Dopo l'eliminazione di una riga, ricomincia il loop
            % dalla prima riga
            break;
        end
    end

    % Elimina le colonne in base alla condizione specificata
    for i = 1:size(C2, 2)
        % Se esiste una colonna C2(:, i) tale che tutti gli elementi di C2 sono maggiori
        if any(all(C2 < C2(:, i), 1))
            C1_new(:, i) = [];
            C2_new(:, i) = [];
            % Dopo l'eliminazione di una colonna, ricomincia il loop
            % dalla prima colonna
            break;
        end
    end
end

% Funzione per trovare le strategie di Nash pure
function pureNashEquilibria(matrice1, matrice2)
    % Ricerca delle strategie di Nash per il player 1
    [num_righe_1, num_colonne_1] = size(matrice1);
    result_matrix_1 = [];
    
    % Per ogni riga della matrice 1
    for i = 1:num_righe_1
        % Estrai la riga i-esima, e trova il minimo
        riga = matrice1(i, :);
        minimo = min(riga);
        indici_minimi = find(riga == minimo);
        
        % Per ogni minimo trovato, aggiungi la coppia di indici alla matrice risultato
        for j = 1:length(indici_minimi)
            result_matrix_1 = [result_matrix_1; i, indici_minimi(j)];
        end
    end

    %disp('Migliore Strategia Player 1');
    %disp(result_matrix_1);

    % Ricerca delle strategie di Nash per il player 2    
    [num_righe_2, num_colonne_2] = size(matrice2);
    result_matrix_2 = [];
    
    for j = 1:num_colonne_2
        colonna = matrice2(:, j);
        minimo = min(colonna);
        indici_minimi = find(colonna == minimo);
        
        for i = 1:length(indici_minimi)
            result_matrix_2 = [result_matrix_2; indici_minimi(i), j];
        end
    end

    %disp('Migliore Strategia Player 2');
    %disp(result_matrix_2);

    % Confronto delle strategie di Nash
    intersezione = intersect(result_matrix_1, result_matrix_2, 'rows');
    
    if ~isempty(intersezione)
        disp('Strategie pure di Nash:');
        disp(intersezione);
    else
        disp('Non ci sono strategie pure di Nash');
        disp(' ');
    end
end

function mixedNashEquilibria(matrice, var)
    syms x y; % Define x and y as symbolic variables

    mat_x = [x, 1 - x];
    mat_y = [y; 1 - y];

    risultato = mat_x * matrice * mat_y;
    disp(risultato)

    expr = simplify(expand(risultato));
    disp(expr)

    if var == 0
        collectedExpr = collect(expr, x);
        disp(collectedExpr)
    else
        collectedExpr = collect(expr, y);
        disp(collectedExpr)
    end
    
    analyzeExpression(expr, var)
end

function analyzeExpression(expr, var)
    syms x y;

    % Analyze based on variable
    if var == 0  % Analyze for x
        coeff = coeffs(expr, x);  % Get coefficient of x
        analyzeAndDisplay(coeff, 'x');  % Analyze and display solutions
    else  % Analyze for y
        coeff = coeffs(expr, y);  % Get coefficient of y
        analyzeAndDisplay(coeff, 'y');  % Analyze and display solutions
    end
end

function analyzeAndDisplay(coeff, var)
    term = sym(coeff(2));  % Convert to symbolic expression

    % Display based on the sign of the coefficient
    disp([char(term) ' > 0    ' var ' = 0']);
    disp([char(term) ' = 0    ' var ' E (0, 1)']);
    disp([char(term) ' < 0    ' var ' = 1']);

    disp(' ')
end

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


