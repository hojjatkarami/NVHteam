%% TRA Optimization %%
function [stage1]=TRA(g,stage0,stage1,Result_Parameters)
cmd('********* TRA *********');
cmd('TRA parameters are being set...');
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




TRA_Options.DeltaStatic = g.DeltaStatic;
TRA_Options.TRAWeight = 0.9;
TRA_Options.KEDWeight = 0.1;
TRA_Options.PenFuncWeight = stage1.PenFuncWeight;
% TRA_Options.Lb = lb;
% TRA_Options.Ub = ub;
TRA_Options.SwarmSize = stage1.swarmsize;
TRA_Options.MaxFuncEval = stage1.MaxFuncEval;
TRA_Options.FuncTol = stage1.FuncTol;
TRA_Options.MaxIter = stage1.MaxIter;
TRA_Options.FreqLowerBound = g.lb_freq;
TRA_Options.FreqUpperBound = g.ub_freq;
TRA_Options.Mass = g.eng.M;



[x_opt_TRA, Fval_TRA] = TRA_Optimizer(TRA_Options,n,T,F,x_init,T1,lb,ub);


cmd('calculating results ...');


stage1.init.result = stage0.opt.result;
stage1.opt.x =  T * (F .* x_init + T1*x_opt_TRA');
stage1.opt.result = Result_Calc(stage1.opt.x,T, Result_Parameters);


 
cmd('results saved');


end
