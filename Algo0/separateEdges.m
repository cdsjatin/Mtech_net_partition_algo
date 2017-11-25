%% Separate Edges
% This is the matlab counter part of edge_new.cc
% it takes in edgelist and nodelist argument 
% and delete the edge if nodes are in different group

function list = separateEdges(elist,nlist)

[n,~] = size(elist);
count = 1;

for i = 1:n
   
    if( nlist(elist(i,1)+1,2) == nlist(elist(i,2)+1,2))
        list(count,:) = elist(i,:);
        count = count +1;
    end
    
end

end