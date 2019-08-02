 %% Singularidades

J = [J1,J2,J3,J4,J5,J6];
 
J11 = [J1v, J2v, J3v];
 
J12 = [J4v, J5v, J6v];
 
J21 = [J1w, J2w, J3w];
 
J22 = [J4w, J5w, J6w];
 
%  simplify(det(J11))
 if det(J11)~=0
%  [J11_sing_tH, J11_sing_th2, J11_sing_th3, J11_sing_th4, ...
%      J11_sing_th5, J11_sing_th6] 
 S11 = solve (simplify(det(J11))==0, ...
    tH, th2, th3, th4, th5, th6);

SingularitiesJ11_RRRRRR = [eval(S11.tH), eval(S11.th2), eval(S11.th3), ...
    eval(S11.th4), eval(S11.th5), eval(S11.th6)];

 end
 
%  simplify(det(J12))
 if det(J12)~=0
%   [J12_sing_tH, J12_sing_th2, J12_sing_th3, J12_sing_th4, ...
%      J12_sing_th5, J12_sing_th6] 
 S12 = solve (simplify(det(J12))==0, ...
    tH, th2, th3, th4, th5, th6);

SingularitiesJ12_RRRRRR = [eval(S12.tH), eval(S12.th2), eval(S12.th3), ...
    eval(S12.th4), eval(S12.th5), eval(S12.th6)];

 end
 
%  simplify(det(J21))
 if det(J21)~=0
% [J21_sing_tH, J21_sing_th2, J21_sing_th3, J21_sing_th4, ...
%      J21_sing_th5, J21_sing_th6] 
 S21 = solve (simplify(det(J21))==0, ...
    tH, th2, th3, th4, th5, th6);

SingularitiesJ21_RRRRRR = [eval(S21.tH), eval(S21.th2), eval(S21.th3), ...
    eval(S21.th4), eval(S21.th5), eval(S21.th6)];
 end
 
%  simplify(det(J22))
 if det(J22)~=0
% [J22_sing_tH, J22_sing_th2, J22_sing_th3, J22_sing_th4, ...
%      J22_sing_th5, J22_sing_th6] 
 S22 = solve (simplify(det(J22))==0, ...
    tH, th2, th3, th4, th5, th6);

SingularitiesJ22_RRRRRR = [eval(S22.tH), eval(S22.th2), eval(S22.th3), ...
    eval(S22.th4), eval(S22.th5), eval(S22.th6)];
 end
 
 %%