% Disciplina de Processamento de imagens
% Projeto Parcial 1

%Fecha todas as janelas
close all

%Remove as variaveis da memoria
clear

%Limpa a janela de comandos
clc

%Integrantes do grupo
%Adriano Leite Emidio 770832
%Jose Vitor Novaes Santos 743556
%Marcus Vinicius Natrielli Garcia 743578
%Renan Rossignatti de Franca  489697
%Victor Fernandes de Oliveira Brayner 743600

%Carrega o pacote para leitura de imagens
pkg load image

%Funcao para aplicar a autoescala
function retImg = autoescala(grayImg)
  
  %encotra o valor min de cinza
  f_min = min((min(grayImg)));
  
  %encotra o valor max de cinza
  f_max = max((max(grayImg)));
  
  %tamanho da imagem
  [lin col] = size(grayImg);
  
  %Percorre a imagem calculando a escala conforme a formula
  % B = (255 / (f_max - f_min) ) * (f - f_min) 
  for i=1:lin
    for j=1:col
      retImg(i,j) = (255 / (f_max - f_min) ) * (grayImg(i,j) - f_min);
    end
  end
  
endfunction

%Funcao para aplicar a quantizacao
function retImg = quantizacao(grayImg)
  
  %encotra o valor max de cinza
  cinza_max = max((max(grayImg)));
  
  %nivel desejado
  nivel_des = 4;
  
  %encontra o tamanho do passo
  passo = round(cinza_max/nivel_des);
  
  %tamanho da imagem
  [lin col] = size(grayImg);
  
  %Percorre a imagem calculando a quantizacao
  for i=1:lin
    for j=1:col
      
      %Calcula a quantizacao
      retImg(i,j) = round(grayImg(i,j)/passo)*passo;
      
      %Verifica se houve overflow
      if retImg(i,j) > 255
        retImg(i,j) = 255;
      end
      
      %Verifica se houve underflow
      if retImg(i,j) < 0
          retImg(i,j) = 0;
      end
    end
  end
  
endfunction

%Funcao que aplica o spliting
function retImg = spliting(grayImg, limiar)
  
  %valor do split
  split = 15;

  %tamanho da imagem
  [lin col] = size(grayImg);
  
  %Percorre a imagem calculando o split
  for i=1:lin
    for j=1:col
      
      %Calcula o split
      if grayImg(i,j) <= limiar
        retImg(i,j) = grayImg(i,j) - split;
      else
        retImg(i,j) = grayImg(i,j) + split;
      end
      
      %Verifica se houve overflow
      if retImg(i,j) > 255
        retImg(i,j) = 255;
      end
      
      %Verifica se houve underflow
      if retImg(i,j) < 0
          retImg(i,j) = 0;
      end 
    end
  end
  
endfunction

%Funcao que aplica a binarizacao
function retImg = binariza(grayImg, limiar)
  
  %tamanho da imagem
  [lin col] = size(grayImg);
  
  %Percorre a imagem calculando o limiar
  for i=1:lin
    for j=1:col
      
      %Aplica o limiar
      if grayImg(i,j) >=  limiar
        retImg(i,j) = 255;
      else
        retImg(i,j) = 0;
      end 
    end
  end
  
endfunction

%Funcao que faz todos os processamentos e exibe na tela
function execProcess(imgName, limiar)
  
  %Tenta abrir a imagem
  A = imread(imgName);
  
  %Verifica se a imagem eh colorida e a converte para escala de cinza
  if isrgb(A)
    A = rgb2gray(A);
  end
  
  %Aplica a auto escala
  B = autoescala(A);

  %Aplica a quantizacao
  C = quantizacao(A);
  
  %Aplica o split
  D = spliting(A, limiar);
  
  %Aplica a equalizacao de histograma
  E = histeq(A);
  
  %Aplica a binarizacao
  F = binariza(A, limiar);

  %Cria uma janela com o nome da figura
  figure('name',imgName);
  
  %Exibe fig. em escala de cinza 
  subplot(2,3,1);
  imshow(A);
  title("Escala de cinza");

  %Exibe fig. em autoescala
  subplot(2,3,2);
  imshow(B);
  title("Autoescala");  

  %Exibe fig. em quantizacao  
  subplot(2,3,3);
  imshow(C);
  title("Quantizacao");

  %Exibe fig. em Spliting  
  subplot(2,3,4);
  imshow(D);
  title("Spliting");

  %Exibe fig. da Equalizacao de Histograma
  subplot(2,3,5);
  imshow(E);
  title("Equalizacao de Histograma");
  
  %Exibe fig. da Binarizacao
  subplot(2,3,6);
  imshow(F);
  title("Binarizacao");  
  
endfunction

%Executa o processamento das imagens
execProcess('rice.png', 110);
execProcess('mamografia.bmp', 45);
execProcess('batatas.tif', 100);
execProcess('solda.bmp', 180);
execProcess('laranjas.bmp', 125);
