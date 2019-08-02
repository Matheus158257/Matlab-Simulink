function y = trajetoria(x0, xf, v_const, duration)

v = v_const;
tf = duration;
tb = (x0-xf+v*tf)/v;
a = v/tb;
step = 0.1;
t_0_tb = 0:step:tb;
t_tb_tf_minus_tb = tb:step:(tf-tb);
t_tf_minus_tb_tf = (tf-tb):step:tf;

x_0_tb = x0 + (a/2)*t_0_tb.^2;
x_tb_tf_minus_tb = (xf+x0-v*tf)/2 + v*t_tb_tf_minus_tb;
x_tf_minus_tb_tf = xf -(a*tf.^2)/2 + a*tf*t_tf_minus_tb_tf -(a*t_tf_minus_tb_tf.^2)/2;


y = [x_0_tb, x_tb_tf_minus_tb, x_tf_minus_tb_tf]';
end