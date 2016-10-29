function gerador (n)
    for i = 1:n
        for j = 1:n
            x(i, j) = i;
        endfor
    endfor
    
     for i = 1:n
        for j = 1:n
            y(i, j) = j;
        endfor
    endfor

    A (:, :, 1) =  cos(x);
    A (:, :, 2) =  2*cos(y);
    A (:, :, 3) =  x.^2;
    whos A
    imwrite (A, 'zoologico.png');
endfunction