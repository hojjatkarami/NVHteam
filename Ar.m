%% Acceleration ratio (Ar) Optimization %%
function Ar(stage)
load('workspace.mat')
Ar_Options.DeltaStatic = g.DeltaStatic;
Ar_Options.TVWeight = 0.9;
Ar_Options.KEDWeight = 0.1;
Ar_Options.PenFuncWeight = stage.PenFuncWeight;
Ar_Options.Lb = lb(1:27);
Ar_Options.Ub = ub(1:27);
Ar_Options.SwarmSize = stage.swarmsize;
Ar_Options.MaxFuncEval = stage.MaxFuncEval;
Ar_Options.FuncTol = stage.FuncTol;
Ar_Options.MaxIter = stage.MaxIter;
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


end