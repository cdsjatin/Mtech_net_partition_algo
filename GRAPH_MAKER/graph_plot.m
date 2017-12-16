%% graph_main 
% Takes values for i and plot on the basis of those i

function graph_plot(i)

if ~exist('i','var')
    i = 0;
end

num_nodes = 25;
fid = fopen('../data/edgeG.csv');

C = textscan(fid,'%d%c%d%c%d','Headerlines',1);

s = C{1};
t = C{3};
w = C{5};
clear C;

c = de2bi(i,num_nodes)';
%list = 0:num_nodes;
%[s,t,w] = part_edges(s,t,w,c);

[s0,t0,w0,~]   = part_edgesG(s,t,w,c,0);
[s1,t1,w1,~]   = part_edgesG(s,t,w,c,1);

adj0     = create_adj(s0,t0,w0,sum(c==0));
adj1     = create_adj(s1,t1,w1,sum(c==1));

lap0     = create_lap(adj0);
lap1     = create_lap(adj1);

eig0     = get_2eig(lap0);
eig1     = get_2eig(lap1);

subplot(1,2,1)
count0 = 1; count1 = 1;

labels1 = zeros(sum(c==1),1);
labels0 = zeros(sum(c==0),1);

for j= 1:size(c)
   if(c(j) == 0)
       labels0(count0) = j-1;
       count0 = count0 + 1;
   else
       labels1(count1) = j-1;
       count1 = count1 + 1;
   end
end

 G = graph(adj0);
 plot(G,'b','Layout','subspace','EdgeLabel',G.Edges.Weight,...
       'LineWidth',2,'NodeLabel',labels0,'Markersize',6,'NodeColor','k');
   
   X = sprintf('Fiedler Value: %0.2f',eig0);
   title(X);
   axis off;
    
    subplot(1,2,2)
    G = graph(adj1);
    plot(G,'r','Layout','subspace','EdgeLabel',G.Edges.Weight,...
        'LineWidth',2,'NodeLabel',labels1,'Markersize',6,'NodeColor','k');
    
    
    X = sprintf('Fiedler Value: %0.2f',eig1);
    title(X);
    axis off;
    
    if(i == 0)
       figure
        G = graph(adj0);
       plot(G,'b','Layout','force','EdgeLabel',G.Edges.Weight,...
       'LineWidth',0.9,'NodeLabel',labels0,'Markersize',6,'NodeColor','k');
        X = sprintf('Fiedler Value: %0.2f',eig0);
        title(X);
    end
    
end