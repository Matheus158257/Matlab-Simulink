function [q_next, qp_next] = torque_dynamics(q, qp, tal)

G = [0
   0
 -304.11
   0];

C = [0, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, 0];
    
Dinv = [1/116,   0,   0, 0 ; 0, 1/101,   0, 0;  0,   0, 1/31, 0;   0,    0,    0, 20/3];

delta_t = 0.1;

q_next = q+qp*delta_t;

qpp_next = Dinv*(tal-C*qp-G);

qp_next = qp+qpp_next*delta_t;


end