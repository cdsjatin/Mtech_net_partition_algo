%% get_kthmax
% based on the weights of all edges, cutset and k number
% get the kth number that is maximum

function id = get_kthmax(w,c,k)
    %rng(0)
    %w = randi([7],9,1)
    %c = [0,0,1,1,0,1,0,1,0]';
    %k = 2
    n = size(w,1);
    id = -1;

    if(k > sum(c))
        display('kth Max doesnt EXIST !!');
        return ;    
    else
        ss = w .* c;
        [~,ii] = sort(ss);
        offset = sum(c == 0);
        id = ii(offset+k);

    end

%end