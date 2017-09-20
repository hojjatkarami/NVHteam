function [K,C,k_1,k_2,k_3,c_1,c_2,c_3] = stiff_cal(x,index)

global StiffLocBody


kLocBody_1 = StiffLocBody.k1';
kLocBody_2 = StiffLocBody.k2';
kLocBody_3 = StiffLocBody.k3';
cLocBody_1 = StiffLocBody.c1';
cLocBody_2 = StiffLocBody.c2';
cLocBody_3 = StiffLocBody.c3';
kLocBody_1 = kLocBody_1(:,index);
kLocBody_2 = kLocBody_2(:,index);
kLocBody_3 = kLocBody_3(:,index);
cLocBody_1 = cLocBody_1(:,index);
cLocBody_2 = cLocBody_2(:,index);
cLocBody_3 = cLocBody_3(:,index);



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
for i =1:3
    k_1(i,i) = (k_1(i,i)*kLocBody_1(i))/(k_1(i,i)+kLocBody_1(i));
end

k_2 = A_2*k_l_2*A_2';
for i =1:3
    k_2(i,i) = (k_2(i,i)*kLocBody_2(i))/(k_2(i,i)+kLocBody_2(i));
end

k_3 = A_3*k_l_3*A_3';
for i =1:3
    k_3(i,i) = (k_3(i,i)*kLocBody_3(i))/(k_3(i,i)+kLocBody_3(i));
end

K = [k_1 k_1*B_1' ; (k_1*B_1')' B_1*k_1*B_1'] + [k_2 k_2*B_2' ; (k_2*B_2')' B_2*k_2*B_2'] + [k_3 k_3*B_3' ; (k_3*B_3')' B_3*k_3*B_3'];

% Damping
c_1 = A_1*c_l_1*A_1';
for i =1:3
    c_1(i,i) = (c_1(i,i)*cLocBody_1(i))/(c_1(i,i)+cLocBody_1(i));
end

c_2 = A_2*c_l_2*A_2';
for i =1:3
    c_2(i,i) = (c_2(i,i)*cLocBody_2(i))/(c_2(i,i)+cLocBody_2(i));
end

c_3 = A_3*c_l_3*A_3';
for i =1:3
    c_3(i,i) = (c_3(i,i)*cLocBody_3(i))/(c_3(i,i)+cLocBody_3(i));
end

C = [c_1 c_1*B_1' ; (c_1*B_1')' B_1*c_1*B_1'] + [c_2 c_2*B_2' ; (c_2*B_2')' B_2*c_2*B_2'] + [c_3 c_3*B_3' ; (c_3*B_3')' B_3*c_3*B_3'];