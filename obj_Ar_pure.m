function Fval = obj_Ar_pure(x, ComponentSelector, OptTypeSelector, w, f, M,sus)
% 960906 Code Readed
Fval=0;

r_1 = x(1:3);
r_2 = x(4:6);
r_3 = x(7:9);

b_1 = [0 -r_1(3) r_1(2) ; r_1(3) 0 -r_1(1) ; -r_1(2) r_1(1) 0];       %Cross Product Matrix For Mount 1
b_2 = [0 -r_2(3) r_2(2) ; r_2(3) 0 -r_2(1) ; -r_2(2) r_2(1) 0];
b_3 = [0 -r_3(3) r_3(2) ; r_3(3) 0 -r_3(1) ; -r_3(2) r_3(1) 0];

R_1 = sus.E_cm + r_1;
R_2 = sus.E_cm + r_2;
R_3 = sus.E_cm + r_3;

B_1 = [0 -R_1(3) R_1(2) ; R_1(3) 0 -R_1(1) ; -R_1(2) R_1(1) 0];       %Cross Product Matrix For Mount 1
B_2 = [0 -R_2(3) R_2(2) ; R_2(3) 0 -R_2(1) ; -R_2(2) R_2(1) 0];
B_3 = [0 -R_3(3) R_3(2) ; R_3(3) 0 -R_3(1) ; -R_3(2) R_3(1) 0];

[M_v,C_v,K_v] = BodyParameters(x,sus,M);


lng = length(w);

for i = 1:lng
    q_hat = (-w(i)^2*M_v+1i*w(i)*C_v+K_v)^(-1)*[zeros(11,1); f(i);0];
    
    
    aE_1 = [eye(3) b_1']*q_hat(8:13);
    aB_1 = [eye(3) B_1']*[0;0;q_hat(5:7);0];
    aE_2 = [eye(3) b_2']*q_hat(8:13);
    aB_2 = [eye(3) B_2']*[0;0;q_hat(5:7);0];
    aE_3 = [eye(3) b_3']*q_hat(8:13);
    aB_3 = [eye(3) B_3']*[0;0;q_hat(5:7);0];
    
    Temp_A = ComponentSelector.*(20*log10(  [abs(aE_1(1)/aB_1(1)) abs(aE_1(2)/aB_1(2)) abs(aE_1(3)/aB_1(3)) norm(abs(aE_1))/norm(abs(aB_1));
                                              abs(aE_2(1)/aB_2(1)) abs(aE_2(2)/aB_2(2)) abs(aE_2(3)/aB_2(3)) norm(abs(aE_2))/norm(abs(aB_2));
                                              abs(aE_3(1)/aB_3(1)) abs(aE_3(2)/aB_3(2)) abs(aE_3(3)/aB_3(3)) norm(abs(aE_3))/norm(abs(aB_3))]   ));
    
    Temp_A = OptTypeSelector * [max(max(Temp_A)); sum(sum(Temp_A))];
    Fval = Fval - Temp_A;
    


end
