function Res = Result_Calc (stage, Res_Param)


Eng.max_torque = Res_Param.Eng.torque(1);
Eng.idle_speed = Res_Param.Eng.rpm(1);
[K,C] = stiff_cal(stage.x_opt,1);
[~, z] = ode45(@eng_mount, 0:Res_Param.TimeStep:Res_Param.FinalTime, Res_Param.InitialState, [], Eng, Res_Param.Mass, C, K);
[F_1, F_2, F_3] = force_cal(stage.x_opt, z);

Res.K = K;
Res.C = C;
Res.F = [F_1, F_2, F_3];
Res.KED = KEF_cal(K,Res_Param.Mass);
Res.Freq = NF_Calculator(stage.x_opt, Res_Param.Mass);

x_opt_partial = stage.x_opt_partial;
T = stage.T;
T1 = stage.T1;
F = stage.F;
x_init = stage.x_init;
option = stage.option;
Res.val_TRA = obj_TRA(x_opt_partial',T,F,x_init,T1, option.Mass, 1, 0, 0);
Res.val_TF = obj_TF(x_opt_partial',T,F,x_init,T1 ,option.TF_CompSelector, option.TF_OptTypeSelector, option.rpm,...
                            option.torque, option.Mass, 1, 0,0);
Res.val_TA = obj_TF(x_opt_partial',T,F,x_init,T1 ,option.TA_CompSelector, option.TA_OptTypeSelector, option.rpm,...
                            option.torque, option.Mass, 1, 0,0);
Res.val_Ar = obj_TF(x_opt_partial',T,F,x_init,T1 ,option.Ar_CompSelector, option.Ar_OptTypeSelector, option.rpm,...
                            option.torque, option.Mass, 1, 0,0);