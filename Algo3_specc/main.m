% Implementing spectral clustering for Given graph partition
% 17051574 - kerninghan
clc ;
close all;

clear all; 

fid = fopen('data/edgeG.csv');
C = textscan(fid,'%d%c%d%c%d','Headerlines',1);
s = C{1};
t = C{3};
w = C{5};
clear C;

neighbour = 2;
N = 25;

adj  = create_adj(s,t,w,N);

% Create Affinity Matrix
if(neighbour >= N)
    A = adj;
else
     % sort wrt rows in descending order and save its indices

      [~,I] = sort(adj,2,'descend');
      %S = S(:,1:neighbour);
      %I = I(:,1:neighbour);
      
      A = zeros(size(adj));
      
      for row = 1:size(I,1)
          
      A(row,I(row,1:neighbour)) = adj(row,I(row,1:neighbour)) ;  
      A(I(row,1:neighbour),row) = adj(row,I(row,1:neighbour)) ;
      
      end
end

      L = create_lap(A);
      [V,~] = eig(L);
      v = V(:,2);
      a = v>0;
      cutset_no = bi2de(a','right-msb')
      graph_plot(cutset_no);