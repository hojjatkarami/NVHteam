function F = TA2(x, w, f, M_e, sus, a, b, d)
r_1 = x(1:3);
r_2 = x(4:6);
r_3 = x(7:9);
R_1 = sus.E_cm + r_1;
R_2 = sus.E_cm + r_2;
R_3 = sus.E_cm + r_3;

[M_v,C_v,K_v] = BodyParameters2(sus,M_e,x);
size(M_v)
size(C_v)
size(K_v)

q_hat = (-w^2*M_v+1i*w*C_v+K_v)^(-1)*[zeros(7,1);f]
term


A = max([abs((-w^2*([zeros(1,4) 1 zeros(1,9)]-[zeros(1,6) R_1(1) zeros(1,7)]+[zeros(1,5) R_1(2) zeros(1,8)])*q_hat)) ...
        ,abs((-w^2*([zeros(1,4) 1 zeros(1,9)]-[zeros(1,6) R_2(1) zeros(1,7)]+[zeros(1,5) R_2(2) zeros(1,8)])*q_hat))...
        ,abs((-w^2*([zeros(1,4) 1 zeros(1,9)]-[zeros(1,6) R_3(1) zeros(1,7)]+[zeros(1,5) R_3(2) zeros(1,8)])*q_hat))]);


[K_e,~] = stiff_cal(x);
KEF = KEF_cal(K_e(1:6,1:6),M_e(1:6,1:6));

best_index = zeros(6,1);
for j = 1:6
    [~,best_index(j)] = max(KEF(:,j));
end

E = ((100-KEF(best_index(1),1))^2 + (100-KEF(best_index(2),2))^2 + (100-KEF(best_index(3),3))^2 + (100-KEF(best_index(4),4))^2 + (100-KEF(best_index(5),5))^2 + (100-KEF(best_index(6),6))^2);
f_nat_lb = 1.05*[7;7;9;11;11;0];
f_nat_ub = 0.95*[100;100;11;14;14;18];
f_nat = NF_Calculator(K_e(1:6,1:6),M_e(1:6,1:6));
G = 0;
for i = 1:6
    P_low = heaviside(f_nat_lb(i)-f_nat(i))*(f_nat_lb(i)-f_nat(i))^3;
    P_High = heaviside(f_nat(i)-f_nat_ub(i))*(f_nat(i)-f_nat_ub(i))^3;
    G = G + P_low + P_High;
end

F = a*A + b*E + d*G;