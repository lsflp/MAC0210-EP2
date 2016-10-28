% Nomes: Luís Felipe de M. C. Silva                              Nº USP: 9297961
%        Nícolas Nogueira L. da Silva                                    9277541
%
% Arquivo parte do EP2 de MAC0210

function decompress (compressedImg, method, k, h) 
    A = imread (compressedImg);
    n = size(A)(1);
    p = n+(n-1)*k;
    if method == 1
        B = bilinear (A, k, h, p);
    else
        B = bicubico (A, k, h, p);
    endif
    imwrite (B, 'decompressed.png');
endfunction

function B = bilinear (A, k, h, p)
    B = expande (A, k, p);
    C = [1, 0, 0, 0; 1, 0, h, 0; 1, h, 0, 0; 1, h, h, h.^2];
    % Para cada quadrado
    for i = 1:k+1:p-(k+1)
        for j = 1:k+1:p-(k+1)
            %Pegar os indices convertidos
            %Pegar as funções nesses pontos, como um vetor
            fx1y1 = B(i, j, :);
            fx1y2 = B(i, j+(k+1), :);
            fx2y1 = B(i+(k+1), j, :);
            fx2y2 = B(i+(k+1), j+(k+1), :);
            %Pra cada posição do vetor (RGB), interpolar com a fórmula. X = inv(A)*B
            for l = 1:3
                D = [fx1y1(l); fx1y2(l); fx2y1(l); fx2y2(l)];
                E = double(D);
                X = inv(C)*E;
                %Para cada ponto nesse intervalo:
                for m = i:i+k+1
                    for n = j:j+k+1
                        if (m != i && n != j) 
                            x = ((m-i)/(k+1))*h;
                            y = ((n-j)/(k+1))*h;
                            B(m, n, l) = X(1) + X(2).*x + X(3).*y + X(4).*x.*y;
                        endif
                    endfor
                endfor
            endfor
        endfor
    endfor
endfunction

function B = bicubico (A, k, h, p)
    B = expande (A, k, p);
endfunction

% Expande uma matriz quadrada de lado n para uma de lado n+(n-1)*k
function B = expande (A, k, p)
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