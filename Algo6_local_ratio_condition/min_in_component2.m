%% V2 !!!updated!!! min_in_Component
% find the minimum weight degree from the component;

function [id,omit_vset] = min_in_component2(e_cost,i_cost,c,gnum,omit_vset)
    
    %w = randi([6],7,1)
    %c = [1,0,0,0,1,1,0]'
    %gnum = 0;
    
    c_new = zeros(size(c,1),1);
    omit_vset_new = zeros(size(omit_vset,1),1);
    % mera group number is always meant to be 1
    c_new(c==gnum) = 1;
    omit_vset_new(omit_vset==0) = 1;
    
    w = min(e_cost ./ i_cost,1);
    
    ss = w .* c_new .* omit_vset_new;
    [~,ii] = sort(ss);
    offset = sum(ss == 0);
    id = ii(offset+1);
    
    omit_vset(id) = 1;
 
end