%% Compute external cost
% returns the num_nodes sized vector containing the cost 
% externally for each node. 
% External cost is the edge weight of two connecting nodes not belonging in
% same group

function [e_cost,i_cost] = get_Cost(s,t,w,c,num_nodes,omit_vset)

n = size(s,1);
e_cost = zeros(num_nodes,1);
i_cost = zeros(num_nodes,1);

for i = 1:n
   if(omit_vset(s(i)+1) ~= 1 && omit_vset(t(i)+1) ~= 1)
    
       if(c(s(i)+1) ~= c(t(i)+1) )
           i;
           e_cost(s(i)+1) =  e_cost(s(i)+1) + w(i);
           e_cost(t(i)+1) =  e_cost(t(i)+1) + w(i);
       else
           i_cost(s(i)+1) =  i_cost(s(i)+1) + w(i);
           i_cost(t(i)+1) =  i_cost(t(i)+1) + w(i);
        end
    
   end
end


end