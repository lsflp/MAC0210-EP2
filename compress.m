% Nomes: Luís Felipe de M. C. Silva    Nº USP: 9297961
%        Nícolas Nogueira L. da Silva          9277541
%
% Arquivo parte do EP2 de MAC0210

% Recebe uma imagem originalImg e cria uma nova imagem que é a versão comprimida
% da original, com a taxa de compressão k.
function compress (originalImg, k)
    I = imread (originalImg);
    p = size(I)(1);
    
    for i = 1:p
        for j = 1:p
            if (rem(i, k+1) == 1 && rem(j, k+1) == 1)
                J(floor(i/(k+1)+1), floor(j/(k+1)+1), :) = (I(i, j, :));
            endif
        endfor
    endfor

    imwrite (J, 'compressed.png');
    
endfunction