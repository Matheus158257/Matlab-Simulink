function animation_y = plan_y(y0, yf, v_y, y_duration)


if y0>yf
    v_y = -v_y;
end


animation_y = trajetoria(y0, yf, v_y, y_duration);


end