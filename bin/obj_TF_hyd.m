function F = obj_TF_hyd(x11,T,F,x_init,T1, ComponentSelector, OptTypeSelector, w, f, M,f_nat_lb,f_nat_ub ,a, b, d)

x = T * (F .* x_init + T1*x11');

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
k_1 = A_1*k_l_1*A_1';
k_2 = A_2*k_l_2*A_2';
k_3 = A_3*k_l_3*A_3';
K = [k_1 k_1*B_1' ; (k_1*B_1')' B_1*k_1*B_1'] + [k_2 k_2*B_2' ; (k_2*B_2')' B_2*k_2*B_2'] + [k_3 k_3*B_3' ; (k_3*B_3')' B_3*k_3*B_3'];

c_1 = A_1*c_l_1*A_1';
c_2 = A_2*c_l_2*A_2';
c_3 = A_3*c_l_3*A_3';
C = [c_1 c_1*B_1' ; (c_1*B_1')' B_1*c_1*B_1'] + [c_2 c_2*B_2' ; (c_2*B_2')' B_2*c_2*B_2'] + [c_3 c_3*B_3' ; (c_3*B_3')' B_3*c_3*B_3'];



[K,C,k_1,k_2,k_3,c_1,c_2,c_3] = stiff_cal(x,1);
%     K_e=K(1:6,1:6);
%     C_e=C(1:6,1:6);
% 
%     M_e=M(1:6,1:6);

lng = length(w);
% F_h_1 = zeros(3,lng); F_h_2 = F_h_1; F_h_3 = F_h_1; 

A = 0; B = 0; D = 0;

for i=1:lng
   
    Torque = [0;0;0;0;f(i);0];
    
    Torque2 = [0;0;0;0;f(i);0;0];
    q_e_hat = (-w^2*M + 1i*w*C + K)^(-1)*Torque2;
    

    
%     F_hat_1 = ((1i*w(i)*c_1+k_1)*[eye(3) B_1']*(-w(i)^2*M(1:6,1:6)+1i*w(i)*C(1:6,1:6)+K(1:6,1:6))^(-1)*Torque);
    F_hat_1 = (A_1*(1i*w*c_l_1 + k_l_1-[0 0 0;0 0 0;0 0 k_m_1])*A_1'*[eye(3) B_1']*[eye(6) zeros(6,1)] + A_1*[0;0;c_m_1]*[0 0 0 0 0 0 1])*q_e_hat;
    F_hat_2 = ((1i*w(i)*c_2+k_2)*[eye(3) B_2']*(-w(i)^2*M(1:6,1:6)+1i*w(i)*C(1:6,1:6)+K(1:6,1:6))^(-1)*Torque);
    F_hat_3 = ((1i*w(i)*c_3+k_3)*[eye(3) B_3']*(-w(i)^2*M(1:6,1:6)+1i*w(i)*C(1:6,1:6)+K(1:6,1:6))^(-1)*Torque);

    
    Temp_A = ComponentSelector.*[abs(F_hat_1(1)), abs(F_hat_1(2)), abs(F_hat_1(3)), norm(F_hat_1); ...
                            abs(F_hat_2(1)), abs(F_hat_2(2)), abs(F_hat_2(3)), norm(F_hat_1);...
                            abs(F_hat_3(1)), abs(F_hat_3(2)), abs(F_hat_3(3)), norm(F_hat_1)] ;

    Temp_A = OptTypeSelector * [max(max(Temp_A)); sum(sum(Temp_A))];
    A = A + Temp_A;
    
    KEF = KEF_cal(K,M);

    best_index = zeros(6,1);
    for j = 1:6
        [~,best_index(j)] = max(KEF(:,j));
    end
    Temp_B = ((100-KEF(best_index(1),1))^2 + (100-KEF(best_index(2),2))^2 + (100-KEF(best_index(3),3))^2 + (100-KEF(best_index(4),4))^2 + (100-KEF(best_index(5),5))^2 + (100-KEF(best_index(6),6))^2);
    B = B + Temp_B;
    
KEF = KEF_cal(K(1:6,1:6),M(1:6,1:6));

best_index = zeros(6,1);
for j = 1:6
    [~,best_index(j)] = max(KEF(:,j));
end

f_nat = NF_Calculator(x,M(1:6,1:6));

for i = 1:6
    P_low = heaviside(f_nat_lb(i)-f_nat(i))*(f_nat_lb(i)-f_nat(i))^3;
    P_High = heaviside(f_nat(i)-f_nat_ub(i))*(f_nat(i)-f_nat_ub(i))^3;
    D = D + P_low + P_High;
end

end

F = a*A + b*B + d*D;
