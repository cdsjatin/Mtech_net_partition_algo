%% create adjacency matrix 
% from the given edge list and weight.
% given the number of nodes.
% Undirected non self looped adjacency matrix

function adj = create_adj(s,t,w,n)

    adj = zeros(n,n);
    m = size(s,1);
  
        for i = 1:m
            if(s(i) ~= t(i))
                adj(s(i)+1,t(i)+1) =  w(i);
                adj(t(i)+1,s(i)+1) =  w(i);
            end
        end

end