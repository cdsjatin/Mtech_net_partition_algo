%% max_in_component
% input are degree weight , weight array, edges_cutset, vertex_cutset
% group number , return the id of the node which satisfies condition
% max(2*w(cut_edge) - corresponding_degree_weight , in specific group)

function [max_id_b,not_c] = max_in_component(s,t,w,deg_w,edges_cutset,c,gnum,not_c)
    %rng(0);
    %deg_w = randi([6],5,1)
    %w = randi([6],5,1)
    
    %c = [1,0,0,1,1]
    %gnum = 0;
    
    c_new = zeros(size(c,1),1);
    
    c_new(c == gnum) = 1;
   
    % check for all the edges and corresponding node for the
    % condition
    n = sum(edges_cutset == 1);
   
    max = -99999;   % MINIMUM VALUE 
    max_id_b = -1;
    
    for k = 1:n
       
        id = get_kthmax(w,edges_cutset,k);
        
        % get the id of node in the desirable group
        if(c(s(id)+1) == gnum)
            id_b = s(id)+1;
        else
            id_b = t(id)+1;
        end
        
        rr = 0;
        
        for m = 1:n
            if(edges_cutset(m) == 1 && not_c(id_b) == 0)
                if(s(m) == id_b-1 && c(s(m)+1) == gnum)
                    rr = rr + w(m);
                else if(t(m) == id_b-1 && c(t(m)+1) == gnum)
                        rr = rr + w(m);
                    end
                end
            end
            
        end
        
        rr = (2*rr - deg_w(id_b));
        
        if( rr > max)
           max = rr;
           max_id_b = id_b   ;          
        end        
    
    end
    
    not_c(max_id_b) = 1;
    
    if(max < 0)
        display('Negative Result');
        
    end
end