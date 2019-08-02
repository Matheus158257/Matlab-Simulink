clear all;

%%%%%%%%%%%%%%%%%% Projeto Rob?tica %%%%%%%%%%%%%%%%%%

%% Dados do Robo
    syms theta1 d1 a1  alpha1 
    syms theta2 d2 a2  alpha2
    syms theta3 d3 a3  alpha3
    syms theta4 d4 a4  alpha4


%% Cinematica Direta

%%%%%%%%%%%%%%%%% Denavit Hatenberg %%%%%%%%%%%%%%%%%
%Variaveis
    %todos os thetas
DH =[0 d1 0 pi/2;
      +pi/2 d2 0 -pi/2;
      0 d3 0 pi/2;
     theta4 0 0 -pi/2];


 %%%%%%%%%%%%%%%%% Encontro dos A %%%%%%%%%%%%%%%%% 
 for i = 1:4
 
         Rotz = [cos(DH(i,1)) -sin(DH(i,1)) 0 0;
                sin(DH(i,1))   cos(DH(i,1)) 0 0;
                0                0            1 0;
                0                0            0 1];
            
         Transd =[ 1 0 0 0; 
                   0 1 0 0;
                   0 0 1 DH(i,2);
                   0 0 0 1];
               
         Transa =[ 1 0 0 DH(i,3); 
                   0 1 0 0;
                   0 0 1 0;
                   0 0 0 1];                   
                   
          Rotx = [1              0            0            0;
                 0          cos(DH(i,4))  -sin(DH(i,4))  0;
                 0          sin(DH(i,4))   cos(DH(i,4))  0;
                 0                0             0          1];
             
             
             
          
          M = (Rotz)*(Transd)*(Transa)*(Rotx);
          
              if i ==1
                  A_1 = M;
              elseif i ==2
                  A_2 = M;
              elseif i ==3
                  A_3 = M;
              elseif i ==4
                  A_4 = M;
              end
        
 end    



%%%%%%%%%%%%%%%%% Encontro da matriz H em rela??p ao referencial %%%%%%%%%%%%%%%%%
 H_01 = A_1;
 H_02 = A_1*A_2;
 H_03 = A_1*A_2*A_3;
 H_04 = A_1*A_2*A_3*A_4;
 
 H_01 = simplify(H_01);
 H_02 = simplify(H_02);
 H_03 = simplify(H_03);
 H_04 = simplify(H_04);
 
  %%%%%%%%%%%%%%%%% Encontro da matriz R de rota??o %%%%%%%%%%%%%%%%%
 R1 = H_01(1:3,1:3);
 R2 = H_02(1:3,1:3);
 R3 = H_03(1:3,1:3);
 R4 = H_04(1:3,1:3);

 %%%%%%%%%%%%%%%%% Encontro da matriz o e z %%%%%%%%%%%%%%%%% 
 
 z0 = [0 0 1]';
 o0 = [0 0 0]';
 z1 = H_01(1:3,3);
 o1 = H_01(1:3,4);
 z2 = H_02(1:3,3);
 o2 = H_02(1:3,4);
 z3 = H_03(1:3,3);
 o3 = H_03(1:3,4);
 z4 = H_04(1:3,3);
 o4 = H_04(1:3,4);
 
 %%%%%%%%%%%%%%%%% Encontro da matriz J %%%%%%%%%%%%%%%%% 
 
 %Velocidade Linear
 J1v = z0;
%  simplify(J1v);
 J2v = z1;
 J2v = simplify(J2v);
 J3v = z2;
 J3v= simplify(J3v);
 J4v = cross(z3,(o4-o3));
 J4v = simplify(J4v);

 
 % Velocidade Angular
 zero3 = o0; 
 J1w = zero3;
 J2w = zero3;
 J3w = zero3;
 J4w = z3;

 
 % Matriz completa
 J1 = [J1v;J1w];
 J2 = [J2v;J2w];
 J3 = [J3v;J3w];
 J4 = [J4v;J4w];

 
 
J = [J1,J2,J3,J4];

%J = J([1,2,5,6],:);
 
%J11 = J([1,2],[1,2]);

%J12 = J([1,2],[3,4]);
 
%J21 = J([3,4],[1,2]);
 
%J22 = J([3,4],[3,4]);
 
%%Singularidades
 
