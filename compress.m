% Nomes: Luís Felipe de M. C. Silva                              Nº USP: 9297961
%        Nícolas Nogueira L. da Silva                                    9277541
%
% Arquivo parte do EP2 de MAC0210

% Recebe uma imagem originalImg e cria uma nova imagem que é a versão comprimida
% da original, com a taxa de compressão k.
function compress (originalImg, k)
    A = imread (originalImg);
    p = size(A)(1);
    
    for i = 1:p
        for j = 1:p
            if rem(i, k+1) == 1 && rem(j, k+1) == 1
                B(floor(i/(k+1)+1), floor(j/(k+1)+1), :) = A(i, j, :);
            endif
        endfor
    endfor

    imwrite (B, 'compressed.png');
    
endfunction