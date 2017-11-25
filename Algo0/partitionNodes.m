%% Separate Nodes 
% it generate the cut set on the basis of given number 
% and assign the nodes the position of where they should be

function list = partitionNodes(nlist,num)

list = [nlist,zeros(size(nlist,1),1)];
count = 1;

while(num ~= 0)

   list(count,2) = mod(num,2);
   num = floor(num/2);
   count = count+1;

end

end