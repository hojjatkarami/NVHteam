function F = obj_TRA(x,T,F,x_init,T1,  M_e,f_nat_lb,f_nat_ub, a, b, d)
% 960906 Code Readed
% Code must be changed
% C-w^2*M has no meaning

% xx=size(x)
% t11=size(T1)
% xin=size(x_init)
% ff=size(F)
% tt=size(T)
% dd=T1*x'

x = T * (F .* x_init + T1*x');
[K_e,C_e] = stiff_cal(x,1);
w_k_TRA = x(40);
w_c_TRA = x(41);
hyd=sum(T1(41,:));   %1 for hydraulic and 0 for elastomeric config

[q,~] = TRA_finder(M_e(4:6,4:6),[0;1;0]);
q_TRA = [0;0;0;q;0];

A = K_e*q_TRA;
B = w_k_TRA^2*M_e*q_TRA;

% C-w^2*M has no meaning
C = C_e*q_TRA;
D = w_c_TRA^2*M_e*q_TRA;

KEF = KEF_cal(K_e(1:6,1:6),M_e(1:6,1:6));

E = 0;
for j = 1:6
    E = E + (100-max(KEF(:,j)))^2;
%     E = E + heaviside(max(KEF(:,j))-85)^2;           % Must be changed
end

% f_nat_lb = 1.05*[7;7;9;11;11;0];
% f_nat_ub = 0.95*[100;100;11;14;14;18];
f_nat = NF_Calculator(x,M_e(1:6,1:6));
G = 0;
for i = 1:6
    P_low = heaviside(f_nat_lb(i)-f_nat(i))*(f_nat_lb(i)-f_nat(i));
    P_High = heaviside(f_nat(i)-f_nat_ub(i))*(f_nat(i)-f_nat_ub(i));
    G = G + P_low + P_High;
end

F = a*(norm(A-B) + hyd*norm(C-D)) + b*E + d*G; 
