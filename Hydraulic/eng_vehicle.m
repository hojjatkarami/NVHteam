function dz = eng_vehicle(t, z, eng, M_v, C_v, K_v)

dz = z;
dz(1:14) = z(15:28);

T = [zeros(7,1);0;0;0;0;eng.max_torque*sin((eng.idle_speed)*pi/15*t);0;0];       % Exerted torque by the crankshaft

dz(15:28) = M_v \ ( - K_v*z(1:14) - C_v*z(15:28) + T);