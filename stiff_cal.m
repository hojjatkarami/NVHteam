function [K,C,k_1,k_2,k_3,c_1,c_2,c_3] = stiff_cal(x,index)

global StiffLocBody
StiffLocBody.k1 = 1e8*ones(3,1);
StiffLocBody.k2 = 1e8*ones(3,1);
StiffLocBody.k3 = 1e8*ones(3,1);
StiffLocBody.c1 = 1e8*ones(3,1);
StiffLocBody.c2 = 1e8*ones(3,1);
StiffLocBody.c3 = 1e8*ones(3,1);

kLocBody_1 = StiffLocBody.k1(index);
kLocBody_2 = StiffLocBody.k2(index);
kLocBody_3 = StiffLocBody.k3(index);
cLocBody_1 = StiffLocBody.c1(index);
cLocBody_2 = StiffLocBody.c2(index);
cLocBody_3 = StiffLocBody.c3(index);

cLocBody_1 = .1 * kLocBody_1;
cLocBody_2 = .1 * kLocBody_2;
cLocBody_3 = .1 * kLocBody_3;

r_1 = x(1:3);
r_2 = x(4:6);
r_3 = x(7:9);

o_1 = x(10:12);
o_2 = x(13:15);
o_3 = x(16:18);

k_l_1 = diag(x(19:21));
k_l_2 = diag(x(22:24));
k_l_3 = diag(x(25:27));

c_l_1 = diag(x(28:30));
c_l_2 = diag(x(31:33));
c_l_3 = diag(x(34:36));

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
% kDiag = diag(k_1);
% kDiag3D = diag(kDiag);
% k_1 = k_1 - kDiag3D;
% kDiag = (kDiag.*kLocBody_1)./(kDiag + kLocBody_1);
% kDiag3D = diag(kDiag);
% k_1 = k_1 + kDiag3D;

k_2 = A_2*k_l_2*A_2';
% kDiag = diag(k_2);
% kDiag3D = diag(kDiag);
% k_2 = k_2 - kDiag3D;
% kDiag = (kDiag.*kLocBody_2)/(kDiag + kLocBody_2);
% kDiag3D = diag(kDiag);
% k_2 = k_2 + kDiag3D;

k_3 = A_3*k_l_3*A_3';
% kDiag = diag(k_3);
% kDiag3D = diag(kDiag);
% k_3 = k_3 - kDiag3D;
% kDiag = (kDiag.*kLocBody_3)/(kDiag + kLocBody_3);
% kDiag3D = diag(kDiag);
% k_3 = k_3 + kDiag3D;

K = [k_1 k_1*B_1' ; (k_1*B_1')' B_1*k_1*B_1'] + [k_2 k_2*B_2' ; (k_2*B_2')' B_2*k_2*B_2'] + [k_3 k_3*B_3' ; (k_3*B_3')' B_3*k_3*B_3'];

% Damping
c_1 = A_1*c_l_1*A_1';
% cDiag = diag(c_1);
% cDiag3D = diag(cDiag);
% c_1 = c_1 - cDiag3D;
% cDiag = (cDiag.*cLocBody_1)/(cDiag + cLocBody_1);
% cDiag3D = diag(cDiag);
% c_1 = c_1 + cDiag3D;

c_2 = A_2*c_l_2*A_2';
% cDiag = diag(c_2);
% cDiag3D = diag(cDiag);
% c_2 = c_2 - cDiag3D;
% cDiag = (cDiag.*cLocBody_2)/(cDiag + cLocBody_2);
% cDiag3D = diag(cDiag);
% c_2 = c_2 + cDiag3D;

c_3 = A_3*c_l_3*A_3';
% cDiag = diag(c_3);
% cDiag3D = diag(cDiag);
% c_3 = c_3 - cDiag3D;
% cDiag = (cDiag.*cLocBody_3)/(cDiag + cLocBody_3);
% cDiag3D = diag(cDiag);
% c_3 = c_3 + cDiag3D;

C = [c_1 c_1*B_1' ; (c_1*B_1')' B_1*c_1*B_1'] + [c_2 c_2*B_2' ; (c_2*B_2')' B_2*c_2*B_2'] + [c_3 c_3*B_3' ; (c_3*B_3')' B_3*c_3*B_3'];