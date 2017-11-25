%% Algo 2
clc;
clear all; 
close all;

fid = fopen('./data/edge4.csv');

if(fid ~= -1)

C = textscan(fid,'%d%c%d%c%d','Headerlines',1);

s = C{1};
t = C{3};
w = C{5};

clear C fid;
% assuming each node has an edge

max_node = 5;

%G = graph(s,t,weights);

lap = create_lap(create_adj(s,t,w,5));

[V,e] = eig(lap);

e = diag(e);

%deciding cut set with max eig val
for k = 0:max_node-2
    
    e(max_node-k)
sprintf('eig val: %3.2f',e(max_node-k));

v = V(:,max_node-k) ;

cutset = zeros(max_node,1);

cutset(v >= 0) = 1;

[sc,tc,wc] = cut_edges(s,t,w,cutset);

lapc = create_lap(create_adj(sc,tc,wc,max_node));

[Vc,ec] = eig(lapc);

eig(lapc);

eiglandc = eig(lap)-eig(lapc)

[sp,tp,wp] = part_edges(s,t,w,cutset);

lapp = create_lap(create_adj(sp,tp,wp,max_node));

eig(lapp)

end
else display('Cannot open Database');

end


