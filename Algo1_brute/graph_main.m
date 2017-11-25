% Reading the output and Plotting 
% Graph in nice format

clc
clear all;
close all;
n = 16;

fid = fopen('./op/ccedgeJ_40/ccedgesJ_1_of_16.txt','r');
    
C = textscan(fid,'%d%d%d%f%f','Headerlines',2);

ccs = C{2};
e1 = C{4};
e2 = C{5};
num_nodes = 25;
count = 0;
J = 46
kk = 0;
ee1 = 0;
ee2 = 0;

fclose(fid);

for i = 2:n    
    
    fname1 = sprintf('./op/ccedgeJ_40/ccedgesJ_%d_of_%d.txt',i,n);
    fid = fopen(fname1,'r');
    
    C = textscan(fid,'%d%d%d%f%f','Headerlines',2);
    
    ccs = [ccs;C{2}] ;
    e1 = [e1;C{4}];
    e2 = [e2 ;C{5}];
    
    fclose(fid);
    
end

%% Plot graphs on the basis of these values of J

for i = 1:size(ccs,1)  
    if(e1(i) > J && e2(i) > J)
        ee1 = [ee1 e1(i)];
        ee2 = [ee2 e2(i)];
        kk = [kk ccs(i)];
        count = count+ 1;
    end    
end

for i = 1:size(kk,2)   
    vertex_i(kk(i),num_nodes);   
end

%{
for i = 1:size(kk,2)
    %subplot(2,size(kk,2)-3,i-1)
    figure;
    graph_plot(kk(i))
    
end
%}

