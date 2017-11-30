function F = obj_TA(x11,T,F,x_init,T1, ComponentSelector, OptTypeSelector, w, f, M_e,f_nat_lb,f_nat_ub , sus, a, b, d)
% 960906 Code Readed
% Code must be changed

% 960907 Code Readed
% Code must be changed
x = T * (F .* x_init + T1*x11');

r_1 = x(1:3);
r_2 = x(4:6);
r_3 = x(7:9);

R_1 = sus.E_cm + r_1;
R_2 = sus.E_cm + r_2;
R_3 = sus.E_cm + r_3;

B_1 = [0 -R_1(3) R_1(2) ; R_1(3) 0 -R_1(1) ; -R_1(2) R_1(1) 0];       %Cross Product Matrix For Mount 1
B_2 = [0 -R_2(3) R_2(2) ; R_2(3) 0 -R_2(1) ; -R_2(2) R_2(1) 0];
B_3 = [0 -R_3(3) R_3(2) ; R_3(3) 0 -R_3(1) ; -R_3(2) R_3(1) 0];

[M_v,C_v,K_v] = BodyParameters(x,sus,M_e);

A = 0; E = 0; G = 0;
lng = length(w);

for i=1:lng

q_hat = (-w(i)^2*M_v+1i*w(i)*C_v+K_v)^(-1)*[zeros(11,1); f(i);0;0];
% q_hat = (-w(i)^2*M_v+1i*w(i)*C_v+K_v)^(-1)*[zeros(13,1);f(i)];   % Must be changed
% 
% Temp_A = ComponentSelector.*[abs((-w(i)^2*([zeros(1,4) 1 zeros(1,8)]-[zeros(1,6) R_1(1) zeros(1,6)]+[zeros(1,5) R_1(2) zeros(1,7)])*q_hat)); ...
%                         abs((-w(i)^2*([zeros(1,4) 1 zeros(1,8)]-[zeros(1,6) R_2(1) zeros(1,6)]+[zeros(1,5) R_2(2) zeros(1,7)])*q_hat)); ...
%                         abs((-w(i)^2*([zeros(1,4) 1 zeros(1,8)]-[zeros(1,6) R_3(1) zeros(1,6)]+[zeros(1,5) R_3(2) zeros(1,7)])*q_hat))];

    aB_1 = w(i)^2*[eye(3) B_1']*[0;0;q_hat(5:7);0];
    aB_2 = w(i)^2*[eye(3) B_2']*[0;0;q_hat(5:7);0];
    aB_3 = w(i)^2*[eye(3) B_3']*[0;0;q_hat(5:7);0];
    
  Temp_A = ComponentSelector.*[abs(aB_1(1)) abs(aB_1(2)) abs(aB_1(3)) abs(aB_1);
                                                          abs(aB_2(1)) abs(aB_2(2)) abs(aB_2(3)) abs(aB_2);
                                                          abs(aB_3(1)) abs(aB_3(2)) abs(aB_3(3)) abs(aB_3)];

 Temp_A = OptTypeSelector * [max(max(Temp_A)); sum(sum(Temp_A))];
    A = A + Temp_A;
    
    [K,~] = stiff_cal(x,i);
    KEF = KEF_cal(K,M_e(1:6,1:6));
    KED = max(KEF)';
    dif = KEDcr*ones(6,1)-KED;
    E = E + heaviside(dif)'*dif;
    
    f_nat = NF_Calculator(x,M_e(1:6,1:6));
    dif_lb = f_nat_lb - f_nat;
    dif_ub = f_nat - f_nat_ub;
    P_low = heaviside(dif_lb)'*dif_lb;
    P_High = heaviside(dif_ub)'*dif_ub;
    G =  G + P_low + P_High;
    
end

F = a*A + b*E + d*G;