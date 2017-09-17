function F = obj_TF(x11,T,F,x_init,T1, ComponentSelector, OptTypeSelector, w, f, M, a, b, d)

% x = T * (F .* x_init + T1*x11');

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
% K = [k_1 k_1*B_1' ; (k_1*B_1')' B_1*k_1*B_1'] + [k_2 k_2*B_2' ; (k_2*B_2')' B_2*k_2*B_2'] + [k_3 k_3*B_3' ; (k_3*B_3')' B_3*k_3*B_3'];
% 
% % Damping
% c_1 = A_1*c_l_1*A_1';
% c_2 = A_2*c_l_2*A_2';
% c_3 = A_3*c_l_3*A_3';
% C = [c_1 c_1*B_1' ; (c_1*B_1')' B_1*c_1*B_1'] + [c_2 c_2*B_2' ; (c_2*B_2')' B_2*c_2*B_2'] + [c_3 c_3*B_3' ; (c_3*B_3')' B_3*c_3*B_3'];

x = F .* x_init + T1*x11';
[K,C,k_1,k_2,k_3,c_1,c_2,c_3] = stiff_cal(x,T);

F_hat_1 = (1i*w*c_1+k_1)*[eye(3) B_1']*(-w^2*M+1i*w*C+K)^(-1)*f;
F_hat_2 = (1i*w*c_2+k_2)*[eye(3) B_2']*(-w^2*M+1i*w*C+K)^(-1)*f;
F_hat_3 = (1i*w*c_3+k_3)*[eye(3) B_3']*(-w^2*M+1i*w*C+K)^(-1)*f;


KEF = KEF_cal(K,M);

best_index = zeros(6,1);
for j = 1:6
    [~,best_index(j)] = max(KEF(:,j));
end
A = ComponentSelector.*[abs(F_hat_1(1)), abs(F_hat_1(2)), abs(F_hat_1(3)), norm(F_hat_1); ...
                        abs(F_hat_2(1)), abs(F_hat_2(2)), abs(F_hat_2(3)), norm(F_hat_1);...
                        abs(F_hat_3(1)), abs(F_hat_3(2)), abs(F_hat_3(3)), norm(F_hat_1)] ;

A = OptTypeSelector * [max(max(A)); sum(sum(A))];
              
B = ((100-KEF(best_index(1),1))^2 + (100-KEF(best_index(2),2))^2 + (100-KEF(best_index(3),3))^2 + (100-KEF(best_index(4),4))^2 + (100-KEF(best_index(5),5))^2 + (100-KEF(best_index(6),6))^2);

f_nat_lb = 1.05*[7;7;9;11;11;0];
f_nat_ub = 0.95*[100;100;11;14;14;18];
f_nat = NF_Calculator(x,T,M);
D = 0;
for i = 1:6
    P_low = heaviside(f_nat_lb(i)-f_nat(i))*(f_nat_lb(i)-f_nat(i))^3;
    P_High = heaviside(f_nat(i)-f_nat_ub(i))*(f_nat(i)-f_nat_ub(i))^3;
    D = D + P_low + P_High;
end

F = a*A + b*B + d*D;