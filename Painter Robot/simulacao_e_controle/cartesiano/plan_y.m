function animation_y = plan_y(y0, yf, v_y, y_duration, const_x)



H1 = 0.5;
H2 = 1;

y0_real = H1+H2-y0;
yf_real = H1+H2-yf;

if y0_real>yf_real
    v_y = -v_y;
end

if y0_real == yf_real
    animation_y = [0, const_x, y0_real, deg2rad(270)];
    return
end

y = trajetoria(y0_real, yf_real, v_y, y_duration);

zeros_ar_y = zeros(length(y), 1);

ones_ar_y = ones(length(y), 1);
animation_y = [zeros_ar_y, ones(length(y), 1)*const_x, y, ones_ar_y*deg2rad(270)];


end