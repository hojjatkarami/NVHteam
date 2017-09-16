%% Transmitted Acceleration Optimization %%
function TA(g,g.stage0,g.stage1,Result_Parameters)

cmd('********* TA *********');
cmd('TA parameters are being set...');
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


TA_Options.DeltaStatic = g.DeltaStatic;
TA_Options.TAWeight = 0.9;
TA_Options.KEDWeight = 0.1;
TA_Options.PenFuncWeight = stage1.PenFuncWeight;
% TA_Options.Lb = lb(1:27);
% TA_Options.Ub = ub(1:27);
TA_Options.SwarmSize = stage1.swarmsize;
TA_Options.MaxFuncEval = stage1.MaxFuncEval;
TA_Options.FuncTol = stage1.FuncTol;
TA_Options.MaxIter = stage1.MaxIter;
TA_Options.FreqLowerBound = g.lb_freq;
TA_Options.FreqUpperBound = g.ub_freq;
TA_Options.Mass = g.eng.M;
TA_Options.SuspensionStruct = g.sus;
% TA_Options.Eta = eta;
TA_Options.Omega = g.eng.omega;
TA_Options.Fhat = g.eng.Fhat;
TA_Options.MountSelector=[1; 1; 1];    % dim(3*1):used to choose which directions are going to be accounted [mount1, mount2, mount3]
TA_Options.OptTypeSelector = [1; 0; 0]; %This variable could be [1; 0; 0], [0; 1; 0] or [0; 0; 1] for 'max', 'sum' or 'norm', default value is 'max'!

[x_opt_TA, Fval_TA] = TA_Optimizer(TA_Options,n,T,F,x_init,T1,lb,ub);

cmd('calculating results ...');

stage1.init.result = stage0.opt.result;

stage1.opt.x =  T * (F .* x_init + T1*x_opt_TA');
stage1.opt.result = Result_Calc(stage1.opt.x,T, Result_Parameters);

end