clc, clear, clear all;

Q1 = [0 1; 1 0];
Q2 = [2 0; 0 4] ;
c1 = [0 0]';
c2 = [0 -2]';

MINIMA=[ ]; 
SOL=[ ];
eigQ = [];

for alfa1 = 0 : 0.001 : 1
    eigQalfa1 = eig(alfa1*Q1+(1-alfa1)*Q2);
    eigQ = [eigQ; alfa1, eigQalfa1']; % Eigenvalues of the hessian of \psi_alfa1(x)
    
    fun = @(x) 0.5*x'*(alfa1*Q1+(1-alfa1)*Q2)*x +(alfa1*c1+(1-alfa1)*c2)'*x;
    x0 = [0,0]';

    if (eigQ > 0.0001) % 0.001 è un valore molto piccolo, quindi se un autovalore è minore di 0.001, allora è negativo.
        % Se gli autovalori sono tutti positivi, allora il punto è un minimo, 
        % perchè la funzione è convessa.
        [x, fval, exitflag, exitflag] = fminunc(fun, x0)

        % Se la funzione è convessa, allora il punto trovato è un minimo.
        MINIMA = [MINIMA; alfa1 x'];
    else
        % Qui la funzione non è convessa, quindi il punto trovato non è un minimo.
        [x, fval, exitflag, exitflag] = fminunc(fun, x0)
        SOL = [SOL; alfa1 x'];
    end
end

%plot(MINIMA(:,2), MINIMA(:,3), 'r*');