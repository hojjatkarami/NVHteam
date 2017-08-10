function F = Ar_pure(x, eta, w, f, M, sus)

r_1 = x(1:3);
r_2 = x(4:6);
r_3 = x(7:9);
R_1 = sus.E_cm + r_1;
R_2 = sus.E_cm + r_2;
R_3 = sus.E_cm + r_3;

[M_v,C_v,K_v] = BodyParameters(sus,M,x,eta);
q_hat = (-w^2*M_v+1i*w*C_v+K_v)^(-1)*[zeros(7,1);f];

% A = abs(-w^2*([zeros(1,4) 1 zeros(1,8)]-[zeros(1,6) R_1(1) zeros(1,6)]+[zeros(1,5) R_1(2) zeros(1,7)])*q_hat) ...
%     +abs(-w^2*([zeros(1,4) 1 zeros(1,8)]-[zeros(1,6) R_2(1) zeros(1,6)]+[zeros(1,5) R_2(2) zeros(1,7)])*q_hat)...
%     +abs(-w^2*([zeros(1,4) 1 zeros(1,8)]-[zeros(1,6) R_3(1) zeros(1,6)]+[zeros(1,5) R_3(2) zeros(1,7)])*q_hat);

A = max([abs((-w^2*([zeros(1,4) 1 zeros(1,8)]-[zeros(1,6) R_1(1) zeros(1,6)]+[zeros(1,5) R_1(2) zeros(1,7)])*q_hat)/...
    (-w^2*([zeros(1,9) 1 zeros(1,3)]-[zeros(1,11) r_1(1) zeros(1,1)]+[zeros(1,10) r_1(2) zeros(1,2)])*q_hat)) ...
    ,abs((-w^2*([zeros(1,4) 1 zeros(1,8)]-[zeros(1,6) R_2(1) zeros(1,6)]+[zeros(1,5) R_2(2) zeros(1,7)])*q_hat)/...
    (-w^2*([zeros(1,9) 1 zeros(1,3)]-[zeros(1,11) r_2(1) zeros(1,1)]+[zeros(1,10) r_2(2) zeros(1,2)])*q_hat))...
    ,abs((-w^2*([zeros(1,4) 1 zeros(1,8)]-[zeros(1,6) R_3(1) zeros(1,6)]+[zeros(1,5) R_3(2) zeros(1,7)])*q_hat)/...
    (-w^2*([zeros(1,9) 1 zeros(1,3)]-[zeros(1,11) r_3(1) zeros(1,1)]+[zeros(1,10) r_3(2) zeros(1,2)])*q_hat))]);


F = A;
