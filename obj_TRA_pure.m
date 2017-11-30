function Fval = obj_TRA_pure(x, M_e, K_e)

w_k_TRA = x(40);

[q,~] = TRA_finder(M_e(4:6,4:6),[0;1;0]);
q_TRA = [0;0;0;q];

A = K_e(1:6,1:6)*q_TRA;
B = w_k_TRA^2*M_e(1:6,1:6)*q_TRA;

Fval = norm(A-B); 


end
