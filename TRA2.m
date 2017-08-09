function F = TRA2(x, M, a, b, d, r_1,r_2)

[K,~] = stiff_cal([r_1',r_2',x],0);
w_TRA = x(22);

[q_TRA,~] = TRA_finder(M(4:6,4:6),[0;1;0]);
q_TRA = [0;0;0;q_TRA];
A = K*q_TRA;
B = w_TRA^2*M*q_TRA;


F = a*norm(A-B);