function F = TF_pure(x, eta, w, f, M)

r_1 = x(1:3);
r_2 = x(4:6);
r_3 = x(7:9);

o_1 = x(10:12);
o_2 = x(13:15);
o_3 = x(16:18);

k_l_1 = diag(x(19:21));
k_l_2 = diag(x(22:24));
k_l_3 = diag(x(25:27));

c_l_1 = eta*k_l_1;
c_l_2 = eta*k_l_1;
c_l_3 = eta*k_l_1;

% Position of the mounts
B_1 = [0 -r_1(3) r_1(2) ; r_1(3) 0 -r_1(1) ; -r_1(2) r_1(1) 0];
B_2 = [0 -r_2(3) r_2(2) ; r_2(3) 0 -r_2(1) ; -r_2(2) r_2(1) 0];
B_3 = [0 -r_3(3) r_3(2) ; r_3(3) 0 -r_3(1) ; -r_3(2) r_3(1) 0];

% Orientation of the mounts
A_1 = [cos(o_1(3))*cos(o_1(2)) -sin(o_1(3))*cos(o_1(1))+cos(o_1(3))*sin(o_1(2))*sin(o_1(1)) sin(o_1(3))*sin(o_1(1))+cos(o_1(3))*sin(o_1(2))*cos(o_1(1));
    sin(o_1(3))*cos(o_1(2)) cos(o_1(3))*cos(o_1(1))+sin(o_1(3))*sin(o_1(2))*sin(o_1(1)) -cos(o_1(3))*sin(o_1(1))+sin(o_1(3))*sin(o_1(2))*cos(o_1(1));
    -sin(o_1(2)) cos(o_1(2))*sin(o_1(1)) cos(o_1(2))*cos(o_1(1))];
A_2 = [cos(o_2(3))*cos(o_2(2)) -sin(o_2(3))*cos(o_2(1))+cos(o_2(3))*sin(o_2(2))*sin(o_2(1)) sin(o_2(3))*sin(o_2(1))+cos(o_2(3))*sin(o_2(2))*cos(o_2(1));
    sin(o_2(3))*cos(o_2(2)) cos(o_2(3))*cos(o_2(1))+sin(o_2(3))*sin(o_2(2))*sin(o_2(1)) -cos(o_2(3))*sin(o_2(1))+sin(o_2(3))*sin(o_2(2))*cos(o_2(1));
    -sin(o_2(2)) cos(o_2(2))*sin(o_2(1)) cos(o_2(2))*cos(o_2(1))];
A_3 = [cos(o_3(3))*cos(o_3(2)) -sin(o_3(3))*cos(o_3(1))+cos(o_3(3))*sin(o_3(2))*sin(o_3(1)) sin(o_3(3))*sin(o_3(1))+cos(o_3(3))*sin(o_3(2))*cos(o_3(1));
    sin(o_3(3))*cos(o_3(2)) cos(o_3(3))*cos(o_3(1))+sin(o_3(3))*sin(o_3(2))*sin(o_3(1)) -cos(o_3(3))*sin(o_3(1))+sin(o_3(3))*sin(o_3(2))*cos(o_3(1));
    -sin(o_3(2)) cos(o_3(2))*sin(o_3(1)) cos(o_3(2))*cos(o_3(1))];

% Stiffness
k_1 = A_1*k_l_1*A_1';
k_2 = A_2*k_l_2*A_2';
k_3 = A_3*k_l_3*A_3';
K = [k_1 k_1*B_1' ; (k_1*B_1')' B_1*k_1*B_1'] + [k_2 k_2*B_2' ; (k_2*B_2')' B_2*k_2*B_2'] + [k_3 k_3*B_3' ; (k_3*B_3')' B_3*k_3*B_3'];

% Damping
c_1 = A_1*c_l_1*A_1';
c_2 = A_2*c_l_2*A_2';
c_3 = A_3*c_l_3*A_3';
C = [c_1 c_1*B_1' ; (c_1*B_1')' B_1*c_1*B_1'] + [c_2 c_2*B_2' ; (c_2*B_2')' B_2*c_2*B_2'] + [c_3 c_3*B_3' ; (c_3*B_3')' B_3*c_3*B_3'];

F_hat_1 = (1i*w*c_1+k_1)*[eye(3) B_1']*(-w^2*M+1i*w*C+K)^(-1)*f;
F_hat_2 = (1i*w*c_2+k_2)*[eye(3) B_2']*(-w^2*M+1i*w*C+K)^(-1)*f;
F_hat_3 = (1i*w*c_3+k_3)*[eye(3) B_3']*(-w^2*M+1i*w*C+K)^(-1)*f;


A = max([abs(F_hat_1(1)), abs(F_hat_1(2)), abs(F_hat_1(3)) , abs(F_hat_2(1)), abs(F_hat_2(2)), abs(F_hat_2(3)) , abs(F_hat_3(1)), abs(F_hat_3(2)), abs(F_hat_3(3))]);

F = A;