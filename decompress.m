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
	C = [1, 0, 0, 0; 1, 0, h, 0; 1, h, 0, 0; 1, h, h.^2, h.^3];
	x1 = 1;
	y1 = 1;
	% Para cada quadrado
	for i = h+1:h:p
		for j = h+1:h:p
			%Pegar os indices convertidos
			x2 = i;
			y2 = j;
			%Pegar as funções nesses pontos, como um vetor
			fx1y1 = B(x1, y1, :);
			fx1y2 = B(x1, y2, :);
			fx2y1 = B(x2, y1, :);
			fx2y2 = B(x2, y2, :);
			%Pra cada posição do vetor (RGB), interpolar com a fórmula. X = inv(A)*B
			for l = 1:3
				D = [fx1y1(l); fx1y2(l); fx2y1(l); fx2y2(l)];
				D = double(D);
				X = inv(C)*D;
				%Sem os pontos de fronteira
				%Para cada ponto nesse intervalo:
				for m = x1:x2
					for n = y1:y2
						%Então calcular f(x, y) = x(1) + x(2) (x − x i ) + x(3)(y − y j ) + x(4) (x − x i )(y − y j ) 
						B(m, n, l) = X(1) + X(2).*(m - x1) + X(3).*(n - y1) + X(4).*(m - x1).*(n - y1);
					endfor
				endfor
			endfor
			x1 = x2;
			y1 = y2;
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