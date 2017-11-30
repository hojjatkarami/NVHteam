function Res = Result_Calc (stage, eng)

x_opt_partial = stage.x_opt_partial;
T = stage.T;
T1 = stage.T1;
F = stage.F;
x_init = stage.x_init;
option = stage.option;
hyd=sum(T1(41,:));   %1 for hydraulic and 0 for elastomeric config


Res.TimeStep = 0.05;
Res.FinalTime = 2;
Res.InitialState = zeros(14,1);
Res.Mass = eng.M_e;

Eng.max_torque = eng.torque(1);
Eng.idle_speed = eng.rpm(1);
[K,C] = stiff_cal(stage.x_opt,1);

[~, z] = ode45(@eng_mount, 0:Res.TimeStep:Res.FinalTime, Res.InitialState, [], Eng, Res.Mass, C, K);
[F_1, F_2, F_3] = force_cal(stage.x_opt, z,hyd);

Res.K = K;
Res.C = C;
Res.F = [F_1, F_2, F_3];
Res.KED = KEF_cal(K(1:6,1:6),Res.Mass(1:6,1:6));
Res.Freq = NF_Calculator(stage.x_opt, Res.Mass(1:6,1:6));


%Res.val_TRA = obj_TRA(x_opt_partial',T,F,x_init,T1, option.Mass, option.FreqLowerBound, option.FreqUpperBound, 1, 0, 0);
% Res.val_TF = obj_TF(x_opt_partial',T,F,x_init,T1 ,option.TF_CompSelector, option.TF_OptTypeSelector, option.rpm,...
%                             option.torque, option.Mass, 1, 0,0);
% Res.val_TA = obj_TF(x_opt_partial',T,F,x_init,T1 ,option.TA_CompSelector, option.TA_OptTypeSelector, option.rpm,...
%                             option.torque, option.Mass, 1, 0,0);
% Res.val_Ar = obj_TF(x_opt_partial',T,F,x_init,T1 ,option.Ar_CompSelector, option.Ar_OptTypeSelector, option.rpm,...
%                             option.torque, option.Mass, 1, 0,0);