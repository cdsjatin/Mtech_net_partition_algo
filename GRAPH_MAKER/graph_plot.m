%% graph_main 
% Takes values for i and plot on the basis of those i

function graph_plot(i)

num_nodes = 25;
fid = fopen('data/edgeG.csv','r');

C = textscan(fid,'%d%c%d%c%d%c%s','Headerlines',1);

s = C{1};
t = C{3};
w = C{5};
clear C;

fide = fopen('./data/edgeG_n.csv','w');
for i = 1:size(s,1)
   fprintf(fide,'%d,%d,%d,Undirected',s(i),t(i),w(i));
    
    
end

c = de2bi(i,num_nodes)';
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
 G = graph(adj0);
    plot(G,'b','Layout','subspace','EdgeLabel',G.Edges.Weight);
    X = sprintf('Eigen Value: %0.2f',eig0);
    title(X);   
    
    subplot(1,2,2)
    G = graph(adj1);
    plot(G,'r','Layout','subspace','EdgeLabel',G.Edges.Weight);
    X = sprintf('Eigen Value: %0.2f',eig1);
    title(X);   
 
  

%% Print the cutset into vertex file

fidv = fopen('./data/vertexG.csv','w');

a = 0:num_nodes-1
size(a)

fprintf(fidv,'Id\tLabel\tClass\n');

for i = 1:num_nodes
    fprintf(fidv,'%d\t%d\t%d\n',i-1,i-1,c(i));
end
    

system('gephi');
    
end


%


