% remove the edges according to the nodes

clear all;

fid = fopen('data/edgeG.csv');

C = textscan(fid,'%d%c%d%c%d','Headerlines',1);

edgelist(:,1) = C{1};
edgelist(:,2) = C{3};
edgelist(:,3) = C{5};

clear C;
% assuming each node has an edge
max_node = max(max(edgelist(:,1)),max(edgelist(:,2)));

nodelist = (0:max_node)';    % numbering starts from 1
iter = double(2^(max_node+1));
count = 1;
figure;
for i = 1:iter
 
n_nodelist = partitionNodes(nodelist,i);    
n_edgelist = separateEdges(edgelist,n_nodelist);
[a(i),b(i),adj,adj2,lap,lap2] = eigen_lap(n_edgelist,n_nodelist,2);

if(a(i) >= 3 && b(i) >= 3)
    i
    subplot(4,4,count);
    %G = graph(n_edgelist(:,1),n_edgelist(:,2),double(n_edgelist(:,3)));
    G = graph(adj);
    plot(G,'b');
   count =  count +1;
    
    subplot(4,4,count);
    G2 = graph(adj2);
    plot(G2,'r');
    
    count = count + 1;
end

end
clear G G2 
subplot(3,2,6);
boxplot(a)
%title('1st partition')
%ylabel('eigenvalue')

%subplot(1,2,2);
%boxplot(b);
%title('2nd group')
