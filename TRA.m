%% TRA Optimization %%
function [stage1]=TRA(g,stage0,stage1,Result_Parameters)
cmd('********* TRA *********');
cmd('TRA parameters are being set...');
stage1.t1 = stage0.t1;
stage1.init.x = stage0.opt.x;
stage1.lb = stage1.init.x - stage1.purt .* ( stage1.init.x - stage0.lb);
stage1.ub = stage1.init.x + stage1.purt .* ( stage0.ub - stage1.init.x);

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


t1 = stage1.t1;  %this vector shows which parameters are bounded are going to be optimized
t1(43)=1;       %now w_TRA will is an optimization variable
t2 = find(t1==1);
T = zeros(43,length(t2));   %Transformation matrix where T*x(optimizition var)=x(design variables)
xp = stage1.init.x;     %design variables(43:9 pos,9 orien,9 stiff,9 damp,3 etha,3 hydraulic)
n=length(t2);       %optimization variables
for i=1:n
    
       T(t2(i),i)=1; 
       xp(t2(i))=0; 
end


lb = diag(t1) * stage1.lb;
ub = diag(t1) * stage1.ub;
lb=lb(lb~=0);
ub=ub(ub~=0);


[x_opt_TRA, Fval_TRA] = TRA_Optimizer(TRA_Options,n,T,xp,lb,ub);


cmd('calculating results ...');


stage1.init.result = stage0.opt.result;

stage1.opt.x =  xp + T * x_opt_TRA';
stage1.opt.result = Result_Calc(stage1.opt.x, Result_Parameters);


 
cmd('results saved');


end
