function Res = Result_Calc2 (x, eng,sus, obj)



Res.TimeStep = 0.05;
Res.FinalTime = 2;
Res.InitialState = zeros(14,1);
Res.Mass = eng.M_e;

Eng.max_torque = eng.torque(1);
Eng.idle_speed = eng.rpm(1);
[K,C] = stiff_cal(x,1);

[~, z] = ode45(@eng_mount, 0:Res.TimeStep:Res.FinalTime, Res.InitialState, [], Eng, Res.Mass, C, K);
[F_1, F_2, F_3] = force_cal2(x,z);

Res.K = K;
Res.C = C;
Res.F = [F_1, F_2, F_3];
Res.KED = KEF_cal(K(1:6,1:6),Res.Mass(1:6,1:6));
Res.Freq = NF_Calculator(x, Res.Mass(1:6,1:6));


Res.val_TRA = obj_TRA_pure(x, Res.Mass(1:6,1:6), K);
Res.val_TF = obj_TF_pure(x,obj.TF.dir, obj.TF.method, eng.rpm, eng.torque, Res.Mass(1:6,1:6),K(1:6,1:6),C(1:6,1:6));
Res.val_TA = obj_TA_pure(x,obj.TA.dir, obj.TA.method, eng.rpm, eng.torque, Res.Mass(1:6,1:6),sus);
Res.val_Ar = obj_Ar_pure(x,obj.Ar.dir, obj.Ar.method, eng.rpm, eng.torque, Res.Mass(1:6,1:6),sus);
Res.val_NF = obj_NF(x,  Res.Mass(1:6,1:6),obj.NF.lb_freq',obj.NF.ub_freq');
Res.val_KED = obj_KED(K(1:6,1:6),  Res.Mass(1:6,1:6),obj.KED.percent);
Res.val_ST = obj_ST(x,Res.Mass(1:6,1:6),K(1:6,1:6), obj.ST.DeltaStatic, obj.ST.StaticTests, 1.5);

% [Res.pur_TRA, Res.pur_TF, Res.pur_TA, Res.pur_Ar, Res.pur_NF, Res.pur_KED]=purturb(k.run);
