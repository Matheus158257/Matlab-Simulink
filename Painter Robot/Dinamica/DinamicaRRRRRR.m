%%%%%%%%%%%%%%%%%% Projeto Robótica %%%%%%%%%%%%%%%%%%

%% Dados do Robo

   syms tH d1 A  alphA 
   syms th2 d2 a2  alpha2
   syms th3 d3 a3  alpha3
   syms th4 d4 a4  alpha4
   syms th5 d5 a5  alpha5
   syms th6 d6 a6  alpha6

%% Cinematica Direta

%%%%%%%%%%%%%%%%% Denavit Hatenberg %%%%%%%%%%%%%%%%%


%Variaveis
    %todos os thetas
DH =[tH   0    0    -pi/2;
      th2   0    a2   0;
      th3   0    a3  -pi/2;
      th4   0    0    pi/2;
      th5   0    0    -pi/2;
      th6   d6   0    0];


 %%%%%%%%%%%%%%%%% Encontro dos A %%%%%%%%%%%%%%%%% 
 for i = 1:6
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
              elseif i ==5
                  A_5 = M;
              elseif i ==6
                  A_6 = M;
              end
          
 end     

 %%%%%%%%%%%%%%%%% Encontro da matriz A %%%%%%%%%%%%%%%%%
 A_1 = simplify(A_1);
 A_2 = simplify(A_2);
 A_3 = simplify(A_3);
 A_4 = simplify(A_4);
 A_5 = simplify(A_5);
 A_6 = simplify(A_6);

