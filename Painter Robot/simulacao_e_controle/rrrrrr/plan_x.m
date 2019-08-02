function animation_x = plan_x(x0, xf, v_x, x_duration, const_y)

H1 = 0.5;
H2 = 1;

const_y = H1+H2-const_y;

if x0>xf
    v_x = -v_x;
end

x = trajetoria(x0, xf, v_x, x_duration);
zeros_ar_x = zeros(length(x), 1);
ones_ar_x = ones(length(x), 1);
animation_x = [zeros_ar_x, x, ones(length(x), 1)*const_y, ones_ar_x*deg2rad(270)];


end