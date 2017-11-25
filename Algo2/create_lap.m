%% create lap
% return laplacian matrix from given adjacency matrix

function lap = create_lap(adj)

    D = zeros(size(adj));
    
    for k = 1:size(adj,1)
        D(k,k) = sum(adj(:,k));     
    end
    
     lap = D-adj;

end