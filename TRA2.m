%% TRA Optimization %%
cmd('********* TRA *********');
cmd('TRA parameters are being set...');



TRA_Options.DeltaStatic = stage1.DeltaStatic;
TRA_Options.TRAWeight = 0.9;
TRA_Options.KEDWeight = 0.1;

TRA_Options.PenFuncWeight = stage1.PenFuncWeight;
% TRA_Options.Lb = lb;
% TRA_Options.Ub = ub;
TRA_Options.SwarmSize = stage1.swarmsize;
TRA_Options.MaxFuncEval = stage1.MaxFuncEval;
TRA_Options.FuncTol = stage1.FuncTol;
TRA_Options.MaxIter = stage1.MaxIter;
TRA_Options.FreqLowerBound = stage1.lb_freq;
TRA_Options.FreqUpperBound = stage1.ub_freq;
TRA_Options.Mass = h.eng.M;



[x_opt_TRA, Fval_TRA, TRA_pure] = TRA_Optimizer(TRA_Options,n,T,F,x_init,T1,lb,ub);

% h.stage(i).val_TRA = obj_TRA(x_opt_TRA,T,F,x_init,T1, TRA_Opti.Mass, 1, 0, 0);
% h.stage(i).val_TF =  obj_TF(x_opt_TRA,T,F,x_init,T1, TF_Opti.CompSelector, TF_Opti.OptTypeSelector, TF_Opti.Omega, TF_Opti.Fhat, TF_Opti.Mass, 1, 0, 0);;

cmd('calculating results ...');


% stage1.init.result = stage0.opt.result;
stage1.x_opt =  T * (F .* x_init + T1*x_opt_TRA');
% stage1.opt.result = Result_Calc(stage1.opt.x,T, Result_Parameters);
h.stage(j).x_opt = stage1.x_opt;

 
cmd('results saved');



