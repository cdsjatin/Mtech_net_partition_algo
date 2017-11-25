%% min_in_Component
% find the minimum weight degree from the component;

function [id,not_c] = min_in_component(w,c,gnum,not_c)
    
    %w = randi([6],7,1)
    %c = [1,0,0,0,1,1,0]'
    %gnum = 0;
    
    c_new = zeros(size(c,1),1);
    % mera group number is always meant to be 1
    c_new(c==gnum) = 1;
    
    ss = w .* c_new;
    [kk,ii] = sort(ss);
    offset = sum(c_new == 0);
    id = ii(offset+1);
    
 while(not_c(id) == 1)
        
        offset = offset + 1;
        id = ii(offset+1);
        
        
  end
    
    not_c(id) = 1;
 
end