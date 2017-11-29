function F = nlcn(x,T,F,x_init,T1, M_e, f_nat_lb, f_nat_ub, delta_s, StaticTests, st2dy, KEDcr)
% 960908 Code Readed

x_main = T * (F .* x_init + T1*x');
[K,~] = stiff_cal(x_main,1);

KEF = KEF_cal(K(1:6,1:6),M_e(1:6,1:6));

KED = max(KEF)';

% best_index = zeros(6,1);
% for j = 1:6 
%     [~,best_index(j)] = max(KEF(:,j));
% end

% KED = [KEF(best_index(1),1); KEF(best_index(2),2); KEF(best_index(3),3); KEF(best_index(4),4); KEF(best_index(5),5); KEF(best_index(6),6)];

% stc_Mat = zeros(6,8);


mg = M_e(1,1)*9.81;

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


stc_Mat = (abs((K(1:6,1:6)/st2dy)^(-1))) * mg * [mat';zeros(3,size(mat,1))];

% stc = max(stc_Mat')';
stc = max(stc_Mat,[],2);

f_nat = NF_Calculator(x_main,M_e(1:6,1:6));

A = sum((KEDcr*ones(6,1)-KED).^2);

B = stc - delta_s;
P_s = heaviside(B)'*B;

C = f_nat - f_nat_ub;
D = f_nat_lb - f_nat;
P_low = heaviside(D)'*D;
P_High = heaviside(C)'*C;
G =  P_low + P_High;

F = a*A + b*P_s + c*G;