%  simplify(det(J11))
 %if det(J11)~=0
%  [J11_sing_theta1, J11_sing_theta2, J11_sing_theta3, J11_sing_theta4, ...
%      J11_sing_theta5, J11_sing_theta6] 
 %S11 = solve (simplify(det(J11))==0, d1, d2, d3, theta4);

%SingularitiesJ11_PPPR = [eval(S11.d1), eval(S11.d2), eval(S11.d3), eval(S11.theta4)];

 %end
 
%  simplify(det(J12))
 %if det(J12)~=0
%   [J12_sing_theta1, J12_sing_theta2, J12_sing_theta3, J12_sing_theta4, ...
%      J12_sing_theta5, J12_sing_theta6] 
 %S12 = solve (simplify(det(J12))==0,d1, d2, d3, theta4);

%SingularitiesJ12_PPPR = [eval(S12.d1), eval(S12.d2), eval(S12.d3), eval(S12.theta4)];

 %end
 
%  simplify(det(J21))
 %if det(J21)~=0
% [J21_sing_theta1, J21_sing_theta2, J21_sing_theta3, J21_sing_theta4, ...
%      J21_sing_theta5, J21_sing_theta6] 
 %S21 = solve (simplify(det(J21))==0, d1, d2, d3, theta4);

%SingularitiesJ21_PPPR = [eval(S21.d1), eval(S21.d2), eval(S21.d3),eval(S21.theta4)];
 %end
 
%  simplify(det(J22))
 %if det(J22)~=0
% [J22_sing_theta1, J22_sing_theta2, J22_sing_theta3, J22_sing_theta4, ...
%      J22_sing_theta5, J22_sing_theta6] 
 %S22 = solve (simplify(det(J22))==0, d1, d2, d3, theta4);

