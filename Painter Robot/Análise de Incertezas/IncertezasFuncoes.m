%% Análise de incertezas
clear all;

% Manipulador Articulado (RRRRRR)
syms theta1;
syms theta2;
syms theta3;
syms theta4;
syms theta5;
syms theta6;

a3 = 2;
a2 = 2;
d6 = 0.1;

X_art(theta1, theta2, theta3, theta4, theta5, theta6) = a2*cos(theta1)*cos(theta2)-d6*(sin(theta5)*(sin(theta1)*sin(theta4)-cos(theta4)*(cos(theta1)*sin(theta2)*sin(theta3)-cos(theta1)*cos(theta2)*cos(theta3))) + cos(theta5)*(cos(theta1)*cos(theta2)*sin(theta3)+cos(theta1)*cos(theta3)*sin(theta2))) + a3*cos(theta1)*cos(theta2)*cos(theta3)-a3*cos(theta1)*sin(theta2)*sin(theta3);
Y_art(theta1, theta2, theta3, theta4, theta5, theta6) = d6*(sin(theta5)*(cos(theta1)*sin(theta4)+cos(theta4)*(sin(theta1)*sin(theta2)*sin(theta3)-cos(theta2)*cos(theta3)*sin(theta1)))-cos(theta5)*(cos(theta2)*sin(theta1)*sin(theta3)+cos(theta3)*sin(theta1)*sin(theta2))) +a2*cos(theta2)*sin(theta1)+a3*cos(theta2)*cos(theta3)*sin(theta1)-a3*sin(theta1)*sin(theta2)*sin(theta3);
Z_art(theta1, theta2, theta3, theta4, theta5, theta6) = - a2*sin(theta2) - d6*(cos(theta5)*(cos(theta2)*cos(theta3) - sin(theta2)*sin(theta3)) - cos(theta4)*sin(theta5)*(cos(theta2)*sin(theta3) + cos(theta3)*sin(theta2))) - a3*cos(theta2)*sin(theta3) - a3*cos(theta3)*sin(theta2);

X_art(theta1, theta2, theta3, theta4, theta5, theta6) = simplify(X_art);
Y_art(theta1, theta2, theta3, theta4, theta5, theta6) = simplify(Y_art);
Z_art(theta1, theta2, theta3, theta4, theta5, theta6) = simplify(Z_art);

% Cálculo de sensibilidades
% Relativas a X
Theta1 = simplify(diff(X_art, theta1));
Theta2 = simplify(diff(X_art, theta2));
Theta3 = simplify(diff(X_art, theta3));
Theta4 = simplify(diff(X_art, theta4));
Theta5 = simplify(diff(X_art, theta5));
Theta6 = simplify(diff(X_art, theta6));

% Relativas a Y
Theta7 = simplify(diff(Y_art, theta1));
Theta8 = simplify(diff(Y_art, theta2));
Theta9 = simplify(diff(Y_art, theta3));
Theta10 = simplify(diff(Y_art, theta4));
Theta11 = simplify(diff(Y_art, theta5));
Theta12 = simplify(diff(Y_art, theta6));

% Relativas a Z
Theta13 = simplify(diff(Z_art, theta1));
Theta14 = simplify(diff(Z_art, theta2));
Theta15 = simplify(diff(Z_art, theta3));
Theta16 = simplify(diff(Z_art, theta4));
Theta17 = simplify(diff(Z_art, theta5));
Theta18 = simplify(diff(Z_art, theta6));

Theta_art = [Theta1, Theta2, Theta3, Theta4, Theta5, Theta6;
         Theta7, Theta8, Theta9, Theta10, Theta11, Theta12;
         Theta13, Theta14, Theta15, Theta16, Theta17, Theta18];
     
% Manipulador Cartesiano (PPPR)
syms d1;
syms d2;
syms d3;
syms theta4;

X_cart(d1,d2,d3,theta4) = -d3;
Y_cart(d1,d2,d3,theta4) = -d2;
Z_cart(d1,d2,d3,theta4) = d1;

