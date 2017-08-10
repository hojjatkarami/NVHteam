% this is a new comment
clc; clear; close all

%% Parameters %%
BodyProperties
EngineProperties
MountProperties
ParameterBounds

Pen_Wt = 1e8;


%% Initial Response %%
x_init = [r_1;r_2;r_3;o_1;o_2;o_3;k_l_1;k_l_2;k_l_3];
t_step = 0.005;
t_final = 5;
z0 = zeros(12,1);

[K, C] = stiff_cal(x_init,eta);

[t, z_init] = ode45(@eng_mount, 0:t_step:t_final, z0, [], eng, M, C, K);
[F_1_init, F_2_init, F_3_init] = force_cal(x_init, z_init, eta);
KEF_init = KEF_cal(K,M);
f_nat_init = NF_Calculator(x_init,M);

%% Body Parameters %%
[M_v,C_v,K_v] = BodyParameters(sus,M,x_init,eta);

%% TRA Optimization %%
TRA_options.delta_s = [25e-3;10e-3;15e-3;1.5*pi/180;4*pi/180;1.5*pi/180];
TRA_options.TRAweight = 0.9;
TRA_options.KEDweight = 0.1;
TRA_options.PenFuncweight = 1e8;
TRA_options.lb = lb;
TRA_options.ub = ub;
TRA_options.swarmsize = 1000;
TRA_options.MaxFuncEval = 50000;
TRA_options.FuncTol = 1e-5;
TRA_options.MaxIter = 10000;
TRA_options.f_nat_lb = f_nat_lb;
TRA_options.f_nat_ub = f_nat_ub;
TRA_options.M = M;

[x_opt_TRA, fval] = TRA_Optimizer(TRA_options);
Res_TRA = Result_Calc(x_opt_TRA, eta, t_step, t_final, z0, eng, M);

%% Transmitted Force Optimization %%
TFmatrix=diag([1 1 1 0,...
                1 1 1 0,...
                1 1 1 0]);    % dim(1*12):used to choose which directions are going to be accounted [F_1_x,F_1_y,F_1_z,F_1_mag,F_2_x,...]
TFoption = 'max'; %This variable could be 'max' or 'sum' , default value is 'max'!
% e = 0.2*ones(27,1);
% e_TF = e;
% lb_2 = x_opt1_f(1:27) - e_TF.*abs(x_opt1_f(1:27));
% ub_2 = x_opt1_f(1:27) + e_TF.*abs(x_opt1_f(1:27));
lb_2 = lb(1:27) ;
ub_2 = ub(1:27) ;

FitnessFcn2 = @(x) TF(x, TFmatrix, TFoption, eta, omega, Fhat, M, 0.9, 0.1, Pen_Wt);
PSOoptions = optimoptions(@particleswarm,'PlotFcn',{@pswplotbestf},'SwarmSize',5000,'FunctionTolerance',1e-5,'MaxIterations',10000);
[x_opt2,~] = particleswarm(FitnessFcn2,27,lb_2,ub_2,PSOoptions);
x_opt2 = x_opt2';
FitnessFcn22 = @(x) TF(x, TFmatrix, TFoption, eta, omega, Fhat, M, 1, 0, 0);
fminconOptions = optimoptions(@fmincon,'Display','iter','MaxFunctionEvaluations',50000);
x_opt2_f = fmincon(FitnessFcn22,x_opt2,[],[],[],[],lb_2-1e-5,ub_2+1e-5,@(x) nlcn(x, M, f_nat_lb, f_nat_ub, delta_s),fminconOptions);

[K_opt2, C_opt2] = stiff_cal(x_opt2_f,eta);
[~, z_opt2] = ode45(@eng_mount, 0:t_step:t_final, z0, [], eng, M, C_opt2, K_opt2);
[F_1_opt2, F_2_opt2, F_3_opt2] = force_cal(x_opt2_f, z_opt2, eta);
KEF_opt2 = KEF_cal(K_opt2,M);
f_nat_opt2 = NF_Calculator(x_opt2_f,M);

%% Acceleration ratio (Ar) Optimization %%
e_Ar = 0.2*ones(27,1);
e_Ar = e_Ar/2;
lb_3 = x_opt2_f(1:27) - e_Ar.*abs(x_opt2_f(1:27));
ub_3 = x_opt2_f(1:27) + e_Ar.*abs(x_opt2_f(1:27));

FitnessFcn3 = @(x) Ar(x, eta, omega, Fhat, M, sus, 100, 1, Pen_Wt);
[x_opt3,~] = particleswarm(FitnessFcn3,27,lb_3,ub_3,options);
x_opt3 = x_opt3';
FitnessFcn33 = @(x) Ar(x, eta, omega, Fhat, M, sus, 1, 0, 0);
x_opt3_f = fmincon(FitnessFcn33,x_opt3,[],[],[],[],lb_3-1e-5,ub_3+1e-5,@(x) nlcn(x, M, f_nat_lb, f_nat_ub, delta_s),fminconOptions);

[K_opt3, C_opt3] = stiff_cal(x_opt3_f,eta);
[~, z_opt3] = ode45(@eng_mount, 0:t_step:t_final, z0, [], eng, M, C_opt3, K_opt3);
[F_1_opt3, F_2_opt3, F_3_opt3] = force_cal(x_opt3_f, z_opt3, eta);
KEF_opt3 = KEF_cal(K_opt3,M);
f_nat_opt3 = NF_Calculator(x_opt3_f,M);

