%% get_2eig
% return the second largest eigen value of the laplacian matrix
% return -1 if size of laplacian is smaller than 2 x 2

function ret = get_2eig(lap)
    
    if(size(lap,1) < 2)
        ret = -1;
        return ;
    else
       e = eig(lap);
       ret = e(2);
    end

end