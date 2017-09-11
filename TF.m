%% Transmitted Force Optimization %%
function [stage1]=TF(g,stage0,stage1,Result_Parameters)
cmd('********* TF *********');
cmd('TF parameters are being set...');

n=stage1.n;
T = stage1.T;
T1 = stage1.T1;
F = stage1.F;

stage1.init.x = stage0.opt.x;
x_init = stage1.init.x;
lb = (F==0).*(stage1.init.x - stage1.purt .* ( stage1.init.x - stage0.lb));
ub = (F==0).*(stage1.init.x + stage1.purt .* ( stage0.ub - stage1.init.x));
stage1.lb=lb;
stage1.ub=ub;


lb = lb(lb~=0);
ub = ub(ub~=0);

TF_Options.DeltaStatic = g.DeltaStatic;
TF_Options.TFWeight = 0.9;
TF_Options.KEDWeight = 0.1;
TF_Options.PenFuncWeight = stage1.PenFuncWeight;
% TF_Options.Lb = lb(1:27);
% TF_Options.Ub = ub(1:27);
TF_Options.SwarmSize = stage1.swarmsize;
TF_Options.MaxFuncEval = stage1.MaxFuncEval;
TF_Options.FuncTol = stage1.FuncTol;
TF_Options.MaxIter = stage1.MaxIter;
TF_Options.FreqLowerBound = g.lb_freq;
TF_Options.FreqUpperBound = g.ub_freq;
TF_Options.Mass = g.eng.M;

TF_Options.Omega = g.eng.omega;
TF_Options.Fhat = g.eng.Fhat;
TF_Options.CompSelector= stage1.TF.dir;    % dim(3*4):used to choose which directions are going to be accounted [F_1_x,F_1_y,F_1_z,F_1_mag,F_2_x,...]
TF_Options.OptTypeSelector = stage1.TF.method; %This variable could be [1; 0; 0], [0; 1; 0] or [0; 0; 1] for 'max', 'sum' or 'norm', default value is 'max'!




[x_opt_TF, Fval_TF] = TF_Optimizer(TF_Options,n,T,F,x_init,T1,lb,ub);

cmd('calculating results ...');

stage1.init.result = stage0.opt.result;

stage1.opt.x =  T * (F .* x_init + T1*x_opt_TF');
stage1.opt.result = Result_Calc(stage1.opt.x,T, Result_Parameters);

end