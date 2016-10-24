% Nomes: Luís Felipe de M. C. Silva                              Nº USP: 9297961
%        Nícolas Nogueira L. da Silva                                    9277541
%
% Arquivo parte do EP2 de MAC0210

function decompress (compressedImg, method, k, h, x_, y_) 
	A = imread (compressedImg);
	if method == 1
		B = bilinear (A, k, h, x_, y_);
	else
		B = bicubico (A, k, h, x_, y_);
	endif
	imwrite (B, 'decompressed.png');
endfunction

function B = bilinear (A, k, h, x_, y_)
	B = expande (A, k);	
endfunction

function B = bicubico (A, k, h, x_, y_)
	B = expande (A, k);
endfunction

% Expande uma matriz quadrada de lado n para uma de lado n+(n-1)*k
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