%% Calculo dos Esforços
% Rodar Trajetoria e Dinamica Primeiro

T1 = zeros(1,length(d2_dot2V));
T2 = zeros(1,length(d2_dot2V));
T3 = zeros(1,length(d2_dot2V));
T4 = zeros(1,length(d2_dot2V));

for m = 1:1:length(d2_dot2V)
    T2(m)=eval(subs(Tau(2),d2_dot2,d2_dot2V(m)));
    T3(m)=eval(subs(Tau(3),d3_dot2,d3_dot2V(m)));
end

%% Plot Esforços
figure
subplot(2,1,1);
plot(tempV,T2)
title('T d2')

subplot(2,1,2);
plot(tempV,T3)
title('T d3')