% Nomes: Luís Felipe de M. C. Silva    Nº USP: 9297961
%        Nícolas Nogueira L. da Silva          9277541
%
% Arquivo parte do EP2 de MAC0210

function compress (originalImg, k)
    I = imread (originalImg);
    s = size(I);
    n = floor((s(1)+k)/(1+k));
    J = zeros(n, n, 3);
    
    for i = 1:s(1)
        for j = 1:s(1)
            if (rem(i, k+1) == 1 && rem(j, k+1) == 1)
                J(floor(i/k)+1, floor(j/k)+1, 1) = I(i, j, 1);
                J(floor(i/k)+1, floor(j/k)+1, 2) = I(i, j, 2);
                J(floor(i/k)+1, floor(j/k)+1, 3) = I(i, j, 3);
            endif
        endfor
    endfor
    
    imwrite (J, "compressed.png");
    
endfunction