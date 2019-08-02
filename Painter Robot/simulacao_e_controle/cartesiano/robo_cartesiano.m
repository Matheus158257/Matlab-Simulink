%clear all;
import ETS3.*

teta = -pi/2;
base = [cos(teta)   0   sin(teta)   0
        0  1 0 0
        -sin(teta) 0 cos(teta) 0
        0   0   0   1
        ];

theta1 = 0;
a1 = 0;
alpha1 = pi/2;
junta_1 = Prismatic('theta', theta1,  'a', a1, 'alpha', alpha1);


 
theta2 = pi/2;
a2 = 0;
alpha2 = -pi/2;
junta_2 = Prismatic('theta', theta2,  'a', a2, 'alpha', alpha2);
 

theta3 = 0;
a3 = 0;
alpha3 = pi/2;
junta_3 = Prismatic('theta', theta3,  'a', a3, 'alpha', alpha3);


d4 = 0;
a4 = 0;
alpha4 = -pi/2;
junta_4 = Revolute('d', d4,  'a', a4, 'alpha', alpha4);



Lmax = 5;
Hmax = 2;
DepthMin = 0;
DepthMax = 1;
junta_1.qlim = [0 DepthMax];
junta_2.qlim = [0 Lmax];
junta_3.qlim = [0 Hmax];
junta_4.qlim = [0 2*pi];



teach = 0;
print_axis = 0;

robot = SerialLink('base', base, [junta_1, junta_2, junta_3, junta_4], 'name', 'PPPR');
W = [-4.5, 3, -5, 3, -6, 3];

if teach == 1
    robot.teach([0.5 2.5 1 0], 'workspace', W,  'jointdiam', 0.1, 'basewidth', 3, 'nowrist')
    return
end

if print_axis == 1
    robot.plot([0.5 2.5 1 0], 'workspace', W,  'jointdiam', 0.1, 'basewidth', 3, 'nowrist')
    hold on
    [T,A]  = robot.fkine([0.5 2.5 1 0]);
    trplot(base, 'length', 3, 'thick', 3,'width', 1.5, 'arrow', 'rgb', 'frame', "0")

    for i=1:4
      axis_dim = [1.5, 2, 2.5, 4]; 
      trplot(A(i), 'length', axis_dim(i), 'thick', 3,'width', 1.5, 'arrow', 'rgb', 'frame', num2str(i))
    end
end

L1 = 2.5;
L2 = 4;
H1 = 0.5;
H2 = 1;

W = [-4.5, 3, -5, 3, -3, 3];
%%%%%%%%%%%%%%   x0                 xf                  v_x     x_dur   y0          yf              v_y     y_duration
points_data_0 = [0,                 L2,                 0.4,    10.05,  0,          0.2*H2,         0.4,    0.55 %x0 a x2
                 L2,                0,                  0.4,    10.05,  0.2*H2,     0.4*H2,         0.4,    0.55 %x2 a x4
                 0,                 L2,                 0.4,    10.05,  0.4*H2,     0.6*H2,         0.4,    0.55 %x4 a x6
                 L2,                0,                  0.4,    10.05,  0.6*H2,     0.8*H2,         0.4,    0.55 %x6 a x8
                 0,                 L2,                 0.4,    10.05,  0.8*H2,     1.0*H2,         0.4,    0.55 %x8 a x10
                 L2,                0,                  0.4     10.05,  1.0*H2,     H2+0.33*H1,     0.4,    0.4668 %x8 a x10
                 0,                 (L1+L2)/2,          0.4     8.175,  H2+0.33*H1, H2+0.66*H1,     0.4,    0.4668 %x8 a x10
                 (L1+L2)/2,         ((L2+L1)/2)-L1,     0.4,    8.175,  H2+0.66*H1, H2+H1,          0.4,    0.4668 %x8 a x10
                 ((L2+L1)/2)-L1,    ((L2+L1)/2),        0.4,    8.175,  H2+H1,      0,              0.4,    3.8    %x8 a x10
                 ((L2+L1)/2),       0,                  0.4,    8.175,  0,          0,              0.4,    0.4668 %x8 a x10
                 
                 
                 ];

animation = [];
for line=1:size(points_data_0,1)
    data = points_data_0(line,:);
    animation_x = plan_x(data(1), data(2), data(3), data(4), data(5));
    animation_y = plan_y(data(5), data(6), data(7), data(8), data(2));
    animation = [animation; animation_x; animation_y];
end


t = (0:0.1:0.1*length(animation)-0.1)';
d1 = animation(:,1);
d1 = timeseries(d1,t);

d2 = animation(:,2);
d2 = timeseries(d2,t);


d3 = animation(:,3);
d3 = timeseries(d3,t);

theta4 = animation(:,4);
theta4 = timeseries(theta4,t);

% descomentar para ver a simulacao
% robot.plot(animation, 'delay', 0.1, 'workspace', W, 'jointdiam', 0.1);


time = 0:0.1:(length(animation)/10)-0.1;
subplot(4,1,1)
hold on
plot(time, animation(:,1))
xlabel('Tempo [s]')
ylabel('D1 [m]')

subplot(4,1,2)
hold on
plot(time, animation(:,2))
xlabel('Tempo [s]')
ylabel('D2 [m]')

subplot(4,1,3)
hold on
plot(time, animation(:,3))
xlabel('Tempo [s]')
ylabel('D3 [m]')

subplot(4,1,4)
hold on
plot(time, animation(:,4))
xlabel('Tempo [s]')
ylabel('Theta4 [rad]')

sim('control.slx', 104)



%%%%%%%%% Controle
    figure 
    subplot(4,1,1)
    plot(e1)
    title('Erro d1')
    ylabel('Erro d1 [m]')
    
     subplot(4,1,2)
    plot(e2)
    title('Erro d2')
    ylabel('Erro d2 [m]')
    
    subplot(4,1,3)
    plot(e3)
    title('Erro d3')
    ylabel('Erro d3 [m]')
    
    subplot(4,1,4)
    plot(e4)
    title('Erro theta4')
    ylabel('Erro theta4 [rad]')
    
    figure
    
    subplot(4,1,1)
    plot(f1)
    title('Esforço d1')
    ylabel('Esforço d1 [N]')
    
     subplot(4,1,2)
    plot(f2)
    title('Esforço d2')
    ylabel('Esforço d2 [N]')
    
    subplot(4,1,3)
    plot(f3)
    title('Esforço d3')
    ylabel('Esforço d3 [N]')
    
    subplot(4,1,4)
    plot(t4)
    title('Esforço theta4')
    ylabel('Esforço theta4 [N*m]')