%SingularitiesJ22_PPPR = [eval(S22.d1), eval(S22.d2), eval(S22.d3),eval(S22.theta4)];
 %end
 
 
 
 
 
 
 
 
 %% Dinamica
    %D(q)q'' + C(q,q')q' + g(q) = tal
    
    % Variaveis
    syms q1 q2 q3 q4 q5 q6
    q1 = d1;
    q2 = d2;
    q3 = d3;
    q4 = theta4;
    q = [q1,q2,q3,q4];
    
   syms d1_dot d2_dot d3_dot theta4_dot
   
    q1_dot = d1_dot;
    q2_dot = d2_dot;
    q3_dot = d3_dot;
    q4_dot = theta4_dot;

    q_dot = [q1_dot;q2_dot;q3_dot;q4_dot];

    %Valores I hipoteticos
    syms Ixx1 Iyy1 Izz1
    syms Ixx2 Iyy2 Izz2
    syms Ixx3 Iyy3 Izz3
    syms Ixx4 Iyy4 Izz4

    
    %Massa elos
    syms m1 m2 m3 m4
    
    
    %Colocando o J no formato do exercicio
%     
    J1vd = [J1v,zero3,zero3,zero3];
    J2vd = [J1v,J2v,zero3,zero3];
    J3vd = [J1v,J2v,J3v,zero3];
    J4vd = [J1v,J2v,J3v,J4v];

    J1wd = [J1w,zero3,zero3,zero3];
    J2wd = [J1w,J2w,zero3,zero3];
    J3wd = [J1w,J2w,J3w,zero3];
    J4wd = [J1w,J2w,J3w,J4w];
    
    %Colocando o I no formato do exercicio
    I1 = [Ixx1  0    0;
          0    Iyy1  0;
          0     0    Izz1];
      
    I2 = [Ixx2  0    0;
          0    Iyy2  0;
          0     0    Izz2];
      
    I3 = [Ixx3  0    0;
          0    Iyy3  0;
          0     0    Izz3];
      
    I4 = [Ixx4  0    0;
          0    Iyy4  0;
          0     0    Izz4];
     
      
    %% Calculo da Equa??o Dinamica
    
    % Calculo da Matriz D
    
    %D = m[Jv]'[Jv]+[Jw]'[R][I][R]'[Jw]
    
    D1 = m1*(transpose(J1vd))*J1vd + transpose(J1wd)*(R1*I1*transpose(R1))*J1wd;
    D1 = simplify(D1);
    D2 = m2*(transpose(J2vd))*J2vd + transpose(J2wd)*(R2*I2*transpose(R2))*J2wd;
    D2 = simplify(D2);
    D3 = m3*(transpose(J3vd))*J3vd + transpose(J3wd)*(R3*I3*transpose(R3))*J3wd;
    D3 = simplify(D3);
    D4 = m4*(transpose(J4vd))*J4vd + transpose(J4wd)*(R4*I4*transpose(R4))*J4wd;
    D4 = simplify(D4);

    
    D = D1+D2+D3+D4;
    D = simplify(D);

    
    %Calculo da Matriz C
    %P=diff(f,x);
    %subs(P,{x,y},{1.5,2});
    
    C = zeros(4,4,4,'sym');
    for i=1:4
    for j=1:4
    for k=1:4
        
        %meio = 0.5
        C(i,j,k) = 0.5*diff(D(k,j),q(i))+ diff(D(k,i),q(j)) - diff(D(i,j),q(k));
        
    end
    end
    end
    
    C1 = [C(1,1,1) C(1,2,1) C(1,3,1) C(1,4,1);
          C(1,1,2) C(1,2,2) C(1,3,2) C(1,4,2);
          C(1,1,3) C(1,2,3) C(1,3,3) C(1,4,3);
          C(1,1,4) C(1,2,4) C(1,3,4) C(1,4,4)];
     C1 = simplify(C1);

      
     C2 =[C(2,1,1) C(2,2,1) C(2,3,1) C(2,4,1) ;
          C(2,1,2) C(2,2,2) C(2,3,2) C(2,4,2) ;
          C(2,1,3) C(2,2,3) C(2,3,3) C(2,4,3) ;
          C(2,1,4) C(2,2,4) C(2,3,4) C(2,4,4) ] ;
     C2 = simplify(C2);

      
    C3 = [C(3,1,1) C(3,2,1) C(3,3,1) C(3,4,1) ;
          C(3,1,2) C(3,2,2) C(3,3,2) C(3,4,2) ;
          C(3,1,3) C(3,2,3) C(3,3,3) C(3,4,3) ;
          C(3,1,4) C(3,2,4) C(3,3,4) C(3,4,4)] ;
     C3 = simplify(C3);
      
     C4 =[C(4,1,1) C(4,2,1) C(4,3,1) C(4,4,1);
          C(4,1,2) C(4,2,2) C(4,3,2) C(4,4,2);
          C(4,1,3) C(4,2,3) C(4,3,3) C(4,4,3);
          C(4,1,4) C(4,2,4) C(4,3,4) C(4,4,4)];
     C4 = simplify(C4);
    
    
     C = C1*q1_dot + C2*q2_dot + C3*q3_dot + C4*q4_dot;
     C = simplify(C);
   
     %% Calculo da Energia Cinetica E Potencial
     %Calculo da Energia Cinetica
     
     K = 0.5*transpose(q_dot)*D*q_dot;
     K = simplify(K);
     
     %Energia Potencia
     syms g% aceleração da gravidade
     P1 = H_01(3,4)*m1*g;
     P2 = H_02(3,4)*m2*g;
     P3=  H_03(3,4)*m3*g;
     P4=  H_04(3,4)*m4*g;
     P = P1+P2+P3+P4;
     P = simplify(P);
     
     %Encontro da Matriz g(q)
    g1 = diff(P,q(1));
    g2 = diff(P,q(2));
    g3 = diff(P,q(3));
    g4 = diff(P,q(4));
    
    G = [g1;g2;g3;g4];
    
    %Tals Simbolicos-> Substituir por valores Reais
    %syms Tal1 Tal2 Tal3 Tal4 
    %Tal = [Tal1;Tal2;Tal3;Tal4];
    
    syms d1_dot2 d2_dot2 d3_dot2 theta4_dot2
   
    q1_dot2 = d1_dot2;
    q2_dot2 = d2_dot2;
    q3_dot2 = d3_dot2;
    q4_dot2 = theta4_dot2;

    q_dot2 = [q1_dot2;q2_dot2;q3_dot2;q4_dot2];
    
    q = transpose(q);
    

    
    Tau = D*q_dot2+C*q_dot+G;
    
    
    
    
    
    %Equa??o Geral para encontrar a acelera??o
    %q_dot2 = D\(Tal-C*q_dot-g);