function dz = eng_mount(t, z, eng, M, C, K)

dz = z;
dz(1:7) = z(8:14);

T = [0;0;0;0;eng.max_torque*sin((eng.idle_speed)*pi/15*t);0;0];       % Exerted torque by the crankshaft

dz(8:14) = M \ ( - K*z(1:7) - C*z(8:14) + T);