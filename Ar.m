%% Acceleration ratio (Ar) Optimization %%
function [stage1]=TA(g,stage0,stage1,Result_Parameters)

cmd('********* TA *********');
cmd('TA parameters are being set...');
n=stage1.n;
T = stage1.T;
T1 = stage1.T1;
F = stage1.F;

stage1.init.x = stage0.opt.x;
x_init = stage1.init.x;
lb = (F==0).*(stage1.init.x - stage1.purt .* ( stage1.init.x - g.stage0.lb));
ub = (F==0).*(stage1.init.x + stage1.purt .* ( g.stage0.ub - stage1.init.x));
stage1.lb=lb;
stage1.ub=ub;
s=stage1.lb;
s'
term

lb = lb(lb~=0);
ub = ub(ub~=0);

Ar_Options.DeltaStatic = g.DeltaStatic;
Ar_Options.ArWeight = 0.9;
Ar_Options.KEDWeight = 0.1;
Ar_Options.PenFuncWeight = stage1.PenFuncWeight;
% Ar_Options.Lb = lb(1:27);
% Ar_Options.Ub = ub(1:27);
Ar_Options.SwarmSize = stage1.swarmsize;
Ar_Options.MaxFuncEval = stage1.MaxFuncEval;
Ar_Options.FuncTol = stage1.FuncTol;
Ar_Options.MaxIter = stage1.MaxIter;
Ar_Options.FreqLowerBound = g.lb_freq;
Ar_Options.FreqUpperBound = g.ub_freq;
Ar_Options.Mass = g.eng.M;
Ar_Options.SuspensionStruct = g.sus;
Ar_Options.Omega = g.eng.omega;
Ar_Options.Fhat = g.eng.Fhat;
Ar_Options.ComponentSelector = stage1.Ar.dir;    % dim(3*4):used to choose which directions are going to be accounted [a_1_x,a_1_y,a_1_z,a_1_mag,a_2_x,...]
Ar_Options.OptTypeSelector = stage1.Ar.method; %This variable could be [1; 0; 0], [0; 1; 0] or [0; 0; 1] for 'max', 'sum' or 'norm', default value is 'max'!

[x_opt_Ar, Fval_Ar] = Ar_Optimizer(Ar_Options,n,T,F,x_init,T1,lb,ub);

cmd('calculating results ...');

stage1.init.result = stage0.opt.result;

stage1.opt.x =  T * (F .* x_init + T1*x_opt_Ar');
stage1.opt.result = Result_Calc(stage1.opt.x,T, Result_Parameters);

end