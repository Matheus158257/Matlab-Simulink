%% Calculo dos Esforços
% Rodar Trajetoria e Dinamica Primeiro

T1 = zeros(1,length(th1EQ_dot));
T2 = zeros(1,length(th1EQ_dot));
T3 = zeros(1,length(th1EQ_dot));
T4 = zeros(1,length(th1EQ_dot));
T5 = zeros(1,length(th1EQ_dot));
T6 = zeros(1,length(th1EQ_dot));

for m = 1:1:length(th1EQ_dot)
    T1(m)=eval(subs(Tau(1),[th1,th2,th3,th4,th5,th6,th1_dot,th2_dot,th3_dot,th4_dot,th5_dot,th6_dot,th1_dot2,th2_dot2,th3_dot2,th4_dot2,th5_dot2,th6_dot2],[animation(m,1),animation(m,2),animation(m,3),animation(m,4),animation(m,5),animation(m,6),th1EQ_dot(m),th2EQ_dot(m),th3EQ_dot(m),th4EQ_dot(m),th5EQ_dot(m),th6EQ_dot(m),th1EQ_dot2(m),th2EQ_dot2(m),th3EQ_dot2(m),th4EQ_dot2(m),th5EQ_dot2(m),th6EQ_dot2(m)]));
    T2(m)=eval(subs(Tau(2),[th1,th2,th3,th4,th5,th6,th1_dot,th2_dot,th3_dot,th4_dot,th5_dot,th6_dot,th1_dot2,th2_dot2,th3_dot2,th4_dot2,th5_dot2,th6_dot2],[animation(m,1),animation(m,2),animation(m,3),animation(m,4),animation(m,5),animation(m,6),th1EQ_dot(m),th2EQ_dot(m),th3EQ_dot(m),th4EQ_dot(m),th5EQ_dot(m),th6EQ_dot(m),th1EQ_dot2(m),th2EQ_dot2(m),th3EQ_dot2(m),th4EQ_dot2(m),th5EQ_dot2(m),th6EQ_dot2(m)]));
    T3(m)=eval(subs(Tau(3),[th1,th2,th3,th4,th5,th6,th1_dot,th2_dot,th3_dot,th4_dot,th5_dot,th6_dot,th1_dot2,th2_dot2,th3_dot2,th4_dot2,th5_dot2,th6_dot2],[animation(m,1),animation(m,2),animation(m,3),animation(m,4),animation(m,5),animation(m,6),th1EQ_dot(m),th2EQ_dot(m),th3EQ_dot(m),th4EQ_dot(m),th5EQ_dot(m),th6EQ_dot(m),th1EQ_dot2(m),th2EQ_dot2(m),th3EQ_dot2(m),th4EQ_dot2(m),th5EQ_dot2(m),th6EQ_dot2(m)]));
    T4(m)=eval(subs(Tau(4),[th1,th2,th3,th4,th5,th6,th1_dot,th2_dot,th3_dot,th4_dot,th5_dot,th6_dot,th1_dot2,th2_dot2,th3_dot2,th4_dot2,th5_dot2,th6_dot2],[animation(m,1),animation(m,2),animation(m,3),animation(m,4),animation(m,5),animation(m,6),th1EQ_dot(m),th2EQ_dot(m),th3EQ_dot(m),th4EQ_dot(m),th5EQ_dot(m),th6EQ_dot(m),th1EQ_dot2(m),th2EQ_dot2(m),th3EQ_dot2(m),th4EQ_dot2(m),th5EQ_dot2(m),th6EQ_dot2(m)]));
    T5(m)=eval(subs(Tau(5),[th1,th2,th3,th4,th5,th6,th1_dot,th2_dot,th3_dot,th4_dot,th5_dot,th6_dot,th1_dot2,th2_dot2,th3_dot2,th4_dot2,th5_dot2,th6_dot2],[animation(m,1),animation(m,2),animation(m,3),animation(m,4),animation(m,5),animation(m,6),th1EQ_dot(m),th2EQ_dot(m),th3EQ_dot(m),th4EQ_dot(m),th5EQ_dot(m),th6EQ_dot(m),th1EQ_dot2(m),th2EQ_dot2(m),th3EQ_dot2(m),th4EQ_dot2(m),th5EQ_dot2(m),th6EQ_dot2(m)]));
    T6(m)=eval(subs(Tau(6),[th1,th2,th3,th4,th5,th6,th1_dot,th2_dot,th3_dot,th4_dot,th5_dot,th6_dot,th1_dot2,th2_dot2,th3_dot2,th4_dot2,th5_dot2,th6_dot2],[animation(m,1),animation(m,2),animation(m,3),animation(m,4),animation(m,5),animation(m,6),th1EQ_dot(m),th2EQ_dot(m),th3EQ_dot(m),th4EQ_dot(m),th5EQ_dot(m),th6EQ_dot(m),th1EQ_dot2(m),th2EQ_dot2(m),th3EQ_dot2(m),th4EQ_dot2(m),th5EQ_dot2(m),th6EQ_dot2(m)]));
end

%% Plot Esforços
figure
subplot(6,1,1);
plot(time,T1)
title('T theta1')

subplot(6,1,2);
plot(time,T2)
title('T theta2')

subplot(6,1,3);
plot(time,T3)
title('T theta3')

subplot(6,1,4);
plot(time,T4)
title('T theta4')

subplot(6,1,5);
plot(time,T5)
title('T theta5')

subplot(6,1,6);
plot(time,T6)
title('T theta6')
