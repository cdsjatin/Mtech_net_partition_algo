%% Generate cut set of random partition
% gives the group to which the node should belong randomly partitioned
% Number of nodes

function [c,c_no] = random_cutset(num_nodes)
 %num_nodes = 25   
    
 half_nodes = floor(num_nodes/2);

 c = [ones(half_nodes,1) 
     zeros(num_nodes-half_nodes,1)];

 %s = RandStream('mt19937ar','Seed',0);
 %c = c(randperm(s,length(c)));
 c = c(randperm(length(c)));
 
 
 c_no = bi2de(c');

end