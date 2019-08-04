%% Power electronics

% Choppers

%% Buck
sim('ConversorBuck')
% %%%%% Dados
% %deltaiL = 10%ILmed
% %deltavC = 1%Vo
% Vs = 100;%V
% fp = 100*(10^3);%khz
% Vo = 50;%V
% P = 50;%W
% %%%Encontrados
% R = ((Vo)^2)/(P);%50ohm
% D = Vo/Vs;%0.417
% ILmed = Vo/R;%10A
% L = ((Vs-Vo)*D)/((0.1*ILmed)*fs);%L = 29.2uF
% C = ((Vs-Vo)*D)/(8*L*(0.01*Vo)*(fs^2));%C = 25uF
% 
% 

Vs = 100;
L = 1;
C = 0.1;
R = 10;

fp = 60;
k = 50;

%% Boost
sim('ConversorBuck')
Vs = 100;
L = 1;
C = 0.1;
R = 10;

fp = 60;
k = 50;

%% Buck-Boost
sim('ConversorBuckBoost')
Vs = 100;
L = 1;
C = 0.1;
R = 10;

fp = 60;
k = 50;

%% Cuk
sim('ConversorCuk')
Vs = 100;
L1 = 1;
L2 = 1;
C1 = 0.1;
C2 = 0.1;
R = 10;

fp = 60;
k = 50;