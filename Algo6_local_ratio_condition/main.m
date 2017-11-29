%   Main Local Ratio stability method
% 
% Input Edgelist undirected (no edge repeat), will work if repeat too
% first row is header
% 1st column = source, 2nd column = target, 3rd column = weights

% Extra Variable num_nodes = number of nodes in graph
% Value of eigen threshold.
% Plotting max limit.

clc ;
close all;

clear all; 

%{ 
%Prompting and Input

prompt = {'Enter csv name:',...
        'Num_nodes','Value of Threshold (J)',...
        'Plot Graph (y/n)'};   
dlg_title = 'Input';
num_lines = 1;
defaultans = {'data/edgeG.csv','25','3','n'};
x = inputdlg(prompt,dlg_title,num_lines,defaultans);

% parsing Cancel input
if (size(x,1) == 0)
    return
end

num_nodes = str2double(x{2});


if fid == -1
   disp('CANT OPEN DATA FILE !!');
   return;
end

% Reading Graph.csv
% Open the desired input and output files
fid = fopen(x{1});
C = textscan(fid,'%d%c%d%c%d','Headerlines',1);
s = C{1};
t = C{3};
w = C{5};
clear C;
J = str2double(x{3});
%}
idx_a = -1

num_nodes = 25;
d_factor = 2;

fid = fopen('./data/edgeG.csv');
C = textscan(fid,'%d%c%d%c%d','Headerlines',1);
s = C{1};
t = C{3};
w = double(C{5});
clear C;

% Generating Value for threshold using Eign value of Complete Graph
adj = create_adj(s,t,w,num_nodes);
lap = create_lap(adj);
J = max(get_2eig(lap))/d_factor
max_iter = 12

degree_w = get_degreeWeight(adj);
jj = 0;

while(jj < 10)
    
[c,c_no] = random_cutset(num_nodes);
jj = jj + 1 ;
omit_vset = zeros(num_nodes,1);
clear eigA eigB
figure(1);

for i = 1: max_iter
    
    [s0,t0,w0,cnt0]   = part_edgesG(s,t,w,c,0);
    [s1,t1,w1,cnt1]   = part_edgesG(s,t,w,c,1);
    
    edge_cutset = get_edgeCutset(s,t,c);
    
    adj0     = create_adj(s0,t0,w0,sum(c==0));
    adj1     = create_adj(s1,t1,w1,sum(c==1));
    
    lap0     = create_lap(adj0);
    lap1     = create_lap(adj1);
    
    eig0     = get_2eig(lap0);
    eig1     = get_2eig(lap1);
    
    [e_cost,i_cost] = get_Cost(s,t,w,c,num_nodes,omit_vset); % compute cost wrt each node
    
    if i == 1
       eig0
       eig1
        
    end
    
    %if(eig0 < J && eig1 < J)
    %    jj
     %   break;
    %end
    
    % If both eigen values are greater than cut off
    if(eig0 > J && eig1 > J)
        
        figure(2);
        subplot(1,2,1)
        G = graph(adj0);
        plot(G,'b','Layout','subspace','EdgeLabel',G.Edges.Weight);
        X = sprintf('%0.2f,Edges=%d',eig0,size(adj0,1));
        title(X);
        
        subplot(1,2,2)
        G = graph(adj1);
        plot(G,'r','Layout','subspace','EdgeLabel',G.Edges.Weight);
        X = sprintf('%0.2f,Edges=%d',eig1,size(adj1,1));
        title(X);
        
        jj = 11;
        break;
        
        
    end
 
    if(eig0 < J || eig1 < J)
            
        
            if(eig0 > eig1)
              
               % give very less and take a lot more
                [idx_a,omit_vset] = min_in_component2(e_cost,i_cost,...
                                    c,1,omit_vset);
                                
                [idx_b,omit_vset] = max_in_component2(e_cost,i_cost,...
                                    c,0,omit_vset);
                
                %idx_a = -1
                
                display(sprintf('Swapping %d with %d ',idx_a,idx_b));
                
               if(idx_a ~= -1 && idx_b ~= -1)
                c(idx_a) = 1-c(idx_a);
                c(idx_b) = 1-c(idx_b);
               end
                
                
            else
                
                
                [idx_a,omit_vset] = min_in_component2(e_cost,i_cost,...
                                    c,0,omit_vset);
                                    
                [idx_b,omit_vset] = max_in_component2(e_cost,i_cost,...
                                    c,1,omit_vset);
                
                display(sprintf('Swapping %d with %d ',idx_b,idx_a));
                
               if(idx_a ~= -1 && idx_b ~= -1)
                c(idx_a) = 1-c(idx_a);
                c(idx_b) = 1-c(idx_b);
               end
                
            end
            
        c_no = de2bi(c');
            
    end
    
    i
    eigA(i) = eig0;
    eigB(i) = eig1;
    
   
    subplot(1,2,1)
    plot(eigA);
    X = sprintf('%0.2f,nodes=%d',eig0,size(adj0,1));
    title(X);
    
    subplot(1,2,2)
    plot(eigB);
    X = sprintf('%0.2f,nodes=%d',eig1,size(adj1,1));
    title(X);
    
    %pause(0.5)
    waiting = waitforbuttonpress;
    
    if waiting == 0
    disp('Button click')
    else
    disp('Key press')
    end
    
end

    max(eigA)
    max(eigB)

    
end