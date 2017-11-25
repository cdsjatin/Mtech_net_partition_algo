%% get_degreeWeight 
% returns the degree weight of each node in a vector

function deg_weight = get_degreeWeight(adj)

%s = rng(2)
%adj = randi(5,5)

    deg_weight = sum(adj,2);

end