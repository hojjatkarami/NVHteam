function dz = eng_mount(t, z, eng, M, C, K)

dz = z;
dz(1:6) = z(7:12);

T = [0;0;0;0;eng.max_torque(1)*sin((eng.idle_speed(1))*t);0];       % Exerted torque by the crankshaft

% T = [0;0;0;0;eng.torque*sin((eng.rpm)*pi/15*t);0];       % Exerted torque by the crankshaft

dz(7:12) = M \ ( - K*z(1:6) - C*z(7:12) + T);