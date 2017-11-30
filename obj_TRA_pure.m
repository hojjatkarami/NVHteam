function Fval = obj_TRA_pure(x, M_e, K_e)
% 960906 Code Readed
% Code must be changed
% C-w^2*M has no meaning

% xx=size(x)
% t11=size(T1)
% xin=size(x_init)
% ff=size(F)
% tt=size(T)
% dd=T1*x'

w_k_TRA = x(40);

[q,~] = TRA_finder(M_e(4:6,4:6),[0;1;0]);
q_TRA = [0;0;0;q];

A = K_e(1:6,1:6)*q_TRA;
B = w_k_TRA^2*M_e(1:6,1:6)*q_TRA;

Fval = norm(A-B); 


end
