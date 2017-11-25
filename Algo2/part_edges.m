%% part edges
% it will take the edges s of the source
% and edge t of the target as well the weight w of the edges
% and return the edges only if the are in the same group
% s = source , t = target, w = weight, c = vertex cut
% c is binary starting form of nodes separation. 
% [0 1 0 0 1] means node 2 and node 5 are in same group while 
% node 1,3,4 are in group 0

function [sn,tn,wn] = part_edges(s,t,w,c)

    n = size(s,1);
    count = 1;
    sn = zeros(size(s));
    tn = zeros(size(t));
    wn = zeros(size(w));
    
    for i = 1:n
        
        if(c(s(i)+1) == c(t(i)+1))
             
            sn(count) = s(i);
            tn(count) = t(i);
            wn(count) = w(i);
            count = count + 1;
            
        end
        
    end

end