% Nomes: Luís Felipe de M. C. Silva                              Nº USP: 9297961
%        Nícolas Nogueira L. da Silva                                    9277541
%
% Arquivo parte do EP2 de MAC0210

function decompress (compressedImg, method, k) 
	A = imread (compressedImg);
	if method == 1
		B = bilinear (A, k);
	else
		B = bicubico (A, k);
	endif
	imwrite ('decompressed.png');
endfunction

function B = bilinear (A, k)

endfunction

funcion B = bicubico (A, k)

endfunction