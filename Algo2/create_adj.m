%% create adjacency matrix 
% from the given edge list and weight.
% given the number of nodes.

function adj = create_adj(s,t,w,n)

    adj = zeros(n,n);
    m = size(s,1);
    
    for i = 1:m
    
        adj(s(i)+1,t(i)+1) = 1;
        adj(t(i)+1,s(i)+1) = 1;
       
    end

end