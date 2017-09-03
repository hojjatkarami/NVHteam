%% Transmitted Acceleration Optimization %%
function TA(stage)
load('workspace.mat')
TA_Options.DeltaStatic = g.DeltaStatic;
TA_Options.TAWeight = 0.9;
TA_Options.KEDWeight = 0.1;
TA_Options.PenFuncWeight = stage.PenFuncWeight;
TA_Options.Lb = lb(1:27);
TA_Options.Ub = ub(1:27);
TA_Options.SwarmSize = stage.swarmsize;
TA_Options.MaxFuncEval = stage.MaxFuncEval;
TA_Options.FuncTol = stage.FuncTol;
TA_Options.MaxIter = stage.MaxIter;
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

end