function Fval = obj_TF_pure(x, ComponentSelector, OptTypeSelector, w, f, M,K,C)
% 960906 Code Readed


r_1 = x(1:3);
r_2 = x(4:6);
r_3 = x(7:9);

B_1 = [0 -r_1(3) r_1(2) ; r_1(3) 0 -r_1(1) ; -r_1(2) r_1(1) 0];       %Cross Product Matrix For Mount 1
B_2 = [0 -r_2(3) r_2(2) ; r_2(3) 0 -r_2(1) ; -r_2(2) r_2(1) 0];
B_3 = [0 -r_3(3) r_3(2) ; r_3(3) 0 -r_3(1) ; -r_3(2) r_3(1) 0];

[~,~,k_1,k_2,k_3,c_1,c_2,c_3] = stiff_cal(x,1);
   

lng = length(w);
% F_h_1 = zeros(3,lng); F_h_2 = F_h_1; F_h_3 = F_h_1; 

A = 0;

for i=1:lng
   
    Torque = [0;0;0;0;f(i);0];
    
    F_hat_1 = ((1i*w(i)*c_1+k_1)*[eye(3) B_1']*(-w(i)^2*M+1i*w(i)*C+K)^(-1)*Torque);  % transpose???
    F_hat_2 = ((1i*w(i)*c_2+k_2)*[eye(3) B_2']*(-w(i)^2*M+1i*w(i)*C+K)^(-1)*Torque);
    F_hat_3 = ((1i*w(i)*c_3+k_3)*[eye(3) B_3']*(-w(i)^2*M+1i*w(i)*C+K)^(-1)*Torque);
    
    Temp_A = ComponentSelector.*[abs(F_hat_1(1)), abs(F_hat_1(2)), abs(F_hat_1(3)), norm(F_hat_1); ...
                                                            abs(F_hat_2(1)), abs(F_hat_2(2)), abs(F_hat_2(3)), norm(F_hat_1);...
                                                            abs(F_hat_3(1)), abs(F_hat_3(2)), abs(F_hat_3(3)), norm(F_hat_1)] ;

    Temp_A = OptTypeSelector * [max(max(Temp_A)); sum(sum(Temp_A))];
    A = A + Temp_A;
    


end

Fval = A ;
