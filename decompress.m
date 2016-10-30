% Nomes: Luís Felipe de M. C. Silva                              Nº USP: 9297961
%        Nícolas Nogueira L. da Silva                                    9277541
%
% Arquivo parte do EP2 de MAC0210

% Recebe uma imagem comprimida e a descomprime usando o método bilinear ou o 
% método bicúbico. A taxa de descompressão é dada pelo k e o h representa o
% tamanho do lado do quadrado utilizado para o método escolhido para a
% interpolação.
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

% Utiliza o método bilinear para descomprimir uma imagem A para uma de 
% tamanho p. O k e o h são os mesmos da função decompress.
function B = bilinear (A, k, h, p)
    B = expande (A, k, p);
    C = [1, 0, 0, 0; 1, 0, h, 0; 1, h, 0, 0; 1, h, h, h.^2];
    % Para cada quadrado.
    for i = 1:k+1:p-(k+1)
        for j = 1:k+1:p-(k+1)
            % Pega os valores dos pixels que estão nos extremos dos quadrados.
            fx1y1 = B(i, j, :);
            fx1y2 = B(i, j+(k+1), :);
            fx2y1 = B(i+(k+1), j, :);
            fx2y2 = B(i+(k+1), j+(k+1), :);
            % Faz a interpolação para cada cor, na ordem vermelho, verde e azul.
            for l = 1:3
                D = [fx1y1(l); fx1y2(l); fx2y1(l); fx2y2(l)];
                E = double(D);
                X = inv(C)*E;
                % Para cada pixel dentro desse quadrado.
                for m = i:i+k+1
                    for n = j:j+k+1
                        % Se não for o pixel original usado para a interpolação.
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

% Utiliza o método bicubico para descomprimir uma imagem A para uma de 
% tamanho p. O k e o h são os mesmos da função decompress.
function B = bicubico (A, k, h, p)
    B = expande (A, k, p);
    % No enunciado essa é a matriz B
    C = [1, 0, 0, 0; 0, 0, 1, 0; -3./(h.^2), 3./(h.^2), -2./h, -1./h; 2./(h.^3), -2./(h.^3), 1./(h.^2), 1./(h.^2)];
    % Para cada quadrado.
    for i = 1:k+1:p-(k+1)
        for j = 1:k+1:p-(k+1)
            % Pega os valores dos pixels que estão nos extremos dos quadrados.
            fx1y1 = B(i, j, :);
            fx1y2 = B(i, j+(k+1), :);
            fx2y1 = B(i+(k+1), j, :);
            fx2y2 = B(i+(k+1), j+(k+1), :);
            dyfx1y1 = ?;
            dyfx1y2 = ?;
            dyfx2y1 = ?;
            dyfx2y2 = ?;
            dxfx1y1 = ?;
            dxfx1y2 = ?;
            dxfx2y1 = ?;
            dxfx2y2 = ?;
            dxyfx1y1 = ?;
            dxyfx1y2 = ?;
            dxyfx2y1 = ?;
            dxyfx2y2 = ?;
            % Faz a interpolação para cada cor, na ordem vermelho, verde e azul.
            for l = 1:3
                D =   [  fx1y1(l),   fx1y2(l),  dyfx1y1(l),  dyfx1y2(l); 
                         fx2y1(l),   fx2y2(l),  dyfx2y1(l),  dyfx2y2(l);
                       dxfx1y1(l), dxfx1y2(l), dxyfx1y1(l), dxyfx1y2(l);
                       dxfx2y1(l), dxfx2y2(l), dxyfx2y1(l), dxyfx2y2(l)];
                E = double(D);
                % Matriz de coeficientes do polinomio intepolador
                X = C*E*transpose(C);
                % Para cada pixel dentro desse quadrado.
                for m = i:i+k+1
                    for n = j:j+k+1
                        % Se não for o pixel original usado para a interpolação.
                        if (m != i && n != j) 
                            x = ((m-i)/(k+1))*h;
                            y = ((n-j)/(k+1))*h;
                            B(m, n, l) = [1, x, x.^2, x.^3]*X*[1; y; y.^2; y.^3];
                        endif
                    endfor
                endfor
            endfor
        endfor
    endfor
endfunction

% Expande uma matriz quadrada de lado n para uma de lado n+(n-1)*k (De 
% (p+k)/(1+k)) para p.
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