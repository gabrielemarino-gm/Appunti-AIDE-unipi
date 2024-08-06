%% Clustering Problem - K-Means
clear; close all; clc;

data = [
    1.2 6.2;
    2.7 7.4;
    1.1 7.6;
    4.8 7.3;
    2.7 6.3;
    4.8 8.0;
    4.0 6.7;
    3.7 5.1;
    3.5 7.8;
    3.2 5.7;
    1.8 6.5;
    2.4 6.2;
    2.6 7.2;
    6.0 8.0;
    5.2 7.5;
    7.7 7.0;
    7.2 6.3;
    8.0 4.0;
    6.0 5.0;
    5.5 2.5;
    ];

l = size(data,1); % number of patterns
k = 3;
%InitialCentroids = [1, 1; 2, 2; 3, 3]; 
%InitialCentroids = [1, 6; 2, 5; 3, 3]; 
InitialCentroids = [9, 8; 9, 1; 4, 4]; 
[x, cluster, v] = kmeans1(data,k,InitialCentroids)

% plot centroids
plot(x(1, 1), x(1, 2), 'b*', x(2, 1), x(2, 2), 'r*', x(3, 1), x(3, 2), 'g*');
hold on

% plot cluster
c1 = data(cluster==1, :);
c2 = data(cluster==2, :);
c3 = data(cluster==3, :);
plot(c1(:, 1), c1(:, 2), 'bo', c2(:, 1), c2(:, 2), 'ro', c3(:, 1), c3(:, 2), 'go');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x, cluster, v] = kmeans1(data, k, InitialCentroids)
    l = size(data,1); % number of patterns

    % INIZIALIZZAZIONE
    % Initialize centroids
    x = InitialCentroids;

    % Initialize clusters
    cluster = zeros(l, 1);
    for i = 1 : l % Per tutti i punti
        d = inf;
        for j = 1 : k % Per tutti i centroidi
            % Se la distanza tra il punto e il centroide è minore della distanza minima
            if norm(data(i,:)-x(j,:)) < d 
                % Calcolo la distanza tra il punto e il centroide
                d = norm(data(i,:)-x(j,:));

                % Assegno il punto al cluster del centroide più vicino
                cluster(i) = j; 
            end
        end
    end

    % Compute the objective function value
    vold = 0;
    for i = 1 : l % Per tutti i punti
        % Calcolo la distanza tra il punto e il centroide del cluster a cui appartiene
        vold = vold + norm(data(i,:)-x(cluster(i),:))^2 ;
    end

    % ITERAZIONI
    while true
        % Update centroids
        for j = 1 : k % Per tutti i centroidi
            ind = find(cluster == j);
            
            if isempty(ind) == 0
                x(j,:) = mean(data(ind,:),1);
            end
        end
        % Update clusters
        for i = 1 : l
            d = inf;
            for j = 1 : k
                if norm(data(i,:)-x(j,:)) < d
                    d = norm(data(i,:)-x(j,:));
                    cluster(i) = j;
                end
            end
        end
        % Update objective function
        v = 0;
        for i = 1 : l
            v = v + norm(data(i,:)-x(cluster(i),:))^2 ;
        end
        % Stopping criterion: 
        % Se la differenza tra il valore della funzione obiettivo di due iterazioni consecutive è minore di 1e-5
        if vold - v < 1e-5 
            break
        % Altrimenti aggiorno il valore della funzione obiettivo
        else
            vold = v;
        end 
    end
end
