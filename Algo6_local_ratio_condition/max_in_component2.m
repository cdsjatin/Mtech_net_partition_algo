%% V2 !!!updated!!! max_in_component2
% input are degree weight , weight array, edges_cutset, vertex_cutset
% group number , return the id of the node which satisfies condition
% max(2*w(cut_edge) - corresponding_degree_weight , in specific group)

function [id,omit_vset] = max_in_component2(e_cost,i_cost,c,gnum,omit_vset)
    
    %w = randi([6],7,1)
    %c = [1,0,0,0,1,1,0]'
    %gnum = 0;
    
    c_new = zeros(size(c,1),1);
    omit_vset_new = zeros(size(omit_vset,1),1);
    % mera group number is always meant to be 1
    c_new(c==gnum) = 1;
    omit_vset_new = 1-omit_vset;
    
    %w = max(e_cost ./ i_cost,1);
    w = e_cost-i_cost
    
    ss = w .* c_new .* omit_vset_new;
    [~,ii] = sort(ss,'descend')
    %offset = sum(ss == 0);
    offset = 0;
    id = ii(offset+1);
    
    omit_vset(id) = 1;

end