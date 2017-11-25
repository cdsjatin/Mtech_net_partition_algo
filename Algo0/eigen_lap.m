%% eigen_lap 
% This function returns the second eigen value of both 
% the partitions.

function [eig1,eig2,adj1,adj,lap1,lap] = eigen_lap(elist,nlist,npart,weights)

% generate new label on the partitions at nodes
% store that new labels in the third column of nodes.
label_count = zeros(1,npart);
[Nlen,~] = size(nlist);
eigenval = zeros(1,2);
    for i = 1:Nlen
    
     ll = label_count(nlist(i,2)+1);
     nlist(i,3) = ll;  
     label_count(nlist(i,2)+1) = ll + 1;
   
    end
     
for i = 1 : npart
 
 adj = zeros(label_count(i),label_count(i));
 
 D = adj;
 
    % Adj matrix
    % as the edges are undirected so each edge is repeated twice
 
    for k = 1:size(elist,1)
        if(nlist(elist(k,1)+1,2) == i-1)
        adj( nlist(elist(k,1)+1,3)+1 , nlist(elist(k,2)+1,3)+1 ) = elist(k,3);
        adj( nlist(elist(k,2)+1,3)+1 , nlist(elist(k,1)+1,3)+1 ) = elist(k,3);
        end
    end

    
 % Compute D matrix
 
     for k = 1:label_count(i)
        D(k,k) = sum(adj(:,k));     
     end
     lap = D-adj;
     xx = eig(lap);

     if(size(xx,1) > 1)
      eigenval(i) = xx(2);
     end
     
     if(i == 1)
        lap1 = lap; 
        adj1 = adj;
     end    
     
end

    eig1 = eigenval(1);
    eig2 = eigenval(2);

end
