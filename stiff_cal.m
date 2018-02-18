function [K_e,C_e,k_1,k_2,k_3,c_1,c_2,c_3] = stiff_cal(x,indexfreq)
% 960907 Code Readed

global StiffLocBody

kLocBody_1 = StiffLocBody.k1(:,indexfreq);
kLocBody_2 = StiffLocBody.k2(:,indexfreq);
kLocBody_3 = StiffLocBody.k3(:,indexfreq);
cLocBody_1 = StiffLocBody.c1(:,indexfreq);
cLocBody_2 = StiffLocBody.c2(:,indexfreq);
cLocBody_3 = StiffLocBody.c3(:,indexfreq);

r_1 = x(1:3);
r_2 = x(4:6);
r_3 = x(7:9);

o_1 = x(10:12);
o_2 = x(13:15);
o_3 = x(16:18);

k_l_1 = diag(x(19:21));
k_l_2 = diag(x(22:24));
k_l_3 = diag(x(25:27));
k_m_1 = x(38);
k_l_1(3,3) = k_l_1(3,3) + k_m_1;

c_l_1 = diag(x(28:30));
c_l_2 = diag(x(31:33));
c_l_3 = diag(x(34:36));
c_m_1 = x(39);

% Cross product matrices for position of the mounts
b_1 = [0 -r_1(3) r_1(2) ; r_1(3) 0 -r_1(1) ; -r_1(2) r_1(1) 0];
b_2 = [0 -r_2(3) r_2(2) ; r_2(3) 0 -r_2(1) ; -r_2(2) r_2(1) 0];
b_3 = [0 -r_3(3) r_3(2) ; r_3(3) 0 -r_3(1) ; -r_3(2) r_3(1) 0];

% Orientation of the mounts
s1_1 = sin(o_1(1));  s1_2 = sin(o_1(2)); s1_3 = sin(o_1(3));
s2_1 = sin(o_2(1));  s2_2 = sin(o_2(2)); s2_3 = sin(o_2(3));
s3_1 = sin(o_3(1));  s3_2 = sin(o_3(2)); s3_3 = sin(o_3(3));

c1_1 = cos(o_1(1));  c1_2 = cos(o_1(2)); c1_3 = cos(o_1(3));
c2_1 = cos(o_2(1));  c2_2 = cos(o_2(2)); c2_3 = cos(o_2(3));
c3_1 = cos(o_3(1));  c3_2 = cos(o_3(2)); c3_3 = cos(o_3(3));

A_1 = [c1_3*c1_2 -s1_3*c1_1+c1_3*s1_2*s1_1 s1_3*s1_1+c1_3*s1_2*c1_1;
            s1_3*c1_2 c1_3*c1_1+s1_3*s1_2*s1_1 -c1_3*s1_1+s1_3*s1_2*c1_1;
          -s1_2 c1_2*s1_1 c1_2*c1_1];
A_2 = [c2_3*c2_2 -s2_3*c2_1+c2_3*s2_2*s2_1 s2_3*s2_1+c2_3*s2_2*c2_1;
           s2_3*c2_2 c2_3*c2_1+s2_3*s2_2*s2_1 -c2_3*s2_1+s2_3*s2_2*c2_1;
          -s2_2 c2_2*s2_1 c2_2*c2_1];
A_3 = [c3_3*c3_2 -s3_3*c3_1+c3_3*s3_2*s3_1 s3_3*s3_1+c3_3*s3_2*c3_1;
           s3_3*c3_2 c3_3*c3_1+s3_3*s3_2*s3_1 -c3_3*s3_1+s3_3*s3_2*c3_1;
         -s3_2 c3_2*s3_1 c3_2*c3_1];

% Stiffness local to global
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

K = [k_1 k_1*b_1' ; (k_1*b_1')' b_1*k_1*b_1'] + [k_2 k_2*b_2' ; (k_2*b_2')' b_2*k_2*b_2'] + [k_3 k_3*b_3' ; (k_3*b_3')' b_3*k_3*b_3'];

% Damping local to global
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

C = [c_1 c_1*b_1' ; (c_1*b_1')' b_1*c_1*b_1'] + [c_2 c_2*b_2' ; (c_2*b_2')' b_2*c_2*b_2'] + [c_3 c_3*b_3' ; (c_3*b_3')' b_3*c_3*b_3'];

K_tilda = k_m_1;
C_tilda = c_m_1;

K_bar = -[eye(3);b_1]*A_1*[0;0;k_m_1];

K_e = [K, K_bar; K_bar', K_tilda];
C_e = [C, zeros(6,1); zeros(1,6), C_tilda];