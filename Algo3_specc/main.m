% Implementing spectral clustering for Given graph partition
% 17051574 - kerninghan
clc ;
close all;

clear all; 

NUM_NODES = 25
NEIGHBOUR = 2;
FILENAME = '../data/edgeG.csv'

fid = fopen(FILENAME);
C = textscan(fid,'%d%c%d%c%d','Headerlines',1);
s = C{1};
t = C{3};
w = C{5};
clear C;

adj  = create_adj(s,t,w,NUM_NODES);

% Create Affinity Matrix
if(NEIGHBOUR >= NUM_NODES)
    A = adj;
else
     % sort wrt rows in descending order and save its indices

      [~,I] = sort(adj,2,'descend');
      %S = S(:,1:neighbour);
      %I = I(:,1:neighbour);
      
      A = zeros(size(adj));
      
      for row = 1:size(I,1)
          
      A(row,I(row,1:NEIGHBOUR)) = adj(row,I(row,1:NEIGHBOUR)) ;  
      A(I(row,1:NEIGHBOUR),row) = adj(row,I(row,1:NEIGHBOUR)) ;
      
      end
end

      L = create_lap(A);
      [V,~] = eig(L);
      v = V(:,2);
      a = v>0;
      cutset_no = bi2de(a','right-msb')
      graph_plot(cutset_no);