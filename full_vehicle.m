function dz = full_vehicle(t, z, eng, M, C, K)

dz = z;
dz(1:13) = z(14:26);

T = [zeros(7,1);0;0;0;0;eng.max_torque*sin((eng.idle_speed)*pi/15*t);0];       % Exerted torque by the crankshaft

dz(14:26) = M \ ( - K*z(1:13) - C*z(14:26) + T);