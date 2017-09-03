%% Transmitted Force Optimization %%
function TF(stage)
load('workspace.mat')
TF_Options.DeltaStatic = g.DeltaStatic;
TF_Options.TFWeight = 0.9;
TF_Options.KEDWeight = 0.1;
TF_Options.PenFuncWeight = stage.PenFuncWeight;
TF_Options.Lb = lb(1:27);
TF_Options.Ub = ub(1:27);
TF_Options.SwarmSize = stage.swarmsize;
TF_Options.MaxFuncEval = stage.MaxFuncEval;
TF_Options.FuncTol = stage.FuncTol;
TF_Options.MaxIter = stage.MaxIter;
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
end