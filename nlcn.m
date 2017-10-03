function [c, ceq] = nlcn(x,T,F,x_init,T1, M, f_nat_lb, f_nat_ub, delta_s, StaticTests)

x_main = T * (F .* x_init + T1*x');
[K,~] = stiff_cal(x_main,1);

KEF = KEF_cal(K(1:6,1:6),M(1:6,1:6));

best_index = zeros(6,1);
for j = 1:6
    [~,best_index(j)] = max(KEF(:,j));
end

KED = [KEF(best_index(1),1); KEF(best_index(2),2); KEF(best_index(3),3); KEF(best_index(4),4); KEF(best_index(5),5); KEF(best_index(6),6)];

% stc_Mat = zeros(6,8);
mg = M(1,1)*9.81;

% stc_Mat(:,1) = (abs((K(1:6,1:6)/1.5)^(-1))) * mg * [0;0;-1;0;0;0];
% stc_Mat(:,2) = (abs((K(1:6,1:6)/1.5)^(-1))) * mg * [-0.4;0;-1;0;0;0];
% stc_Mat(:,3) = (abs((K(1:6,1:6)/1.5)^(-1))) * mg * [0.8;0;-1;0;0;0];
% stc_Mat(:,4) = (abs((K(1:6,1:6)/1.5)^(-1))) * mg * [0;0.8;-1;0;0;0];
% stc_Mat(:,5) = (abs((K(1:6,1:6)/1.5)^(-1))) * mg * [0;-0.8;-1;0;0;0];
% stc_Mat(:,6) = (abs((K(1:6,1:6)/1.5)^(-1))) * mg * [0;0;2.5;0;0;0];
% 
% stc_Mat(:,7) = (abs((K(1:6,1:6)/1.5)^(-1))) * mg * [0;0;2.5;0;0;0];
% stc_Mat(:,8) = (abs((K(1:6,1:6)/1.5)^(-1))) * mg * [0;0;2.5;0;0;0];
mat = cell2mat(StaticTests(:,2:end));

stc_Mat = (abs((K(1:6,1:6)/1.5)^(-1))) * mg * [mat';zeros(3,size(mat,1))];

stc = max(stc_Mat,[],2);

f_nat = NF_Calculator(x_main,M(1:6,1:6));

A = [95;95;95;95;95;95]-KED;
B = stc - delta_s;
C = f_nat - f_nat_ub;
D = f_nat_lb - f_nat;

c = [A; B; C; D];
ceq = [];
