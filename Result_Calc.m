function Res = Result_Calc (x, Res_Param)

[K, C] = stiff_cal(x,Res_Param.Eta);
[~, z] = ode45(@eng_mount, 0:Res_Param.TimeStep:Res_Param.FinalTime, Res_Param.InitialState, [], Res_Param.Eng, Res_Param.Mass, C, K);
[F_1, F_2, F_3] = force_cal(x, z, Res_Param.Eta);

Res.K = K;
Res.C = C;
Res.F = [F_1, F_2, F_3];
Res.KEF = KEF_cal(K,Res_Param.Mass);
Res.Freq = NF_Calculator(x ,Res_Param.Mass);
