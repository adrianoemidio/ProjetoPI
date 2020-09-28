% Disciplina de Processamento de imagens
% Projeto Parcial 1
% 
% @file projeto_parcial_1.m
% @author Adriano Leite Emidio
% @version 1.0
%

%Fecha todas as janelas
close all

%Remove as variáveis da memórai
clear

%Limpa a janela de comandos
clc

%Carrega o pacote para leitura de imagens
pkg load image

%Função para aplicar a autoescala
function retImg = autoescala(grayImg)
  
  %encotra o valor min de cinza
  f_min = min((min(grayImg)));
  
  %encotra o valor max de cinza
  f_max = max((max(grayImg)));
  
  %tamanho da imagem
  [lin col] = size(grayImg);
  
  %Percorre a imagem calculando a escala conforme a fórmula
  % B = (256 / (f_max - f_min) ) * (f - f_min) 
  for i=1:lin
    for j=1:col
      retImg(i,j) = (256 / (f_max - f_min) ) * (grayImg(i,j) - f_min);
    end
  end
  
  
endfunction

%Função para aplicar a quantização
function retImg = quantizacao(grayImg)
  
  %encotra o valor max de cinza
  cinza_max = max((max(grayImg)));
  
  %nível desejado
  nivel_des = 4;
  
  %encontra o tamanho do paso
  passo = round(cinza_max/nivel_des);
  
  %tamanho da imagem
  [lin col] = size(grayImg);
  
  %Percorre a imagem calculando a quantização
  for i=1:lin
    for j=1:col
      
      %Calcula a quantização
      retImg(i,j) = round(grayImg(i,j)/passo)*passo;
      
      %Verifica se houve overflow
      if retImg(i,j) > 255
        retImg(i,j) = 255;
      end
      
      %Verifica se hove underflow
      if retImg(i,j) < 0
          retImg(i,j) = 0;
      end
      
    end
  end
  
  
endfunction


%Função que aplica o spliting
function retImg = spliting(grayImg)
  
  %valor limiar
  limiar = 45;
    
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
      
      %Verifica se hove underflow
      if retImg(i,j) < 0
          retImg(i,j) = 0;
      end
      
    end
  end
 
endfunction


function retImg = binariza(grayImg)
  
  %valor limiar
  limiar = 45;

  %tamanho da imagem
  [lin col] = size(grayImg);
  
  %Percorre a imagem calculando o split
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


%Função que faz todos os processamentos e exibe na tela
function execProcess(imgName)
  
  %Tenta abrir a imagem
  A = imread(imgName);
  
  %Verifica se a imagem é colorida e a conteve para escala de cinza
  if isrgb(A)
    A = rgb2gray(A);
  end
 
  
  %Aplica a auto escala
  B = autoescala(A);

  %Aplica a quantização
  C = quantizacao(A);
  
  %Aplica o split
  D = spliting(A);
  
  %Aplica a qeualização de histograma
  E = histeq(A);
  
  %Aplica a binarização
  F = binariza(A);

  
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

  %Exibe fig. em quantização  
  subplot(2,3,3);
  imshow(C);
  title("Quantização");

  %Exibe fig. em Spliting  
  subplot(2,3,4);
  imshow(D);
  title("Spliting");

  %Exibe fig. da Equalização de Histograma
  subplot(2,3,5);
  imshow(E);
  title("Equalização de Histograma");
  
  %Exibe fig. da Binarização
  subplot(2,3,6);
  imshow(F);
  title("Binarização");  

  
   
endfunction

%Executa o porcessamento das imagens
execProcess('rice.png');
execProcess('mamografia.bmp');
execProcess('batatas.tif');
execProcess('solda.bmp');
execProcess('laranjas.bmp');