% Cálculo de sensibilidades
% Relativas a X
Theta19 = simplify(diff(X_cart, d1));
Theta20 = simplify(diff(X_cart, d2));
Theta21 = simplify(diff(X_cart, d3));
Theta22 = simplify(diff(X_cart, theta4));

% Relativas a Y
Theta23 = simplify(diff(Y_cart, d1));
Theta24 = simplify(diff(Y_cart, d2));
Theta25 = simplify(diff(Y_cart, d3));
Theta26 = simplify(diff(Y_cart, theta4));

% Relativas a Z
Theta27 = simplify(diff(Z_cart, d1));
Theta28 = simplify(diff(Z_cart, d2));
Theta29 = simplify(diff(Z_cart, d3));
Theta30 = simplify(diff(Z_cart, theta4));

Theta_cart = [Theta19, Theta20, Theta21, Theta22;
              Theta23, Theta24, Theta25, Theta26;
              Theta27, Theta28, Theta29, Theta30];
          
%% Cálculo das incertezas

% Incertezas de posicionamento de cada elo
ut = [1*pi/180 2*pi/180 1*pi/180 2*pi/180 1*pi/180 2*pi/180];

ud = [0.001, 0.001, 0.002, 2*pi/180];

% Posição 
L2 = 4;
H2 = 1;

syms xc yc zc;
% xc = L2;
% yc = H2;
% zc = 0;

% Manipulador RRRRRR

% Matriz R
r11 = sin(theta6)*(cos(theta4)*sin(theta1) + sin(theta4)*(cos(theta1)*sin(theta2)*sin(theta3) - cos(theta1)*cos(theta2)*cos(theta3))) + cos(theta6)*(cos(theta5)*(sin(theta1)*sin(theta4) - cos(theta4)*(cos(theta1)*sin(theta2)*sin(theta3) - cos(theta1)*cos(theta2)*cos(theta3))) - sin(theta5)*(cos(theta1)*cos(theta2)*sin(theta3) + cos(theta1)*cos(theta3)*sin(theta2)));
r12 = cos(theta6)*(cos(theta4)*sin(theta1) + sin(theta4)*(cos(theta1)*sin(theta2)*sin(theta3) - cos(theta2)*cos(theta2)*cos(theta3))) - sin(theta6)*(cos(theta5)*(sin(theta1)*sin(theta4) - cos(theta4)*(cos(theta1)*sin(theta2)*sin(theta3) - cos(theta1)*cos(theta2)*cos(theta3))) - sin(theta5)*(cos(theta1)*cos(theta2)*sin(theta3) + cos(theta1)*cos(theta3)*sin(theta2)));
r13 = - sin(theta5)*(sin(theta1)*sin(theta4) - cos(theta4)*(cos(theta1)*sin(theta2)*sin(theta3) - cos(theta1)*cos(theta2)*cos(theta3))) - cos(theta5)*(cos(theta1)*cos(theta2)*sin(theta3) + cos(theta2)*cos(theta3)*sin(theta2));
r21 = - sin(theta6)*(cos(theta1)*cos(theta4) - sin(theta4)*(sin(theta1)*sin(theta2)*sin(theta3) - cos(theta2)*cos(theta3)*sin(theta1))) - cos(theta6)*(cos(theta5)*(cos(theta1)*sin(theta4) + cos(theta4)*(sin(theta1)*sin(theta2)*sin(theta3) - cos(theta2)*cos(theta3)*sin(theta1))) + sin(theta5)*(cos(theta2)*sin(theta1)*sin(theta3) + cos(theta3)*sin(theta1)*sin(theta2)));
r22 = sin(theta6)*(cos(theta5)*(cos(theta1)*sin(theta4) + cos(theta4)*(sin(theta1)*sin(theta2)*sin(theta3) - cos(theta2)*cos(theta3)*sin(theta1))) + sin(theta5)*(cos(theta2)*sin(theta1)*sin(theta3) + cos(theta3)*sin(theta1)*sin(theta2))) - cos(theta6)*(cos(theta1)*cos(theta4) - sin(theta4)*(sin(theta1)*sin(theta2)*sin(theta3) - cos(theta2)*cos(theta3)*sin(theta1)));
r23 = sin(theta5)*(cos(theta1)*sin(theta4) + cos(theta4)*(sin(theta1)*sin(theta2)*sin(theta3) - cos(theta2)*cos(theta3)*sin(theta1))) - cos(theta5)*(cos(theta2)*sin(theta1)*sin(theta3) + cos(theta3)*sin(theta1)*sin(theta2));
r31 = sin(theta2 + theta3)*sin(theta4)*sin(theta6) - cos(theta6)*(cos(theta2 + theta3)*sin(theta5) + sin(theta2 + theta3)*cos(theta4)*cos(theta5));
r32 = sin(theta6)*(cos(theta2 + theta3)*sin(theta5) + sin(theta2 + theta3)*cos(theta4)*cos(theta5)) + sin(theta2 + theta3)*cos(theta6)*sin(theta4);
r33 = sin(theta2 + theta3)*cos(theta4)*sin(theta5) - cos(theta2 + theta3)*cos(theta5);

