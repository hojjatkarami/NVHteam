%% In the name of Allah the beneficent the merciful
% This Code is the core of NVE Application
% The code is written by NVE Team on 1396/05/21

%% Clearing
clc; clear; close all

%% Parameters %%
BodyProperties
EngineProperties
MountProperties

%% Result Options
Result_Parameters.Eta = eta;
Result_Parameters.TimeStep = 0.005;
Result_Parameters.FinalTime = 5;
Result_Parameters.InitialState = zeros(12,1);
Result_Parameters.Eng = eng;
Result_Parameters.Mass = M;

%% Initial Response %%
Res_Initial = Result_Calc(x_init, Result_Parameters);

%% TRA Optimization %%
TRA_Options.DeltaStatic = [25e-3;10e-3;15e-3;1.5*pi/180;4*pi/180;1.5*pi/180];
TRA_Options.TRAWeight = 0.9;
TRA_Options.KEDWeight = 0.1;
TRA_Options.PenFuncWeight = 1e8;
TRA_Options.Lb = lb;
TRA_Options.Ub = ub;
TRA_Options.SwarmSize = 1000;
TRA_Options.MaxFuncEval = 50000;
TRA_Options.FuncTol = 1e-5;
TRA_Options.MaxIter = 10000;
TRA_Options.FreqLowerBound = f_nat_lb;
TRA_Options.FreqUpperBound = f_nat_ub;
TRA_Options.Mass = M;

[x_opt_TRA, Fval_TRA] = TRA_Optimizer(TRA_Options);
Res_TRA = Result_Calc(x_opt_TRA, Result_Parameters);
TRA(x_opt_TRA, Result_Parameters.Mass, 1, 0, 0)

%% Transmitted Force Optimization %%
TF_Options.DeltaStatic = [25e-3;10e-3;15e-3;1.5*pi/180;4*pi/180;1.5*pi/180];
TF_Options.TFWeight = 0.9;
TF_Options.KEDWeight = 0.1;
TF_Options.PenFuncWeight = 1e8;
TF_Options.Lb = lb(1:27);
TF_Options.Ub = ub(1:27);
TF_Options.SwarmSize = 1000;
TF_Options.MaxFuncEval = 50000;
TF_Options.FuncTol = 1e-5;
TF_Options.MaxIter = 10000;
TF_Options.FreqLowerBound = f_nat_lb;
TF_Options.FreqUpperBound = f_nat_ub;
TF_Options.Mass = M;
TF_Options.Eta = eta;
TF_Options.Omega = omega;
TF_Options.Fhat = Fhat;
TF_Options.CompSelector=[1; 1; 1;...
                         1; 1; 1;...
                         1; 1; 1];    % dim(3*3):used to choose which directions are going to be accounted [F_1_x,F_1_y,F_1_z,F_1_mag,F_2_x,...]
TF_Options.OptTypeSelector = [1; 0; 0]; %This variable could be [1; 0; 0], [0; 1; 0] or [0; 0; 1] for 'max', 'sum' or 'norm', default value is 'max'!

% e = 0.2*ones(27,1);
% e_TF = e;
% lb_2 = x_opt1_f(1:27) - e_TF.*abs(x_opt1_f(1:27));
% ub_2 = x_opt1_f(1:27) + e_TF.*abs(x_opt1_f(1:27));

[x_opt_TF, Fval_TF] = TF_Optimizer(TF_Options);
Res_TF = Result_Calc(x_opt_TF, Result_Parameters);

%% Transmitted Acceleration Optimization %%
TA_Options.DeltaStatic = [25e-3;10e-3;15e-3;1.5*pi/180;4*pi/180;1.5*pi/180];
TA_Options.TAWeight = 0.9;
TA_Options.KEDWeight = 0.1;
TA_Options.PenFuncWeight = 1e8;
TA_Options.Lb = lb(1:27);
TA_Options.Ub = ub(1:27);
TA_Options.SwarmSize = 1000;
TA_Options.MaxFuncEval = 50000;
TA_Options.FuncTol = 1e-5;
TA_Options.MaxIter = 10000;
TA_Options.FreqLowerBound = f_nat_lb;
TA_Options.FreqUpperBound = f_nat_ub;
TA_Options.Mass = M;
TA_Options.SuspensionStruct = sus;
TA_Options.Eta = eta;
TA_Options.Omega = omega;
TA_Options.Fhat = Fhat;
TA_Options.MountSelector=[1; 1; 1];    % dim(3*1):used to choose which directions are going to be accounted [mount1, mount2, mount3]
TA_Options.OptTypeSelector = [1; 0; 0]; %This variable could be [1; 0; 0], [0; 1; 0] or [0; 0; 1] for 'max', 'sum' or 'norm', default value is 'max'!

[x_opt_TA, Fval_TA] = TA_Optimizer(TA_Options);
Res_TA = Result_Calc(x_opt_TA, Result_Parameters);

%% Acceleration ratio (Ar) Optimization %%
Ar_Options.DeltaStatic = [25e-3;10e-3;15e-3;1.5*pi/180;4*pi/180;1.5*pi/180];
Ar_Options.TVWeight = 0.9;
Ar_Options.KEDWeight = 0.1;
Ar_Options.PenFuncWeight = 1e8;
Ar_Options.Lb = lb(1:27);
Ar_Options.Ub = ub(1:27);
Ar_Options.SwarmSize = 1000;
Ar_Options.MaxFuncEval = 50000;
Ar_Options.FuncTol = 1e-5;
Ar_Options.MaxIter = 10000;
Ar_Options.FreqLowerBound = f_nat_lb;
Ar_Options.FreqUpperBound = f_nat_ub;
Ar_Options.Mass = M;
Ar_Options.SuspensionStruct = sus;
Ar_Options.Eta = eta;
Ar_Options.Omega = omega;
Ar_Options.Fhat = Fhat;
Ar_Options.MountSelector = [1; 1; 1];   % dim(3*1):used to choose which directions are going to be accounted [F_1_x,F_1_y,F_1_z,F_1_mag,F_2_x,...]
Ar_Options.OptTypeSelector = [1; 0; 0]; % This variable could be [1; 0; 0], [0; 1; 0] or [0; 0; 1] for 'max', 'sum' or 'norm', default value is 'max'!

[x_opt_Ar, Fval_Ar] = Ar_Optimizer(Ar_Options);
Res_Ar = Result_Calc(x_opt_Ar, Result_Parameters);

% End of Code