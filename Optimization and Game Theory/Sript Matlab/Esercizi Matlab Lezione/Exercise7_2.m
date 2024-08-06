
%% Clustering problem - Exercise 7.2 a) b)

clear; close all; clc;

data = [0.8 1
    .9 .5
    .1 .8
    .9 .1
    .6 .4
    .1 .9
    .3 .8
    .5 1
    1 .7
    1 0
    .2 .8
    1 .9];

l = size(data,1); % number of patterns
k = 4;
InitialCentroids = [.8, .5; .6, .4; .5, .7; 1, .8]; 
[x, cluster, v] = kmedian2(data,k,InitialCentroids)

% plot centroids
plot(x(1,1), x(1,2), 'b*', x(2,1), x(2,2), 'r*', x(3,1), x(3,2), 'g*', x(4,1), x(4,2), 'y*');
hold on

% plot cluster
c1 = data(cluster==1, :);
c2 = data(cluster==2, :);
c3 = data(cluster==3, :);
c4 = data(cluster==4, :);
plot(c1(:,1), c1(:,2), 'bo', c2(:,1), c2(:,2), 'ro', c3(:,1), c3(:,2), 'go', c4(:,1), c4(:,2), 'go');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x,cluster,v] = kmedian2(data,k,InitialCentroids)
    l = size(data,1); % number of patterns

    % INIZIALIZZAZIONE
    % Initialize centroids
    x = InitialCentroids;

    % Initialize clusters
    cluster = zeros(l,1);
    for i = 1 : l
        d = inf;
        for j = 1 : k
            if norm(data(i,:)-x(j,:),1) < d
                % Norma 1
                d = norm(data(i,:)-x(j,:),1);
                cluster(i) = j;
            end
        end
    end

    % compute the objective function value
    vold = 0;
    for i = 1 : l
        % Differente da k-means
        vold = vold + norm(data(i,:)-x(cluster(i),:),1) ;
    end

    % ITERAZIONI
    while true
        % update centroids
        for j = 1 : k
            ind = find(cluster == j);
            if isempty(ind)==0
                x(j,:) = median(data(ind,:),1);
            end
        end
        
        % update clusters
        for i = 1 : l
            d = inf;
            for j = 1 : k
                if norm(data(i,:)-x(j,:),1) < d
                    % Norma 1
                    d = norm(data(i,:)-x(j,:), 1);
                    cluster(i) = j;
                end
            end
        end

        % update objective function
        v = 0;
        for i = 1 : l
            % Differente da k-means
            v = v + norm(data(i,:)-x(cluster(i),:),1) ;
        end
        
        % stopping criterion
        if vold - v < 1e-5
            break
        else
            vold = v;
        end 
    end
end