q1(xc, yc, zc) = atan2(xc, yc);
q2(xc, yc, zc, theta3) = atan2(sqrt(xc^2 + yc^2), zc) - atan2(a2 + a3*cos(theta3), a3*sin(theta3));
D = (xc^2 + yc^2 + zc^2 - a2^2 - a3^2)/(2*a2*a3);
q3(xc, yc, zc) = atan2(D, sqrt(1 - D^2));
q4(xc, yc, zc, theta1, theta2, theta3) = atan2(cos(theta1)*cos(theta2 + theta3)*r13 + sin(theta1)*cos(theta2 + theta3)*r23 + sin(theta2 + theta3)*r33, -cos(theta1)*cos(theta2 + theta3)*r13 - sin(theta1)*cos(theta2 + theta3)*r23 + cos(theta2 + theta3)*r33);
q5(xc, yc, zc, theta1, theta2, theta3) = atan2(sin(theta1)*r13 - cos(theta1)*r23, sqrt(1 - (sin(theta1)*r13 - cos(theta1)*r23)^2));
q6(xc, yc, zc, theta1, theta2, theta3) = atan2(-sin(theta1)*r11 + cos(theta1)*r21, sin(theta1)*r12 - cos(theta1)*r22);

% Posição estudada
th1 = q1(L2, H2, 0);
th3 = q3(L2, H2, 0);
th2 = q2(L2, H2, 0, th3);
th4(theta4, theta5, theta6) = q4(L2, H2, 0, th1, th2, th3);
th5(theta4, theta5, theta6) = q5(L2, H2, 0, th1, th2, th3);
th6(theta4, theta5, theta6) = q6(L2, H2, 0, th1, th2, th3);

eq4 = theta4 == th4;
eq5 = theta5 == th5;
eq6 = theta6 == th6;

[solT4, solT5, solT6] = solve([eq4, eq5, eq6], [theta4, theta5, theta6]);

th1 = double(th1);
th2 = double(th2);
th3 = double(th3);
th4 = double(solT4);
th5 = double(solT5);
th6 = double(solT6);

th = [th1, th2, th3, th4, th5, th6];

sensibilidades_art = double(Theta_art(th1, th2, th3, th4, th5, th6));
U_art = [0 0 0];

% Cálculo da incerteza
for i = 1:1:3
    U_art(i) = 0;
    for j = 1:1:6
        U_art(i) = U_art(i) + (sensibilidades_art(i,j)*ut(j))^2;
    end
    U_art(i) = sqrt(U_art(i));
end

% Manipulador PPPR

d1 = 0;
d2 = -H2;
d3 = -L2;
theta4 = 0;

sensibilidades_cart = double(Theta_cart(d1, d2, d3, theta4));
U_cart = [0 0 0];

% Cálculo da incerteza
for i = 1:1:3
    U_cart(i) = 0;
    for j = 1:1:4
        U_cart(i) = U_cart(i) + (sensibilidades_cart(i,j)*ud(j))^2;
    end
    U_cart(i) = sqrt(U_cart(i));
end
