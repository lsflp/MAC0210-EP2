% Nomes: Luís Felipe de M. C. Silva    Nº USP: 9297961
%        Nícolas Nogueira L. da Silva          9277541
%
% Arquivo parte do EP2 de MAC0210

%PROBLEMAS: FUNÇÃO DE ESCRITA NA MATRIZ NÃO ESTÁ CERTA. COMO ESTÁ DOUBLE ELE CONVERTE E DÁ ESSE TROÇO AI.
%           ESTAMOS DECLARANDO UMA MATRIZ DOUBLE, MAS TEM QUE SER uint8 OU uint16

function compress (originalImg, k)
    I = imread (originalImg);
    p = size(I)(1);
    n = floor((p+k)/(1+k));
    J = zeros(n, n, 3);
    
    for i = 1:p
        for j = 1:p
            if (rem(i, k+1) == 1 && rem(j, k+1) == 1)
                J(floor(i/(k+1)+1), floor(j/(k+1)+1), 1) = uint8(I(i, j, 1));
                J(floor(i/(k+1)+1), floor(j/(k+1)+1), 2) = uint8(I(i, j, 2));
                J(floor(i/(k+1)+1), floor(j/(k+1)+1), 3) = uint8(I(i, j, 3));
            endif
        endfor
    endfor

    imwrite (J, 'compressed.png');
    
endfunction