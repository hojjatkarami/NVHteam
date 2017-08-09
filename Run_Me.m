clc
clear
close all

%% Parameters %%
InputParameters
ParameterBounds
Pen_Wt = 1e8;

%% Initial Response %%
x_init = [r_1;r_2;r_3;o_1;o_2;o_3;k_l_1;k_l_2;k_l_3];
t_step = 0.005;
t_final = 5;
z0 = zeros(12,1);
M = [eng.m*eye(3)  zeros(3,3); zeros(3,3) eng.I];
[K, C] = stiff_cal(x_init,eta);

[t, z_init] = ode45(@eng_mount, 0:t_step:t_final, z0, [], eng, M, C, K);
[F_1_init, F_2_init, F_3_init] = force_cal(x_init, z_init, eta);
KEF_init = KEF_cal(K,M);
f_nat_init = NF_Calculator(x_init,M);

%% Body Parameters %%
[M_v,C_v,K_v] = BodyParameters(sus,M,x_init,eta);

%% TRA Optimization %%
f_nat_lb = [7;7;9;11;11;0];
f_nat_ub = [100;100;11;14;14;18];
delta_s = [25e-3;10e-3;15e-3;1.5*pi/180;4*pi/180;1.5*pi/180];
FitnessFcn1 = @(x) TRA1(x, M, 0.9, 0.1, Pen_Wt);
fminconOptions = optimoptions(@fmincon,'Display','iter','MaxFunctionEvaluations',50000);
options = optimoptions(@particleswarm,'PlotFcn',{@pswplotbestf},'SwarmSize',1000,'FunctionTolerance',1e-5,'MaxIterations',10000);
%     options = optimoptions(options,'HybridFcn',{@fmincon, fminconOptions});
[x_opt1,fval] = particleswarm(FitnessFcn1,28,lb,ub,options);
x_opt1 = x_opt1';
FitnessFcn11 = @(x) TRA_pure(x, M);
x_opt1_f = fmincon(FitnessFcn11,x_opt1,[],[],[],[],lb-1e-5,ub+1e-5,@(x) nlcn(x, M, f_nat_lb, f_nat_ub, delta_s),fminconOptions);

[K_opt1, C_opt1] = stiff_cal(x_opt1_f,eta);
[~, z_opt1] = ode45(@eng_mount, 0:t_step:t_final, z0, [], eng, M, C_opt1, K_opt1);
[F_1_opt1, F_2_opt1, F_3_opt1] = force_cal(x_opt1_f, z_opt1, eta);
KEF_opt1 = KEF_cal(K_opt1,M);
f_nat_opt1 = NF_Calculator(x_opt1_f,M);
TRA_Value = TRA1(x_opt1_f, M, 1, 0, 0)

%% Transmitted Force Optimization %%
% e = 0.2*ones(27,1);
% e_TF = e;
% lb_2 = x_opt1_f(1:27) - e_TF.*abs(x_opt1_f(1:27));
% ub_2 = x_opt1_f(1:27) + e_TF.*abs(x_opt1_f(1:27));
% lb_2(19:27) = lb(19:27);
% ub_2(19:27) = ub(19:27);
lb_2 = lb(1:27) ;
ub_2 = ub(1:27) ;

Fhat = [0;0;0;0;eng.max_torque;0];
omega = (eng.idle_speed)*pi/15;
FitnessFcn2 = @(x) TF1(x, eta, omega, Fhat, M, 0.9, 0.1, Pen_Wt);
options = optimoptions(@particleswarm,'PlotFcn',{@pswplotbestf},'SwarmSize',5000,'FunctionTolerance',1e-5,'MaxIterations',10000);
[x_opt2,~] = particleswarm(FitnessFcn2,27,lb_2,ub_2,options);
x_opt2 = x_opt2';
FitnessFcn22 = @(x) TF_pure(x, eta, omega, Fhat, M);
fminconOptions = optimoptions(@fmincon,'Display','iter','MaxFunctionEvaluations',50000);
x_opt2_f = fmincon(FitnessFcn22,x_opt2,[],[],[],[],lb_2-1e-5,ub_2+1e-5,@(x) nlcn(x, M, f_nat_lb, f_nat_ub, delta_s),fminconOptions);

[K_opt2, C_opt2] = stiff_cal(x_opt2_f,eta);
[~, z_opt2] = ode45(@eng_mount, 0:t_step:t_final, z0, [], eng, M, C_opt2, K_opt2);
[F_1_opt2, F_2_opt2, F_3_opt2] = force_cal(x_opt2_f, z_opt2, eta);
KEF_opt2 = KEF_cal(K_opt2,M);
f_nat_opt2 = NF_Calculator(x_opt2_f,M);

%% Transmitted Vibration Optimization %%
e_TV = e/2;
lb_3 = x_opt2_f(1:27) - e_TV.*abs(x_opt2_f(1:27));
ub_3 = x_opt2_f(1:27) + e_TV.*abs(x_opt2_f(1:27));

FitnessFcn3 = @(x) TV1(x, eta, omega, Fhat, M, sus, 100, 1, Pen_Wt);
[x_opt3,~] = particleswarm(FitnessFcn3,27,lb_3,ub_3,options);
x_opt3 = x_opt3';
FitnessFcn33 = @(x) TV_pure(x, eta, omega, Fhat, M, sus);
x_opt3_f = fmincon(FitnessFcn33,x_opt3,[],[],[],[],lb_3-1e-5,ub_3+1e-5,@(x) nlcn(x, M, f_nat_lb, f_nat_ub, delta_s),fminconOptions);

[K_opt3, C_opt3] = stiff_cal(x_opt3_f,eta);
[~, z_opt3] = ode45(@eng_mount, 0:t_step:t_final, z0, [], eng, M, C_opt3, K_opt3);
[F_1_opt3, F_2_opt3, F_3_opt3] = force_cal(x_opt3_f, z_opt3, eta);
KEF_opt3 = KEF_cal(K_opt3,M);
f_nat_opt3 = NF_Calculator(x_opt3_f,M);

