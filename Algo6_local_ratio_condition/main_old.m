%   Main Brute Force Method
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

% Prompting and Input
prompt = {'Enter csv name:',...
        'Num_nodes','Value of Threshold (J)',...
        'Plot Graph (y/n)','No. Program parts'};   
dlg_title = 'Input';
num_lines = 1;
defaultans = {'data/edgeG.csv','25','3','n','0'};
x = inputdlg(prompt,dlg_title,num_lines,defaultans);

% parsing Cancel input
if (size(x,1) == 0)
    return
end

% Parsing Graph Input
if(x{4} == 'y' || x{4} == 'Y')
    prompt = {'Grid Dim (m)','Grid Dim (n)'};
    dlg_title = 'Plot Dimensions';
    xx = inputdlg(prompt,dlg_title,num_lines);  
    
    if(size(xx,1) == 0)
        return
    end
    
    figure;
    m = str2double(xx{1});
    n = str2double(xx{2}); % Grid Size of Plot
end



num_nodes = str2double(x{2});
lo = 1;
hi = 2^(num_nodes)-1;
part_no = 1;
npart = 1;

npart = str2double(x{5});
% Parsing Program part input
if(npart ~= 0)
    
    prompt = {sprintf('Part number (1-%d)',npart)}
    dlg_title = 'Part number';
    nn = inputdlg(prompt,dlg_title,num_lines);
    
    if(size(nn,1) == 0)
        return 
    end
    
    part = floor(hi/npart);
    part_no = str2double(nn(1));
    lo = (part_no-1)*part + 1
    hi = lo + part
    
end

% Open the desired input and output files
fid = fopen(x{1});
fname1 = sprintf('op/ccedges_%d_of_%d.txt',part_no,npart)
fidw = fopen(fname1,'w');
fname2 = sprintf('op/ccedgesJ_%d_of_%d.txt',part_no,npart)
fidw2 = fopen(fname2,'w');

if fid == -1
   disp('CANT OPEN DATA FILE !!');
   return;
end

% Input from input files.
C = textscan(fid,'%d%c%d%c%d','Headerlines',1);
s = C{1};
t = C{3};
w = C{5};
clear C;
J = str2double(x{3});
count = 1;
max = 0;
max_i = 0;

sno = 0;

%figure;
fprintf(fidw,'Contains all cutsetno and prog specific details\n');
fprintf(fidw,'Cutsetno \t cutedges \t eigval1 \t eigval2\n');

fprintf(fidw2,'Contains those cutsetno whose eig val greater than J = %3.4f\n',J);
fprintf(fidw2,'sno.\tCutsetno\tcutedges \t eigval1 \t eigval2\n');

% Setting for Waitbar
h = waitbar(0,'Progres...','Name',sprintf('Step Taken (%d/%d)',...
    part_no,npart),'CreateCancelBtn','setappdata(gcbf,''cancelling'',1)');
setappdata(h,'cancelling',0);
steps = hi-lo+1;


%plot(graph(create_adj(s,t,w,num_nodes)),'Layout','subspace');
tic


for i = lo:hi
 
%vlistn = partition(vlist,i); 
c = de2bi(i,num_nodes)';
%[s,t,w] = part_edges(s,t,w,c);

[s0,t0,w0,cnt0]   = part_edgesG(s,t,w,c,0);
[s1,t1,w1,cnt1]   = part_edgesG(s,t,w,c,1);

adj0     = create_adj(s0,t0,w0,sum(c==0));
adj1     = create_adj(s1,t1,w1,sum(c==1));

lap0     = create_lap(adj0);
lap1     = create_lap(adj1);

eig0     = get_2eig(lap0);
eig1     = get_2eig(lap1);

if getappdata(h,'cancelling')
    break
end

if (x{4} == 'y' || x{4} == 'Y')

subplot(m,n,count);
    G = graph(adj0);
    plot(G,'b','Layout','subspace','EdgeLabel',G.Edges.Weight);
    hold on;
    G = graph(adj1);
    plot(G,'r','Layout','subspace','EdgeLabel',G.Edges.Weight);
    hold off;
    X = sprintf('%0.2f,%0.2f,CutEdges=%d',eig0,eig1,cnt0+cnt1-2);
    title(X);
    pause(0.5);

end
    
    fprintf(fidw,'  %d\t   %d\t %12.2f\t%12.2f\n',i,cnt0+cnt1-2,eig0,eig1);
    
    waitbar((i-lo)/steps,h,...
        sprintf('Steps: %d/%d Time:%8.1f sec pAge: %3.3f ',...
        i,hi,toc,((i-lo)/steps)*100));
    
if(max < eig0 && max < eig1)
    max = min(eig0,eig1);
    max_i = i;
end

if(eig0 >= J && eig1 >= J)

    if (x{4} == 'y' || x{4} == 'Y')
    
        subplot(m,n,count);
        G = graph(adj0);
        plot(G,'b','Layout','subspace','EdgeLabel',G.Edges.Weight);
        hold on;
        G = graph(adj1);
        plot(G,'r','Layout','subspace','EdgeLabel',G.Edges.Weight);

        X = sprintf('%0.2f,%0.2f,CutEdges=%d',eig0,eig1,cnt0+cnt1-2);

        title(X);
        count =  count +1;

        pause(0.5)
    end
    
    fprintf(fidw2,'%d\t %d\t\t %d \t%12.2f\t %12.2f\n',sno,i,cnt0+cnt1-2,eig0,eig1);
    sno = sno + 1;
end

end

fprintf(fidw,'\n MAX iteration number is: %d and eig for that is: %f \n',...
            max_i,max);

total_time = toc;
fclose(fid);
fclose(fidw);
fclose(fidw2);
delete(h);
