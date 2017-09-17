function [c, ceq] = nlcn(x,T,F,x_init,T1, M, f_nat_lb, f_nat_ub, delta_s)

x_main = T * (F .* x_init + T1*x');
[K,~] = stiff_cal(x_main);

KEF = KEF_cal(K,M);

best_index = zeros(6,1);
for j = 1:6
    [~,best_index(j)] = max(KEF(:,j));
end

KED = [KEF(best_index(1),1); KEF(best_index(2),2); KEF(best_index(3),3); KEF(best_index(4),4); KEF(best_index(5),5); KEF(best_index(6),6)];
stc = abs((K/1.5)^(-1)*[0;0;M(1,1)*9.81;0;0;0]);
f_nat = NF_Calculator(x_main,M);

A = [95;95;95;95;95;95]-KED;
B = stc-delta_s;
C = f_nat - f_nat_ub;
D = f_nat_lb - f_nat;

c = [A; B; C; D];
ceq = [];
