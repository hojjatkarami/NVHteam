function [F_1, F_2, F_3] = force_cal(x,T, z)


[~,~,k_1,k_2,k_3,c_1,c_2,c_3] = stiff_cal(x,T);

F_1 = zeros(length(z(:,1)),3);
F_2 = F_1;
F_3 = F_1;
% F_1_n = z(:,1);
% F_2_n = z(:,1);
% F_3_n = z(:,1);

% r_1 = x(1:3);
% r_2 = x(4:6);
% r_3 = x(7:9);
% 
% o_1 = x(10:12);
% o_2 = x(13:15);
% o_3 = x(16:18);
% 
% k_l_1 = diag(x(19:21));
% k_l_2 = diag(x(22:24));
% k_l_3 = diag(x(25:27));
% 
% c_l_1 = diag(x(28:30));
% c_l_2 = diag(x(31:33));
% c_l_3 = diag(x(34:36));
% 
% if x(37)~=0
%     c_l_1 = x(37)*k_l_1;
% end
% if x(38)~=0
%     c_l_2 = x(38)*k_l_2;
% end
% if x(39)~=0
%     c_l_3 = x(39)*k_l_3;
% end
% 
% % Position of the mounts
% B_1 = [0 -r_1(3) r_1(2) ; r_1(3) 0 -r_1(1) ; -r_1(2) r_1(1) 0];
% B_2 = [0 -r_2(3) r_2(2) ; r_2(3) 0 -r_2(1) ; -r_2(2) r_2(1) 0];
% B_3 = [0 -r_3(3) r_3(2) ; r_3(3) 0 -r_3(1) ; -r_3(2) r_3(1) 0];
% 
% % Orientation of the mounts
% A_1 = [cos(o_1(3))*cos(o_1(2)) -sin(o_1(3))*cos(o_1(1))+cos(o_1(3))*sin(o_1(2))*sin(o_1(1)) sin(o_1(3))*sin(o_1(1))+cos(o_1(3))*sin(o_1(2))*cos(o_1(1));
%     sin(o_1(3))*cos(o_1(2)) cos(o_1(3))*cos(o_1(1))+sin(o_1(3))*sin(o_1(2))*sin(o_1(1)) -cos(o_1(3))*sin(o_1(1))+sin(o_1(3))*sin(o_1(2))*cos(o_1(1));
%     -sin(o_1(2)) cos(o_1(2))*sin(o_1(1)) cos(o_1(2))*cos(o_1(1))];
% A_2 = [cos(o_2(3))*cos(o_2(2)) -sin(o_2(3))*cos(o_2(1))+cos(o_2(3))*sin(o_2(2))*sin(o_2(1)) sin(o_2(3))*sin(o_2(1))+cos(o_2(3))*sin(o_2(2))*cos(o_2(1));
%     sin(o_2(3))*cos(o_2(2)) cos(o_2(3))*cos(o_2(1))+sin(o_2(3))*sin(o_2(2))*sin(o_2(1)) -cos(o_2(3))*sin(o_2(1))+sin(o_2(3))*sin(o_2(2))*cos(o_2(1));
%     -sin(o_2(2)) cos(o_2(2))*sin(o_2(1)) cos(o_2(2))*cos(o_2(1))];
% A_3 = [cos(o_3(3))*cos(o_3(2)) -sin(o_3(3))*cos(o_3(1))+cos(o_3(3))*sin(o_3(2))*sin(o_3(1)) sin(o_3(3))*sin(o_3(1))+cos(o_3(3))*sin(o_3(2))*cos(o_3(1));
%     sin(o_3(3))*cos(o_3(2)) cos(o_3(3))*cos(o_3(1))+sin(o_3(3))*sin(o_3(2))*sin(o_3(1)) -cos(o_3(3))*sin(o_3(1))+sin(o_3(3))*sin(o_3(2))*cos(o_3(1));
%     -sin(o_3(2)) cos(o_3(2))*sin(o_3(1)) cos(o_3(2))*cos(o_3(1))];
% 
% % Stiffness
% k_1 = A_1*k_l_1*A_1';
% k_2 = A_2*k_l_2*A_2';
% k_3 = A_3*k_l_3*A_3';
% 
% % Damping
% c_1 = A_1*c_l_1*A_1';
% c_2 = A_2*c_l_2*A_2';
% c_3 = A_3*c_l_3*A_3';

for i = 1:length(z(:,1))  
    F_1(i,:) = (k_1*[eye(3) B_1']*z(i,1:6)' + c_1*[eye(3) B_1']*z(i,7:12)')';
%     F_1_n(i) = norm(F_1(i,:));
    F_2(i,:) = (k_2*[eye(3) B_2']*z(i,1:6)' + c_2*[eye(3) B_2']*z(i,7:12)')';
%     F_2_n(i) = norm(F_2(i,:));
    F_3(i,:) = (k_3*[eye(3) B_3']*z(i,1:6)' + c_3*[eye(3) B_3']*z(i,7:12)')';
%     F_3_n(i) = norm(F_3(i,:));
end