clc
clear
close all

InputParameters
ParameterBounds

%% Initial Response %%
t_step = 0.005;
t_final = 5;
z0 = zeros(14,1);
M = [eng.m*eye(3)  zeros(3,3); zeros(3,3) eng.I];
M_tilda = m_m_1;
M_e = [M, zeros(6,1); zeros(1,6), M_tilda];
[K_e, C_e] = stiff_cal(x_init);
K = K_e(1:6,1:6);
[t, z_init] = ode45(@eng_mount, 0:t_step:t_final, z0, [], eng, M_e, C_e, K_e);
[F_1_init, F_2_init, F_3_init] = force_cal(x_init, z_init);
KEF_init = KEF_cal(K,M);
f_nat_init = NF_Calculator(K,M);

%% TRA Optimization %%
f_nat_lb = [7;7;9;11;11;0];
f_nat_ub = [100;100;11;14;14;18];
delta_s = [25e-3;10e-3;15e-3;1.5*pi/180;4*pi/180;1.5*pi/180;10e-3];
FitnessFcn1 = @(x) TRA2(x, M_e, 0.9, 0.1, 1e8);
fminconOptions = optimoptions(@fmincon,'Display','iter','MaxFunctionEvaluations',50000);
options = optimoptions(@particleswarm,'PlotFcn',{@pswplotbestf},'SwarmSize',1000,'FunctionTolerance',1e-5,'MaxIterations',10000);
%options = optimoptions(options,'HybridFcn',{@fmincon, fminconOptions});
[x_opt1,fval] = particleswarm(FitnessFcn1,40,lb,ub,options);
x_opt1 = x_opt1';
x_opt1_f = fmincon(@(x) TRA2(x, M_e, 1, 0, 0),x_opt1,[],[],[],[],lb-1e-5,ub+1e-5,@(x) nlcn(x, M_e, f_nat_lb, f_nat_ub, delta_s),fminconOptions);
[K_e_opt1, C_e_opt1] = stiff_cal(x_opt1_f);
[~, z_opt1] = ode45(@eng_mount, 0:t_step:t_final, z0, [], eng, M_e, C_e_opt1, K_e_opt1);
[F_1_opt1, F_2_opt1, F_3_opt1] = force_cal(x_opt1_f, z_opt1);
KEF_opt1 = KEF_cal(K_e_opt1(1:6,1:6),M_e(1:6,1:6));
f_nat_opt1 = NF_Calculator(K_e_opt1(1:6,1:6),M_e(1:6,1:6));

% TRA
[~,R_TRA] = TRA_finder(eng.I,[0;1;0]);
z_TRA = zeros(length(t),6);
for i = 1:length(t)
    z_TRA(i,:) = ([R_TRA zeros(3,3); zeros(3,3) R_TRA] * z_opt1(i,1:6)')';
end

%% Transmitted Force Optimization %%
e = 0.2*ones(38,1);
e_TF = e;
lb_2 = x_opt1_f(1:38) - e_TF.*abs(x_opt1_f(1:38));
ub_2 = x_opt1_f(1:38) + e_TF.*abs(x_opt1_f(1:38));
lb_2(19:38) = lb(19:38);
ub_2(19:38) = ub(19:38);

Fhat = [0;0;0;0;eng.max_torque;0;0];
omega = (eng.idle_speed)*pi/15;
FitnessFcn2 = @(x) TF2(x, omega, Fhat, M_e, 0.9, 0.1, 1e8);
[x_opt2,~] = particleswarm(FitnessFcn2,38,lb_2,ub_2,options);
x_opt2 = x_opt2';
x_opt2_f = fmincon(@(x) TF2(x, omega, Fhat, M_e, 1, 0, 0),x_opt2,[],[],[],[],lb_2-1e-5,ub_2+1e-5,@(x) nlcn(x, M_e, f_nat_lb, f_nat_ub, delta_s),fminconOptions);

[K_e_opt2, C_e_opt2] = stiff_cal(x_opt2_f);
[~, z_opt2] = ode45(@eng_mount, 0:t_step:t_final, z0, [], eng, M_e, C_e_opt2, K_e_opt2);
[F_1_opt2, F_2_opt2, F_3_opt2] = force_cal(x_opt2_f, z_opt2);
KEF_opt2 = KEF_cal(K_e_opt2(1:6,1:6),M_e(1:6,1:6));
f_nat_opt2 = NF_Calculator(K_e_opt2(1:6,1:6),M_e(1:6,1:6));

%% Transmitted Vibration Optimization %%
e_TV = e;
lb_3 = x_opt2_f(1:38) - e_TV.*abs(x_opt2_f(1:38));
ub_3 = x_opt2_f(1:38) + e_TV.*abs(x_opt2_f(1:38));
lb_2(19:38) = lb(19:38);
ub_2(19:38) = ub(19:38);

FitnessFcn3 = @(x) TA2(x, omega, Fhat, M_e, sus, 100, 1, 1e8);
[x_opt3,~] = particleswarm(FitnessFcn3,38,lb_3,ub_3,options);
x_opt3 = x_opt3';
x_opt3_f = fmincon(@(x) TA2(x, omega, Fhat, M_e, sus, 1, 0, 0),x_opt3,[],[],[],[],lb_3-1e-5,ub_3+1e-5,@(x) nlcn(x, M_e, f_nat_lb, f_nat_ub, delta_s),fminconOptions);

[K_e_opt3, C_e_opt3] = stiff_cal(x_opt3_f);
[~, z_opt3] = ode45(@eng_mount, 0:t_step:t_final, z0, [], eng, M_e, C_e_opt3, K_e_opt3);
[F_1_opt3, F_2_opt3, F_3_opt3] = force_cal(x_opt3_f, z_opt3);
KEF_opt3 = KEF_cal(K_e_opt3(1:6,1:6),M_e(1:6,1:6));
f_nat_opt3 = NF_Calculator(K_e_opt3(1:6,1:6),M_e(1:6,1:6));