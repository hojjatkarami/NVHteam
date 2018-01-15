function [per_TRA, per_TF, per_TA, per_Ar, per_NF, per_KED]=purturb(run)

TRA=zeros(100,1); TF=zeros(100,1); TA=zeros(100,1); Ar=zeros(100,1); NF=zeros(100,1); KED=zeros(100,1);
x_opt = run.stage(1).x_opt;
delta = [0.01*ones(9,1); 0.02*ones(9,1); 10000*ones(9,1); 100*ones(9,1);0;0;0;0;0];%m rad N/m
M = run.eng.M;
sus = run.sus;
w = run.stage0.eng.rpm;
f = run.stage0.eng.torque;
TFComponentSelector=run.stage(1).obj.TF.dir; TFOptTypeSelector=run.stage(1).obj.TF.method;
ArComponentSelector=run.stage(1).obj.Ar.dir; ArOptTypeSelector=run.stage(1).obj.Ar.method;
TAComponentSelector=run.stage(1).obj.TA.dir; TAOptTypeSelector=run.stage(1).obj.TA.method;
f_nat_lb=run.stage(1).obj.NF.lb_freq';     f_nat_ub=run.stage(1).obj.NF.ub_freq';
KED_cr=run.stage(1).obj.KED.percent;

for i=1:100
   x_purturb = x_opt + (2*rand-1)*delta;
   [K_e,C_e] = stiff_cal(x_purturb,1);
   K=K_e(1:6,1:6);  C=C_e(1:6,1:6);
   TRA(i) = obj_TRA_pure(x_purturb, M, K);
   TF(i)= obj_TF_pure(x_purturb, TFComponentSelector, TFOptTypeSelector, w, f, M,K,C);
   TA(i) = obj_TA_pure(x_purturb, TAComponentSelector, TAOptTypeSelector, w, f, M,sus);
   Ar(i) = obj_Ar_pure(x_purturb, ArComponentSelector, ArOptTypeSelector, w, f, M,sus);
   NF(i) = obj_NF(x_purturb, M,f_nat_lb,f_nat_ub);
   KED(i) = obj_KED(K, M,KED_cr);
end


% per_TRA = std(TRA)/mean(TRA)*100;
% per_TF = std(TF)/mean(TF)*100;
% per_Ar = std(Ar)/mean(Ar)*100;
% per_TA = std(TA)/mean(TA)*100;
% per_NF = std(NF)/mean(NF)*100;
% per_KED = std(KED)/mean(KED)*100;
per_TRA = std(TRA)/run.stage(1).results.val_TRA*100;
per_TF = std(TF)/run.stage(1).results.val_TF*100;
per_Ar = std(Ar)/run.stage(1).results.val_Ar*100;
per_TA = std(TA)/run.stage(1).results.val_TA*100;
per_NF = std(NF)/run.stage(1).results.val_NF*100;
per_KED = std(KED)/run.stage(1).results.val_KED*100;

end