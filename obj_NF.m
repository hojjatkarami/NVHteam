function Fval = obj_NF(x, M_e,f_nat_lb,f_nat_ub)
    % f_nat_lb = 1.05*[7;7;9;11;11;0];
% f_nat_ub = 0.95*[100;100;11;14;14;18];
f_nat = NF_Calculator(x,M_e(1:6,1:6));
Fval = 0;
for i = 1:6
    P_low = heaviside(f_nat_lb(i)-f_nat(i))*(f_nat_lb(i)-f_nat(i));
    P_High = heaviside(f_nat(i)-f_nat_ub(i))*(f_nat(i)-f_nat_ub(i));
    Fval = Fval + P_low + P_High;
end
    
end