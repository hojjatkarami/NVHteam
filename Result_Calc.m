function Res = Result_Calc (x_main,T, Res_Param)


[K,C] = stiff_cal(x_main,T);
[~, z] = ode45(@eng_mount, 0:Res_Param.TimeStep:Res_Param.FinalTime, Res_Param.InitialState, [], Res_Param.Eng, Res_Param.Mass, C, K);
[F_1, F_2, F_3] = force_cal(x_main,T, z);

Res.K = K;
Res.C = C;
Res.F = [F_1, F_2, F_3];
Res.KED = KEF_cal(K,Res_Param.Mass);
Res.Freq = NF_Calculator(x_main,T ,Res_Param.Mass);



