
q = [0 0 0 0]';
qp = [0 0 0 0]';
tal = [0 0 -20 0]';

res = [];
for x = 0:0.1:10
    [q, qp] = torque_dynamics(q, qp, tal); %Dinv, C, G);
    res = [res ; double(q)'];
end
res