%%%%%%%%%%%%%%%%% Encontro da matriz H em relaçãp ao referencial %%%%%%%%%%%%%%%%%
 H_01 = A_1;
 H_02 = A_1*A_2;
 H_03 = A_1*A_2*A_3;
 H_04 = A_1*A_2*A_3*A_4;
 H_05 = A_1*A_2*A_3*A_4*A_5;
 H_06 = A_1*A_2*A_3*A_4*A_5*A_6;

 H_01 = simplify(H_01);
 H_02 = simplify(H_02);
 H_03 = simplify(H_03);
 H_04 = simplify(H_04);
 H_05 = simplify(H_05);
 H_06 = simplify(H_06);
 
  %%%%%%%%%%%%%%%%% Encontro da matriz de rotação R %%%%%%%%%%%%%%%%%
 
 R1 = H_01(1:3,1:3);
 R2 = H_02(1:3,1:3);
 R3 = H_03(1:3,1:3);
 R4 = H_04(1:3,1:3);
 R5 = H_05(1:3,1:3);
 R6 = H_06(1:3,1:3);

   
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
 z5 = H_05(1:3,3);
 o5 = H_05(1:3,4);
 z6 = H_06(1:3,3);
 o6 = H_06(1:3,4);
 
 
 %%%%%%%%%%%%%%%%% Encontro da matriz J total %%%%%%%%%%%%%%%%% 
 %Velocidade Linear
 J1v = cross(z0,(o6-o0));
 J1v= simplify(J1v);
 J2v = cross(z1,(o6-o1));
 J2v = simplify(J2v);
 J3v = cross(z2,(o6-o2));
 J3v= simplify(J3v);
 J4v = cross(z3,(o6-o3));
 J4v = simplify(J4v);
 J5v = cross(z4,(o6-o4));
 J5v = simplify(J5v);
 J6v = cross(z5,(o6-o5));
 J6v = simplify(J6v);
 % Velocidade Angular
 J1w = z0;
 J2w = z1;
 J2w = simplify(J2w);
 J3w = z2;
 J3w = simplify(J3w);
 J4w = z3;
 J4w = simplify(J4w);
 J5w = z4;
 J5w = simplify(J5w);
 J6w = z5;
 J6w = simplify(J6w);
 
 % Matriz completa
 J1 = [J1v;J1w];
 J2 = [J2v;J2w];
 J3 = [J3v;J3w];
 J4 = [J4v;J4w];
 J5 = [J5v;J5w];
 J6 = [J6v;J6w];
 
 J = [J1,J2,J3,J4,J5,J6];
 

 
 
 %% Dinamica
    %D(q)q'' + C(q,q')q' + g(q) = tal
    
    % Variaveis
    syms q1 q2 q3 q4 q5 q6
    q1 = tH;
    q2 = th2;
    q3 = th3;
    q4 = th4;
    q5 = th5;
    q6 = th6;
    q = [q1,q2,q3,q4,q5,q6];
    
   syms tH_dot th2_dot th3_dot th4_dot th5_dot th6_dot
   
    q1_dot = tH_dot;
    q2_dot = th2_dot;
    q3_dot = th3_dot;
    q4_dot = th4_dot;
    q5_dot = th5_dot;
    q6_dot = th6_dot;
    
    q_dot = [q1_dot;q2_dot;q3_dot;q4_dot;q5_dot;q6_dot];
    
     %Encontro da Aceleração
    syms tH_dot2 th2_dot2 th3_dot2 th4_dot2 th5_dot2 th6_dot2
    
    q1_dot2 = tH_dot2;
    q2_dot2 = th2_dot2;
    q3_dot2 = th3_dot2;
    q4_dot2 = th4_dot2;
    q5_dot2 = th5_dot2;
    q6_dot2 = th6_dot2;

    %Valores I hipoteticos
    syms Ixx1 Iyy1 Izz1
    syms Ixx2 Iyy6 Izz2
    syms Ixx3 Iyy5 Izz3
    syms Ixx4 Iyy4 Izz4
    syms Ixx5 Iyy3 Izz5
    syms Ixx6 Iyy2 Izz6
    
    %Massa elos
    syms m1 m2 m3 m4 m5 m6
    
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
      
    I5 = [Ixx5  0    0;
          0    Iyy5  0;
          0     0    Izz5];
      
    I6 = [Ixx6  0    0;
          0    Iyy6  0;
          0     0    Izz6];
      
 
    
     
      
    %% Calculo da Equação Dinamica
    
   %%%%%%%%%%%%%%%%% Encontro da matriz J Dinamica %%%%%%%%%%%%%%%%% 
    %Colocando o J no formato do exercicio
    %%J1
    J1v = cross(z0,(o1-o0));
    J1w = z0;
    J1vd = [J1v,0,0,0,0,0];
    J1wd = [J1w,o0,o0,o0,o0,o0];%se simplificar da erro
    %%J2
    J1v = cross(z0,(o2-o0));
    J2v = cross(z1,(o2-o1));
    J1w = z0;
    J2w = z1;
    J2vd = [J1v,J2v,0,0,0,0];
    J2wd = [J1w,J2w,0,0,0,0];
    J2vd = simplify(J2vd);
    J2wd = simplify(J2wd);
    %%J3
    J1v = cross(z0,(o3-o0));
    J2v = cross(z1,(o3-o1));
    J3v = cross(z2,(o3-o2));
    J1w = z0;
    J2w = z1;
    J3w = z2;
    J3vd = [J1v,J2v,J3v,0,0,0];
    J3wd = [J1w,J2w,J3w,0,0,0];
    J3vd = simplify(J3vd);
    J3wd = simplify(J3wd);
    %%J4
    J1v = cross(z0,(o4-o0));
    J2v = cross(z1,(o4-o1));
    J3v = cross(z2,(o4-o2));
    J4v = cross(z3,(o4-o3));
    J1w = z0;
    J2w = z1;
    J3w = z2;
    J4w = z3;
    J4vd = [J1v,J2v,J3v,J4v,0,0];
    J4wd = [J1w,J2w,J3w,J4w,0,0];
    J4vd = simplify(J4vd);
    J4wd = simplify(J4wd);
    %%J5
    J1v = cross(z0,(o5-o0));
    J2v = cross(z1,(o5-o1));
    J3v = cross(z2,(o5-o2));
    J4v = cross(z3,(o5-o3));
    J5v = cross(z4,(o5-o4));
    J1w = z0;
    J2w = z1;
    J3w = z2;
    J4w = z3;
    J5w = z4;
    J5vd = [J1v,J2v,J3v,J4v,J5v,0];
    J5wd = [J1w,J2w,J3w,J4w,J5w,0];
    J5vd = simplify(J5vd);
    J5wd = simplify(J5wd);
    %%J6
    J1v = cross(z0,(o6-o0));
    J2v = cross(z1,(o6-o1));
    J3v = cross(z2,(o6-o2));
    J4v = cross(z3,(o6-o3));
    J5v = cross(z4,(o6-o4));
    J6v = cross(z5,(o6-o5));
    J1w = z0;
    J2w = z1;
    J3w = z2;
    J4w = z3;
    J5w = z4;
    J6w = z5;
    J6vd = [J1v,J2v,J3v,J4v,J5v,J6v];
    J6wd = [J1w,J2w,J3w,J4w,J5w,J6w];
    J6vd = simplify(J6vd);
    J6wd = simplify(J6wd);
    
    % Calculo da Matriz D
    
    %D = m[Jv]'[Jv]+[Jw]'[R][I][R]'[Jw]
    
    D1 = m1*(transpose(J1vd))*J1vd + transpose(J1wd)*(R1*I1*transpose(R1))*J1wd;
    D1 = expand(D1);
    D1 = simplify(D1);
    D2 = m2*(transpose(J2vd))*J2vd + transpose(J2wd)*(R2*I2*transpose(R2))*J2wd;
    D2 =simplify(D2);
    D3 = m3*(transpose(J3vd))*J3vd + transpose(J3wd)*(R3*I3*transpose(R3))*J3wd;
    D3 = simplify(D3);
    D4 = m4*(transpose(J4vd))*J4vd + transpose(J4wd)*(R4*I4*transpose(R4))*J4wd;
    D4 = simplify(D4);
    D5 = m5*(transpose(J5vd))*J5vd + transpose(J5wd)*(R5*I5*transpose(R5))*J5wd;
    D5 = simplify(D5);
    D6 = m6*(transpose(J6vd))*J6vd + transpose(J6wd)*(R6*I6*transpose(R6))*J6wd;
    D6 = simplify(D6);
    D = D1+D2+D3+D4+D5+D6;
    D = simplify(D);
    %Calculo da Matriz C
    %P=diff(f,x);
    %subs(P,{x,y},{1.5,2});
    
    C = zeros(6,6,6,'sym');
    syms meio
    for i=1:6
    for j=1:6
    for k=1:6
        
        %meio = 0.5
        C(i,j,k) = 0.5*diff(D(k,j),q(i))+ diff(D(k,i),q(j)) - diff(D(i,j),q(k));
        
    end
    end
    end
    
    C1 = [C(1,1,1) C(1,2,1) C(1,3,1) C(1,4,1) C(1,5,1) C(1,6,1);
          C(1,1,2) C(1,2,2) C(1,3,2) C(1,4,2) C(1,5,2) C(1,6,2);
          C(1,1,3) C(1,2,3) C(1,3,3) C(1,4,3) C(1,5,3) C(1,6,3);
          C(1,1,4) C(1,2,4) C(1,3,4) C(1,4,4) C(1,5,4) C(1,6,4);
          C(1,1,5) C(1,2,5) C(1,3,5) C(1,4,5) C(1,5,5) C(1,6,5);
          C(1,1,6) C(1,2,6) C(1,3,6) C(1,4,6) C(1,5,6) C(1,6,6);] ;
    C1 = simplify(C1);
      
    C2 =[C(2,1,1) C(2,2,1) C(2,3,1) C(2,4,1) C(2,5,1) C(2,6,1);
          C(2,1,2) C(2,2,2) C(2,3,2) C(2,4,2) C(2,5,2) C(2,6,2);
          C(2,1,3) C(2,2,3) C(2,3,3) C(2,4,3) C(2,5,3) C(2,6,3);
          C(2,1,4) C(2,2,4) C(2,3,4) C(2,4,4) C(2,5,4) C(2,6,4);
          C(2,1,5) C(2,2,5) C(2,3,5) C(2,4,5) C(2,5,5) C(2,6,5);
          C(2,1,6) C(2,2,6) C(2,3,6) C(2,4,6) C(2,5,6) C(2,6,6)] ;
    C2 = simplify(C2);
    
    C3 = [C(3,1,1) C(3,2,1) C(3,3,1) C(3,4,1) C(3,5,1) C(3,6,1);
          C(3,1,2) C(3,2,2) C(3,3,2) C(3,4,2) C(3,5,2) C(3,6,2);
          C(3,1,3) C(3,2,3) C(3,3,3) C(3,4,3) C(3,5,3) C(3,6,3);
          C(3,1,4) C(3,2,4) C(3,3,4) C(3,4,4) C(3,5,4) C(3,6,4);
          C(3,1,5) C(3,2,5) C(3,3,5) C(3,4,5) C(3,5,5) C(3,6,5);
          C(3,1,6) C(3,2,6) C(3,3,6) C(3,4,6) C(3,5,6) C(3,6,6)] ;
     C3 = simplify(C3);
      
     C4 =[C(4,1,1) C(4,2,1) C(4,3,1) C(4,4,1) C(4,5,1) C(4,6,1);
          C(4,1,2) C(4,2,2) C(4,3,2) C(4,4,2) C(4,5,2) C(4,6,2);
          C(4,1,3) C(4,2,3) C(4,3,3) C(4,4,3) C(4,5,3) C(4,6,3);
          C(4,1,4) C(4,2,4) C(4,3,4) C(4,4,4) C(4,5,4) C(4,6,4);
          C(4,1,5) C(4,2,5) C(4,3,5) C(4,4,5) C(4,5,5) C(4,6,5);
          C(4,1,6) C(4,2,6) C(4,3,6) C(4,4,6) C(4,5,6) C(4,6,6)] ;
    C4 = simplify(C4);
    
    C5 = [C(5,1,1) C(5,2,1) C(5,3,1) C(5,4,1) C(5,5,1) C(5,6,1);
          C(5,1,2) C(5,2,2) C(5,3,2) C(5,4,2) C(5,5,2) C(5,6,2);
          C(5,1,3) C(5,2,3) C(5,3,3) C(5,4,3) C(5,5,3) C(5,6,3);
          C(5,1,4) C(5,2,4) C(5,3,4) C(5,4,4) C(5,5,4) C(5,6,4);
          C(5,1,5) C(5,2,5) C(5,3,5) C(5,4,5) C(5,5,5) C(5,6,5);
          C(5,1,6) C(5,2,6) C(5,3,6) C(5,4,6) C(5,5,6) C(5,6,6)] ;
    C5 = simplify(C5);
      
    C6 = [C(6,1,1) C(6,2,1) C(6,3,1) C(6,4,1) C(6,5,1) C(6,6,1);
          C(6,1,2) C(6,2,2) C(6,3,2) C(6,4,2) C(6,5,2) C(6,6,2);
          C(6,1,3) C(6,2,3) C(6,3,3) C(6,4,3) C(6,5,3) C(6,6,3);
          C(6,1,4) C(6,2,4) C(6,3,4) C(6,4,4) C(6,5,4) C(6,6,4);
          C(6,1,5) C(6,2,5) C(6,3,5) C(6,4,5) C(6,5,5) C(6,6,5);
          C(6,1,6) C(6,2,6) C(6,3,6) C(6,4,6) C(6,5,6) C(6,6,6)] ;
    C6 = simplify(C6);
    
     C = C1*q1_dot + C2*q2_dot + C3*q3_dot + C4*q4_dot + C5*q5_dot + C6*q6_dot;
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
     P5=  H_05(3,4)*m5*g;
     P6=  H_06(3,4)*m6*g;    
     P = P1+P2+P3+P4+P5+P6;
     P = simplify(P);
     
     %Encontro da Matriz g(q)
    g1 = diff(P,q(1));
    g2 = diff(P,q(2));
    g3 = diff(P,q(3));
    g4 = diff(P,q(4));
    g5 = diff(P,q(5));
    g6 = diff(P,q(6));
    
    G = [g1;g2;g3;g4;g5;g6];
    
    %Tals Simbolicos-> Substituir por valores Reais
    syms Tal1 Tal2 Tal3 Tal4 Tal5 Tal6
    Tal = [Tal1;Tal2;Tal3;Tal4;Tal5;Tal6];
    
    q_dot2 = [q1_dot2;q2_dot2;q3_dot2;q4_dot2;q5_dot2;q6_dot2];

    
    Tau = D*q_dot2+C*q_dot+G;
   
    
    
    %Equação Geral para encontrar a aceleração
    %q_dot2 = D\(Tal-C*q_dot-g);