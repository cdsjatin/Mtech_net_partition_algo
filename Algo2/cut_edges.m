%% cut_edges
% it will keep the edge that are to be cut and remove the other edge from
% the set of source s and target t, also remove the weights; 

function [sn,tn,wn] = cut_edges(s,t,w,c)

    n = size(s,1);
    count = 1;
    sn = zeros(size(s));
    tn = zeros(size(t));
    wn = zeros(size(w));
    for i = 1:n
        
        if(c(s(i)+1) ~= c(t(i)+1))
             
            sn(count) = s(i);
            tn(count) = t(i);
            wn(count) = w(i);
            count = count + 1;
            
        end
        
    end

end