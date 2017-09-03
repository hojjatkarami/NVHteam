%% TRA Optimization %%
function TRA(stage)

% cmd('TRA ')
load('workspace.mat')
TRA_Options.DeltaStatic = eng.DeltaStatic;
TRA_Options.TRAWeight = 0.9;
TRA_Options.KEDWeight = 0.1;
TRA_Options.PenFuncWeight = stage.PenFuncWeight;
TRA_Options.Lb = lb;
TRA_Options.Ub = ub;
TRA_Options.SwarmSize = stage.swarmsize;
TRA_Options.MaxFuncEval = stage.MaxFuncEval;
TRA_Options.FuncTol = stage.FuncTol;
TRA_Options.MaxIter = stage.MaxIter;
TRA_Options.FreqLowerBound = f_nat_lb;
TRA_Options.FreqUpperBound = f_nat_ub;
TRA_Options.Mass = eng.M;

[x_opt_TRA, Fval_TRA] = TRA_Optimizer(TRA_Options);

Res_TRA = Result_Calc(x_opt_TRA, Result_Parameters);
TRA_pure = obj_TRA(x_opt_TRA, Result_Parameters.Mass, 1, 0, 0);
cmd(['pure TRA value is : ',num2str(TRA_pure)]);
end
