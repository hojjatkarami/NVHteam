function dz = eng_mount(t, z, eng, M, C, K)

dz = z;
dz(1:7) = z(8:14);

T1 = eng.max_torque(1);
T2 = 0;
T4 = 0;
T1_2 = 0;
T1_4 = 0;

w = eng.idle_speed(1);
Torque_mag = T1*sin(w*t) + T2*sin(2*w*t) + T4*sin(4*w*t) + T1_2*sin(1/2*w*t) + T1_4*sin(1/4*w*t);

Torque_Vec = [0;0;0;0;1;0;0] * Torque_mag;       % Exerted torque by the crankshaft

% T = [0;0;0;0;eng.torque*sin((eng.rpm)*pi/15*t);0];       % Exerted torque by the crankshaft


dz(8:14) = M \ ( - K*z(1:7) - C*z(8:14) + Torque_Vec);
