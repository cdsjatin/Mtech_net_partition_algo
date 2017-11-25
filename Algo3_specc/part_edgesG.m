%% create adjacency matrix according to group number 
% from the given edge list and weight.
% given the number of nodes.

function [sn,tn,wn,count] = part_edgesG(s,t,w,c,gnum)

    n = sum(c==gnum);
    sn = zeros(n,1);
    tn = zeros(n,1);
    wn = zeros(n,1);
    %sn,tn,wn;
    
    % Assigning new number to groups (vertex list)
    vl = zeros(size(c));
    count = 0;
    k = size(c,1);
    for i = 1:k 
        if(c(i) == gnum)
           vl(i) = count;
           count = count + 1;
        end
    end
   
    % Generate new list 
    % that is if(group number is 0) then new source list starts 
    % from vertex 0;
    count = 1;
    m = size(s,1);
    for i = 1:m
        if(c(s(i)+1) == c(t(i)+1) && c(s(i)+1) == gnum)
            sn(count) = vl(s(i)+1);
            tn(count) = vl(t(i)+1);
            wn(count) = w(i);
            count = count + 1;
        end
    end
    
end