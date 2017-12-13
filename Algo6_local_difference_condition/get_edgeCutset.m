%% get_edgeCutset
% returns the edge if cut 
% if cut the number at that is set to one else zero

function edge_cutset = get_edgeCutset(s,t,c)
    
    n = size(s,1);
    edge_cutset = zeros(n,1);
    for i = 1:n      
        if(c(s(i)+1) ~= c(t(i)+1))
           
            edge_cutset(i) = 1;
            
        end       
    end   
end