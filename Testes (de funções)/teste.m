function teste (A, k)
    p = size(A)(1);
    p
    n = floor((p+k)/(1+k))
    J = zeros(n, n, 3);
    
    for i = 1:p
        for j = 1:p
            if (rem(i, k+1) == 1 && rem(j, k+1) == 1)
                J(floor(i/(k+1)+1), floor(j/(k+1)+1), 1) = A(i, j, 1);
                J(floor(i/(k+1)+1), floor(j/(k+1)+1), 2) = A(i, j, 2);
                J(floor(i/(k+1)+1), floor(j/(k+1)+1), 3) = A(i, j, 3);
            endif
        endfor
    endfor
    
    J
    
endfunction