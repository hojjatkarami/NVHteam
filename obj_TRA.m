function F = obj_TRA(x,T,F,x_init,T1,  M, a, b, d)


x = T * (F .* x_init + T1*x');
[K,~] = stiff_cal(x);
w_TRA = x(43);

[q_TRA,~] = TRA_finder(M(4:6,4:6),[0;1;0]);
q_TRA = [0;0;0;q_TRA];
A = K*q_TRA;
B = w_TRA^2*M*q_TRA;

KEF = KEF_cal(K,M);

best_index = zeros(6,1);
for j = 1:6
    [~,best_index(j)] = max(KEF(:,j));
end

C = ((100-KEF(best_index(1),1))^2 + (100-KEF(best_index(2),2))^2 + (100-KEF(best_index(3),3))^2 + (100-KEF(best_index(4),4))^2 + (100-KEF(best_index(5),5))^2 + (100-KEF(best_index(6),6))^2);
f_nat_lb = 1.05*[7;7;9;11;11;0];
f_nat_ub = 0.95*[100;100;11;14;14;18];
f_nat = NF_Calculator(x,M);
D = 0;
for i = 1:6
    P_low = heaviside(f_nat_lb(i)-f_nat(i))*(f_nat_lb(i)-f_nat(i))^3;
    P_High = heaviside(f_nat(i)-f_nat_ub(i))*(f_nat(i)-f_nat_ub(i))^3;
    D = D + P_low + P_High;
end

F = a*norm(A-B) + b*C + d*D;