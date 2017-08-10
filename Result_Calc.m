function Res = Result_Calc (x, eta, t_step, t_final, z0, eng, M)

[K, C] = stiff_cal(x,eta);
[~, z] = ode45(@eng_mount, 0:t_step:t_final, z0, [], eng, M, C, K);
[F_1, F_2, F_3] = force_cal(x, z, eta);
Res.K = K;
Res.C = C;

Res.F = [F_1, F_2, F_3];
Res.KEF = KEF_cal(K,M);
Res.freq = NF_Calculator(x ,M);
Res.TRA_Value = TRA(x, M, 1, 0, 0);

