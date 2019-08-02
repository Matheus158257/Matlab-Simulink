%%Singularidades

J = [J1,J2,J3,J4];
% J = J(1:4,1:4);

% J = J([1,2,5,6],:);
 
J11 = J([1,2],[1,2]);
 
J12 = J([1,2],[3,4]);
 
J21 = J([3,4],[1,2]);
 
J22 = J([3,4],[3,4]);
 
%  simplify(det(J11))
 if det(J11)~=0
%  [J11_sing_theta1, J11_sing_theta2, J11_sing_theta3, J11_sing_theta4, ...
%      J11_sing_theta5, J11_sing_theta6] 
 S11 = solve (simplify(det(J11))==0, d1, d2, d3, theta4);

SingularitiesJ11_PPPR = [eval(S11.d1), eval(S11.d2), eval(S11.d3), eval(S11.theta4)];

 end
 
%  simplify(det(J12))
 if det(J12)~=0
%   [J12_sing_theta1, J12_sing_theta2, J12_sing_theta3, J12_sing_theta4, ...
%      J12_sing_theta5, J12_sing_theta6] 
 S12 = solve (simplify(det(J12))==0,d1, d2, d3, theta4);

SingularitiesJ12_PPPR = [eval(S12.d1), eval(S12.d2), eval(S12.d3), eval(S12.theta4)];

 end
 
%  simplify(det(J21))
 if det(J21)~=0
% [J21_sing_theta1, J21_sing_theta2, J21_sing_theta3, J21_sing_theta4, ...
%      J21_sing_theta5, J21_sing_theta6] 
 S21 = solve (simplify(det(J21))==0, d1, d2, d3, theta4);

SingularitiesJ21_PPPR = [eval(S21.d1), eval(S21.d2), eval(S21.d3),eval(S21.theta4)];
 end
 
%  simplify(det(J22))
 if det(J22)~=0
% [J22_sing_theta1, J22_sing_theta2, J22_sing_theta3, J22_sing_theta4, ...
%      J22_sing_theta5, J22_sing_theta6] 
 S22 = solve (simplify(det(J22))==0, d1, d2, d3, theta4);

SingularitiesJ22_PPPR = [eval(S22.d1), eval(S22.d2), eval(S22.d3),eval(S22.theta4)];
 end

 %%