clear all;
import ETS3.*

a1 = 0;
d1 = 0;
alpha1 = -pi/2;
junta_1 = Revolute('alpha', alpha1, 'a', a1, 'd', d1);

a2 = 2;
d2 = 0;
alpha2 = 0;
junta_2 = Revolute('alpha', alpha2, 'a', a2, 'd', d2);



a3 = 2;
d3 = 0;
alpha3 = -pi/2;
junta_3 = Revolute('alpha', alpha3, 'a', a3, 'd', d3);




a4 = 0;
d4 = 0; % d3 + d4
alpha4 = pi/2; % acho que seria 90
junta_4 = Revolute('alpha', alpha4, 'a', a4, 'd', d4);



a5 = 0;
d5 = 0;
alpha5 = -pi/2;
junta_5 = Revolute('alpha', alpha5, 'a', a5, 'd', d5);


a6 = 0;
d6 = 0.1;
alpha6 = 0;
junta_6 = Revolute('alpha', alpha6, 'a', a6, 'd', d6);

teach = 0;
print_axis = 0;

robot = SerialLink( [ junta_1, junta_2, junta_3, junta_4, junta_5, junta_6], 'name', 'RRRRRR');
W = [-4, 4, -1, 5, -8, 3];
if teach == 1
    robot.teach([0 0 0 0 0 0],'jointdiam', 0.1, 'workspace', W)
    return
end

if print_axis == 1
    robot.plot([0 0 0 0 0 0], 'workspace', W, 'jointdiam', 0.1, 'basewidth', 3, 'nowrist')
    hold on
    [T,A]  = robot.fkine([0 0 0 0 0 0]);
     for i=1:6
         axis_dim = [1.5, 1.5, 1.5, 3, 4.5, 3.7];
       trplot(A(i), 'length', axis_dim(i), 'thick', 3,'width', 1, 'arrow', 'rgb', 'frame', num2str(i))
     end
     return
end

L1 = 2.5;
L2 = 4;
H1 = 0.5;
H2 = 1;

%%%%%%%%%%%%%%  1-x0                2-xf                3-v_x   4-x_dur     5-z0        6-zf            7-v_z   8-z_duration
points_data_0 = [0,                 L2,                 0.4,    10.05,      0,          0.2*H2,         0.4,    0.55 %x0 a x2
                 L2,                0,                  0.4,    10.05,      0.2*H2,     0.4*H2,         0.4,    0.55 %x2 a x4
                 0,                 L2,                 0.4,    10.05,      0.4*H2,     0.6*H2,         0.4,    0.55 %x4 a x6
                 L2,                0,                  0.4,    10.05,      0.6*H2,     0.8*H2,         0.4,    0.55 %x6 a x8
                 0,                 L2,                 0.4,    10.05,      0.8*H2,     1.0*H2,         0.4,    0.55 %x8 a x10
                 L2,                0,                  0.4     10.05,      1.0*H2,     H2+0.33*H1,     0.4,    0.4668 %x8 a x10
                 0,                 (L1+L2)/2,          0.4     8.175,      H2+0.33*H1, H2+0.66*H1,     0.4,    0.4668 %x8 a x10
                 (L1+L2)/2,         ((L2+L1)/2)-L1,     0.4,    8.175,      H2+0.66*H1, H2+H1,          0.4,    0.4668 %x8 a x10
                 ((L2+L1)/2)-L1,    ((L2+L1)/2),        0.4,    8.175,      H2+H1,      0,              0.4,    3.8    %x8 a x10
                 ((L2+L1)/2),       0,                  0.4,    8.175,      0,          0,              0.4,    0.4668 %x8 a x10
                 ];




animation = [];
last_x = 0;
last_z = 0;

x_total = [];
y_total = [];
z_total = [];
theta1_total = [];
for line=1:size(points_data_0,1)
    data = points_data_0(line,:);
    
    points_traj_x = plan_segment(data(1), data(2), data(3), data(4));
    last_x = points_traj_x(end);
    
    
    planned_path_x_mov = [points_traj_x, zeros(length(points_traj_x), 1), ones(length(points_traj_x), 1)*last_z];
                
    points_traj_z = plan_segment(data(5), data(6), data(7), data(8));
    last_z = points_traj_z(end);
    
    planned_path_z_mov = [ones(length(points_traj_z), 1)*last_x, zeros(length(points_traj_z), 1), points_traj_z];
    
    planned = [planned_path_x_mov; planned_path_z_mov];
    
    x = planned(:,1) - 2 ;
    y = planned(:,2) + 1.5;
    z = planned(:,3);
    
    theta1 = atan2(y, x);
    D = (x.^2+y.^2+z.^2-a2^2-a3^2)/(2*a2*a3);  
    theta3 = atan2(-sqrt(1-D.^2), D);
    theta2 = atan2(z, sqrt(x.^2+y.^2))-atan2(a3*sin(theta3), a2+a3*cos(theta3));
    
    
    %theta4 =  -atan2( -sin(theta1).*sin(theta2+theta3), sin(theta1).*cos(theta2+theta3) ); zeros(length(theta1), 1); 
    theta5 = (-(pi/2)+theta2+theta3); %*ones(length(theta1), 1) ;
    
    %theta5 = -atan2(-sqrt(1-(-cos(theta1).^2)), -cos(theta1)); %*ones(length(theta1), 1);zeros(length(theta1), 1); %

    x_total = [x_total; x];
    y_total = [y_total; y];
    z_total = [z_total; z];
    theta1_total = [theta1_total; theta1];
    % Theta2
    animation = [animation; theta1, -theta2, -theta3, zeros(length(theta1), 1), theta5, zeros(length(theta1), 1)];
    %animation = [animation; theta1, -theta2, -theta3, theta5, theta4, zeros(length(theta1), 1)];
end

points = [x_total, y_total, z_total];


% descomentar para ver simulacao
%robot.teach(animation, 'delay', 0.1, 'workspace', W, 'jointdiam', 0.1);

time = 0:0.1:(length(animation)/10)-0.1;
subplot(3,1,1)
hold on
plot(time, animation(:,1))
xlabel('Tempo [s]')
ylabel('Theta1 [rad]')

subplot(3,1,2)
hold on
plot(time, animation(:,2))
xlabel('Tempo [s]')
ylabel('Theta2 [rad]')

subplot(3,1,3)
hold on
plot(time, animation(:,3))
xlabel('Tempo [s]')
ylabel('Theta3 [rad]')

figure
subplot(3,1,1)
hold on
plot(time, animation(:,4))
xlabel('Tempo [s]')
ylabel('Theta4 [rad]')

subplot(3,1,2)
hold on
plot(time, animation(:,5))
xlabel('Tempo [s]')
ylabel('Theta5 [rad]')

subplot(3,1,3)
hold on
plot(time, animation(:,6))
xlabel('Tempo [s]')
ylabel('Theta6 [rad]')