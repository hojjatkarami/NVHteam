function [F_1, F_2, F_3] = force_cal(x, z)

[~,~,k_1,k_2,k_3,c_1,c_2,c_3] = stiff_cal(x,1);

F_1 = zeros(length(z(:,1)),3);
F_2 = F_1;
F_3 = F_1;
% F_1_n = z(:,1);
% F_2_n = z(:,1);
% F_3_n = z(:,1);

r_1 = x(1:3);
r_2 = x(4:6);
r_3 = x(7:9);

o_1 = x(10:12);
o_2 = x(13:15);
o_3 = x(16:18);

k_l_1 = diag(x(19:21));
k_l_2 = diag(x(22:24));
k_l_3 = diag(x(25:27));

k_m_1 = x(28);
k_l_1(3,3) = k_l_1(3,3) + k_m_1;

c_l_1 = diag(x(29:31));
c_l_2 = diag(x(32:34));
c_l_3 = diag(x(35:37));

c_m_1 = x(38);

B_1 = [0 -r_1(3) r_1(2) ; r_1(3) 0 -r_1(1) ; -r_1(2) r_1(1) 0];
B_2 = [0 -r_2(3) r_2(2) ; r_2(3) 0 -r_2(1) ; -r_2(2) r_2(1) 0];
B_3 = [0 -r_3(3) r_3(2) ; r_3(3) 0 -r_3(1) ; -r_3(2) r_3(1) 0];

A_1 = [cos(o_1(3))*cos(o_1(2)) -sin(o_1(3))*cos(o_1(1))+cos(o_1(3))*sin(o_1(2))*sin(o_1(1)) sin(o_1(3))*sin(o_1(1))+cos(o_1(3))*sin(o_1(2))*cos(o_1(1));
    sin(o_1(3))*cos(o_1(2)) cos(o_1(3))*cos(o_1(1))+sin(o_1(3))*sin(o_1(2))*sin(o_1(1)) -cos(o_1(3))*sin(o_1(1))+sin(o_1(3))*sin(o_1(2))*cos(o_1(1));
    -sin(o_1(2)) cos(o_1(2))*sin(o_1(1)) cos(o_1(2))*cos(o_1(1))];
A_2 = [cos(o_2(3))*cos(o_2(2)) -sin(o_2(3))*cos(o_2(1))+cos(o_2(3))*sin(o_2(2))*sin(o_2(1)) sin(o_2(3))*sin(o_2(1))+cos(o_2(3))*sin(o_2(2))*cos(o_2(1));
    sin(o_2(3))*cos(o_2(2)) cos(o_2(3))*cos(o_2(1))+sin(o_2(3))*sin(o_2(2))*sin(o_2(1)) -cos(o_2(3))*sin(o_2(1))+sin(o_2(3))*sin(o_2(2))*cos(o_2(1));
    -sin(o_2(2)) cos(o_2(2))*sin(o_2(1)) cos(o_2(2))*cos(o_2(1))];
A_3 = [cos(o_3(3))*cos(o_3(2)) -sin(o_3(3))*cos(o_3(1))+cos(o_3(3))*sin(o_3(2))*sin(o_3(1)) sin(o_3(3))*sin(o_3(1))+cos(o_3(3))*sin(o_3(2))*cos(o_3(1));
    sin(o_3(3))*cos(o_3(2)) cos(o_3(3))*cos(o_3(1))+sin(o_3(3))*sin(o_3(2))*sin(o_3(1)) -cos(o_3(3))*sin(o_3(1))+sin(o_3(3))*sin(o_3(2))*cos(o_3(1));
    -sin(o_3(2)) cos(o_3(2))*sin(o_3(1)) cos(o_3(2))*cos(o_3(1))];


for i = 1:length(z(:,1)) 
%     F_1(i,:) = c_1*[eye(3) B_1']*z(i,8:13)' + A_1*(k_l_1-hyd*[0 0 0;0 0 0;0 0 k_m_1])*A_1'*[eye(3) B_1']*z(i,1:6)' + hyd*A_1*[0;0;c_m_1]*z(i,14);

    F_1(i,:) = (k_1*[eye(3) B_1']*z(i,1:6)' + c_1*[eye(3) B_1']*z(i,8:13)')';
%     F_1_n(i) = norm(F_1(i,:));
    F_2(i,:) = (k_2*[eye(3) B_2']*z(i,1:6)' + c_2*[eye(3) B_2']*z(i,8:13)')';
%     F_2_n(i) = norm(F_2(i,:));
    F_3(i,:) = (k_3*[eye(3) B_3']*z(i,1:6)' + c_3*[eye(3) B_3']*z(i,8:13)')';
%     F_3_n(i) = norm(F_3(i,:));
end