%ATTENZIONE: GLI INDICI PER LA PURE FANNO ALLA MATRICE RIDOTTA        
%            GLI INDICI DEL MIXED FANNO INVECE RIFERIMENTO ALLA MATRICE
%            ORIGINALE

function matrix_games()

    clc, clear all
    
    C = [
    2 4  1 3 -2
    2 1  3 2  5
    3 3 -2 3  1
    3 5  5 4  3
    ];

    salva = C;
    stable = false;

    %Riduzione della Matrice
    while ~stable
        nuovaMatrice = strictly_dominated_strategies(C);
        stable = isequal(C, nuovaMatrice);

        C = nuovaMatrice;
    end

    C = salva;

    disp("Matrice Ridotta:");
    disp(nuovaMatrice)
    disp(" ")

    % Trova la posizione del valore minimo per ogni riga
    [num_righe_1, num_colonne_1] = size(nuovaMatrice);
    result_matrix_1 = [];
    
    for i = 1:num_righe_1
        riga = nuovaMatrice(i, :);
        minimo = min(riga);
        indici_minimi = find(riga == minimo);
        
        for j = 1:length(indici_minimi)
            result_matrix_1 = [result_matrix_1; i, indici_minimi(j)];
        end
    end

    disp('Migliore Strategia Player Righe');
    disp(result_matrix_1);

    % Trova la posizione del valore massimo per ogni colonna
    [num_righe_2, num_colonne_2] = size(nuovaMatrice);
    result_matrix_2 = [];
    
    for j = 1:num_colonne_2
        colonna = nuovaMatrice(:, j);
        massimo = max(colonna);
        indici_massimi = find(colonna == massimo);
        
        for i = 1:length(indici_massimi)
            result_matrix_2 = [result_matrix_2; indici_massimi(i), j];
        end
    end

    disp('Migliore Strategia Player Colonne');
    disp(result_matrix_2);

    % Confronto delle strategie di Nash
    intersezione = intersect(result_matrix_1, result_matrix_2, 'rows');
    
    if ~isempty(intersezione)
        disp('Strategie pure di Nash:');
        disp(intersezione);
    else
        disp('Non ci sono strategie pure di Nash');
        disp(' ');
    end

    disp("MIXED NASH EQUILIBRIUM")
    disp(" ")
    
    % Calculate m and n, the number of rows and columns of matrix C
    m = size(C, 1);
    n = size(C, 2);
    
    % Display the objective
    disp('min v')
    
    % Define the variable order (change the order as needed)
    variable_order = 1:m;
    
    % Dynamically create and display each inequality with the specified order
    for i = 1:n
        inequality = '';
        for j = variable_order
            % Append each term in the inequality to the string
            term = sprintf('%dx%d + ', C(j, i), j);
            inequality = [inequality term];
        end
        % Remove trailing plus and space, then add <= v
        inequality = [inequality(1:end-2) ' <= v'];
        disp(inequality)
    end
    
    % Display the equality constraint
    equality = '';
    for j = variable_order
        term = sprintf('x%d + ', j);
        equality = [equality term];
    end
    % Remove the trailing plus and space, then append '= 1'
    disp([equality(1:end-2) ' = 1'])
    
    % Display the non-negativity constraints
    nonnegativity = '';
    for j = variable_order
        nonnegativity = [nonnegativity sprintf('x%d, ', j)];
    end
    % Remove the trailing comma and space, then append '>= 0'
    disp([nonnegativity(1:end-2) ' >= 0'])
    
    % Definisci c
    c = [zeros(m,1);1];
    
    % Definisci A
    A = [C', -ones(n,1)];
    b = zeros(n,1);
    A = [A; 1 0 0 0];
    A = [A; 0 1 0 0];
    A = [A; 0 0 1 0];
    b = [b; 0.9999];
    b = [b; 0.9999];
    b = [b; 0.9999];
    
    % Definisci Aeq
    Aeq = [ones(1,m),0];
    beq = 1;
    
    % Definisci Ib
    Ib = [zeros(m,1);-inf];
    ub = [];
    
    % Calcola la soluzione
    [sol, Val,exitflag, output, lambda] = linprog(c, A,b, Aeq, beq, Ib, ub);
    
    % Estrai x
    x = sol(1:m);
    disp('x:')
    disp(x)
    
    % Estrai y
    y = lambda.ineqlin;
    disp('y:')
    disp(y)

    disp("SCRIPT MODIFICATO PER FUNZIONARE QUANDO CI SONO ANCHE EQUILIBRI PURI")
    disp("script modificato per runnare su matrici 3x4; modificare il definisci A")
    disp("vanno boundate le x a essere <=0.99999 in modo da non finire in equilibri puri")
    disp("ignorare le y extra appese in fondo al vettore y")
end

function [C_new] = strictly_dominated_strategies(C)
    % Inizializza le matrici P1_new e P2_new con le stesse dimensioni di P1 e P2
    C_new = C;

    % Elimina le righe in base alla condizione specificata
    for i = 1:size(C, 1)
        if any(all(C < C(i, :), 2))
            C_new(i, :) = [];
            % Dopo l'eliminazione di una riga, ricomincia il loop
            % dalla prima riga
            break;
        end
    end

    % Elimina le colonne in base alla condizione specificata
    for i = 1:size(C, 2)
        if any(all(C > C(:, i), 1))
            C_new(:, i) = [];
            % Dopo l'eliminazione di una colonna, ricomincia il loop
            % dalla prima colonna
            break;
        end
    end
end