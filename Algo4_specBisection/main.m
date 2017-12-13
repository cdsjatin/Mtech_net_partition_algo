%% Spectral bisection
%{ 
    STEPS
1. Compute the fiedler eigenvector v
2. Search the median of v(use median function)
3. for each node i of G
    set two partition v(i) =< median - $V_1$
    else put node i in partition $V_2$
4. if |V_1| - |V_2| > 1 move from V_1 to V_2 (randomly)
5. Let V_1' be the set of vertices in V_1 adjacent ot some vertex in V_2
let V_2' be the set of vertices in V_2 adjacent to some vertex in V_1
set up the edge separator E' - the set of edges of G with one point in V_1'
and the second in V_2'
=> Just the Edge list for cutset._
6. let E_1 be the set of edges with both end vertices in V_1
and E_2 be the set of vertices with both end vertices in V_2
set up the graph G_1 = (V_1,E_1), G_2 = (V_2,E_2)

end
%}

clc ;
close all;

clear all; 

fid = fopen('./data/edgeG.csv');
C = textscan(fid,'%d%c%d%c%d','Headerlines',1);
s = C{1};
t = C{3};
w = double(C{5});
clear C;
fclose(fid);

num_nodes = 25

% 1
adj  = create_adj(s,t,w,num_nodes);
L = create_lap(adj);
[V,~] = eig(L);
v = V(:,2);

fid = fopen('data/vertex.csv','wt');
fprintf(fid,'Vertex\tGrp\n');

grp = zeros(size(v,1));
id = (0:size(v,1)-1)';

grp = v > median(v);


A = [id';grp'];
fprintf(fid,'%5g\t%5g\n', A);

bi2de(grp')

fclose(fid);