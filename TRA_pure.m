function F = TRA_pure(x, M)

[K,~] = stiff_cal(x,0);
w_TRA = x(28);

[q_TRA,~] = TRA_finder(M(4:6,4:6),[0;1;0]);
q_TRA = [0;0;0;q_TRA];
A = K*q_TRA;
B = w_TRA^2*M*q_TRA;

F = norm(A-B);