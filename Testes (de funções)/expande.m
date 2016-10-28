function B = expande (A, k)
	n = size(A)(1);
	p = n+(n-1)*k;

    for i = 1:p
        for j = 1:p
            if rem(i, k+1) == 1 && rem(j, k+1) == 1
                B(i, j, :) = A(((i-1)/(k+1))+1, ((j-1)/(k+1))+1, :);
            else
                B(i, j, :) = 0;
            endif 
        endfor
    endfor

endfunction