function F = obj_TF(x11,T,F,x_init,T1, ComponentSelector, OptTypeSelector, w, f, M,f_nat_lb,f_nat_ub ,a, b, d)

x = T * (F .* x_init + T1*x11');

r_1 = x(1:3);
r_2 = x(4:6);
r_3 = x(7:9);

% % Position of the mounts
B_1 = [0 -r_1(3) r_1(2) ; r_1(3) 0 -r_1(1) ; -r_1(2) r_1(1) 0];
B_2 = [0 -r_2(3) r_2(2) ; r_2(3) 0 -r_2(1) ; -r_2(2) r_2(1) 0];
B_3 = [0 -r_3(3) r_3(2) ; r_3(3) 0 -r_3(1) ; -r_3(2) r_3(1) 0];

lng = length(w);
% F_h_1 = zeros(3,lng); F_h_2 = F_h_1; F_h_3 = F_h_1; 

A = 0; B = 0; D = 0;
for i=1:lng
    
    Torque = [0;0;0;0;f(i);0];
    [K,C,k_1,k_2,k_3,c_1,c_2,c_3] = stiff_cal(x,i);
    K=K(1:6,1:6);
    C=C(1:6,1:6);

    M=M(1:6,1:6);
    
    F_hat_1 = ((1i*w(i)*c_1+k_1)*[eye(3) B_1']*(-w(i)^2*M+1i*w(i)*C+K)^(-1)*Torque);
    F_hat_2 = ((1i*w(i)*c_2+k_2)*[eye(3) B_2']*(-w(i)^2*M+1i*w(i)*C+K)^(-1)*Torque);
    F_hat_3 = ((1i*w(i)*c_3+k_3)*[eye(3) B_3']*(-w(i)^2*M+1i*w(i)*C+K)^(-1)*Torque);

    
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
