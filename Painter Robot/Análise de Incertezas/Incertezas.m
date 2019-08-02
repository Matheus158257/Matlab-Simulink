%% Análise de incertezas
clear all;

% Manipulador Articulado (RRRRRR)
syms theta1 a1 d1 alpha1;
syms theta2 a2 d2 alpha2;
syms theta3 a3 d3 alpha3;
syms theta4 a4 d4 alpha4;
syms theta5 a5 d5 alpha5;
syms theta6 a6 d6 alpha6;
syms Theta;

X_art = a2*cos(theta1)*cos(theta2)-d6*(sin(theta5)*(sin(theta1)*sin(theta4)-cos(theta4)*(cos(theta1)*sin(theta2)*sin(theta3)-cos(theta1)*cos(theta2)*cos(theta3))) + cos(theta5)*(cos(theta1)*cos(theta2)*sin(theta3)+cos(theta1)*cos(theta3)*sin(theta2))) + a3*cos(theta1)*cos(theta2)*cos(theta3)-a3*cos(theta1)*sin(theta2)*sin(theta3);
Y_art = d6*(sin(theta5)*(cos(theta1)*sin(theta4)+cos(theta4)*(sin(theta1)*sin(theta2)*sin(theta3)-cos(theta2)*cos(theta3)*sin(theta1)))-cos(theta5)*(cos(theta2)*sin(theta1)*sin(theta3)+cos(theta3)*sin(theta1)*sin(theta2))) +a2*cos(theta2)*sin(theta1)+a3*cos(theta2)*cos(theta3)*sin(theta1)-a3*sin(theta1)*sin(theta2)*sin(theta3);
Z_art = - a2*sin(theta2) - d6*(cos(theta5)*(cos(theta2)*cos(theta3) - sin(theta2)*sin(theta3)) - cos(theta4)*sin(theta5)*(cos(theta2)*sin(theta3) + cos(theta3)*sin(theta2))) - a3*cos(theta2)*sin(theta3) - a3*cos(theta3)*sin(theta2);

X_art = simplify(X_art);
Y_art = simplify(Y_art);
Z_art = simplify(Z_art);

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
X_cart = -d3;
Y_cart = -d2;
Z_cart = d1;

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

