% Nomes: Luís Felipe de M. C. Silva                              Nº USP: 9297961
%        Nícolas Nogueira L. da Silva                                    9277541
%
% Arquivo parte do EP2 de MAC0210

% Calcula o erro entre a imagem original e a imagem descomprimida, como pede o 
% enunciado.
function calculateError(originalImg, decompressedImg)
	A = imread (originalImg);
	B = imread (decompressedImg);

	C = double(A);
	D = double(B);

	errR = norm(C(:, :, 1)-D(:, :, 1))/norm(C(:, :, 1));
	errG = norm(C(:, :, 2)-D(:, :, 2))/norm(C(:, :, 2));
	errB = norm(C(:, :, 3)-D(:, :, 3))/norm(C(:, :, 3));

	err = (errR+errG+errB)/3

endfunction