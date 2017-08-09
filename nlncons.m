function [c,ceq] = nlncons(x,M,f_nat_lb,f_nat_ub)

f_nat = NF_Calculator(x,M);

c = [f_nat_lb - f_nat ; f_nat - f_nat_ub];
ceq = [];