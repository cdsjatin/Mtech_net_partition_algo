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

NUM_NODES = 25;
DIV_FACTOR = 2;
MAX_ITER = 12;
MAX_N = 100;    % number of random runs

FILENAME = '../data/edgeG.csv'

fid = fopen(FILENAME);
C = textscan(fid,'%d%c%d%c%d','Headerlines',1);
s = C{1};
t = C{3};
w = double(C{5});
clear C;

% Generating Value for threshold using Eign value of Complete Graph
adj = create_adj(s,t,w,NUM_NODES);
lap = create_lap(adj);
J = max(get_2eig(lap))/DIV_FACTOR
degree_w = get_degreeWeight(adj);
max_cno = 0;
max_euc_eig = 0;
max_eig_val = [0;0];
jj = 0;

%x = 0;

while(jj < MAX_N)
    
    [c,c_no] = random_cutset(NUM_NODES);
    %c = [1;1;1;0;0;0]
    jj = jj + 1 ;
    omit_vset = zeros(NUM_NODES,1);
    clear eigA eigB
    eigA = 0;
    eigB = 0;
    figure(1);
      
    for i = 1: MAX_ITER
        
        [s0,t0,w0,cnt0]   = part_edgesG(s,t,w,c,0);
        [s1,t1,w1,cnt1]   = part_edgesG(s,t,w,c,1);
        
        edge_cutset = get_edgeCutset(s,t,c);
        
        adj0     = create_adj(s0,t0,w0,sum(c==0));
        adj1     = create_adj(s1,t1,w1,sum(c==1));
        
        lap0     = create_lap(adj0);
        lap1     = create_lap(adj1);
        
        eig0     = get_2eig(lap0);
        eig1     = get_2eig(lap1);
        
        [e_cost,i_cost] = get_Cost(s,t,w,c,NUM_NODES,omit_vset); % compute cost wrt each node
        
        % if(eig0 < J && eig1 < J)
        % jj
        % break;
        %end
        
        % If both eigen values are greater than cut off
        if(eig0 > J && eig1 > J)
          
        
            
            
            %x = x+1;
            %disp(sprintf('Success %d of %d',x,jj));
            
            if(max_euc_eig < norm([J;J]-[eig0;eig1],2))
                
                max_euc_eig = norm([J;J]-[eig0;eig1],2);
                max_eig_val = [eig0;eig1];
                max_cno = bi2de(c');
                
                figure(2);
        subplot(1,2,1)
        G = graph(adj0);
        plot(G,'b','Layout','subspace','EdgeLabel',G.Edges.Weight);
        X = sprintf('Eigen Value: %0.2f',eig0)
        title(X);
        
        subplot(1,2,2)
        G = graph(adj1);
        plot(G,'r','Layout','subspace','EdgeLabel',G.Edges.Weight);
        X = sprintf('Eigen Value: %0.2f',eig1)
        title(X);
                
                
            end
            %jj = JJ + 1;
          
            %break;
            
        end
        
        %if(eig0 < J || eig1 < J)
        
        
        if(eig0 > eig1)
            
            % give very less and take a lot more
            [idx_a,omit_vset] = max_in_component2(e_cost,i_cost,...
                c,1,omit_vset);
            
            [idx_b,omit_vset] = max_in_component2(e_cost,i_cost,...
                c,0,omit_vset);
            
            %idx_a = -1            
            %display(sprintf('Swapping %d with %d ',idx_a-1,idx_b-1));
          
        else
        
            [idx_a,omit_vset] = max_in_component2(e_cost,i_cost,...
                c,0,omit_vset);
            
            [idx_b,omit_vset] = max_in_component2(e_cost,i_cost,...
                c,1,omit_vset);
            
            %display(sprintf('Swapping %d with %d ',idx_b-1,idx_a-1));
      
        end
        
        if(idx_a ~= -1 && idx_b ~= -1)
            c(idx_a) = 1-c(idx_a);
            c(idx_b) = 1-c(idx_b);
        else
            break;
        end
        
        c_no = bi2de(c');
        
        %end
        
        eigA(i) = eig0;
        eigB(i) = eig1;
        
        %{
   figure(1)
    subplot(1,2,1)
    plot(eigA);
    X = sprintf('%0.2f,nodes=%d',eig0,size(adj0,1));
    title(X);
    
    subplot(1,2,2)
    plot(eigB);
    X = sprintf('%0.2f,nodes=%d',eig1,size(adj1,1));
    title(X);
        %}
        %{
    %pause(0.5)
    waiting = waitforbuttonpress;
    
    if waiting == 0
    disp('Button click')
    else
    disp('Key press')
    end
        %}
        
    end
end

%graph_plot(max_cno)