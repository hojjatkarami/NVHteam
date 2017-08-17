function [c, ceq] = nlcn(x, M_e, f_nat_lb, f_nat_ub, delta_s)

[K_e,~] = stiff_cal(x);

KEF = KEF_cal(K_e(1:6,1:6),M_e(1:6,1:6));

best_index = zeros(6,1);
for j = 1:6
    [~,best_index(j)] = max(KEF(:,j));
end

KED = [KEF(best_index(1),1); KEF(best_index(2),2); KEF(best_index(3),3); KEF(best_index(4),4); KEF(best_index(5),5); KEF(best_index(6),6)];
stc = abs((K_e/1.5)^(-1)*[0;0;M_e(1,1)*9.81;0;0;0;0]);
f_nat = NF_Calculator(K_e(1:6,1:6),M_e(1:6,1:6));

A = [95;95;95;95;95;95]-KED;
B = stc-delta_s;
C = f_nat - f_nat_ub;
D = f_nat_lb - f_nat;

c = [A; B; C; D];
ceq = [];
