function [x_opt, Fval, TF_pure] = TF_Optimizer(TF_Opti,n,T,F,x_init,T1,lb,ub)
cmd('TF_Optimizer started ...');
%% PSO
% options
cmd('PSO options are being set...')
TF_PSOoptions = optimoptions(@particleswarm,'PlotFcn',{@pswplotbestf},'SwarmSize',TF_Opti.SwarmSize,'FunctionTolerance',TF_Opti.FuncTol,'MaxIterations',TF_Opti.MaxIter);


% start
FitnessFcn2 = @(x) obj_TF(x,T,F,x_init,T1 ,TF_Opti.CompSelector, TF_Opti.OptTypeSelector, TF_Opti.Omega,...
                            TF_Opti.Fhat, TF_Opti.Mass, TF_Opti.TFWeight, TF_Opti.KEDWeight,...
                            TF_Opti.PenFuncWeight);
cmd('TF PSO started...')
[x_opt2,Fval] = particleswarm(FitnessFcn2,n,lb,ub,TF_PSOoptions);
%% Hybrid fmincon

% options
cmd('fmincon options are being set...')
fminconOptions = optimoptions(@fmincon,'PlotFcn',{@optimplotfval},'Display','iter','MaxFunctionEvaluations',TF_Opti.MaxFuncEval);

% start
cmd('fmincon hybrid started');

FitnessFcn22 = @(x) obj_TF(x,T,F,x_init,T1, TF_Opti.CompSelector, TF_Opti.OptTypeSelector, TF_Opti.Omega, TF_Opti.Fhat, TF_Opti.Mass, 1, 0, 0);
x_opt = fmincon(FitnessFcn22,x_opt2,[],[],[],[],lb,ub,...
        @(x) nlcn(x,T,F,x_init,T1,TF_Opti.Mass,TF_Opti.FreqLowerBound, TF_Opti.FreqUpperBound, TF_Opti.DeltaStatic),fminconOptions);
    TF_pure = obj_TF(x_opt,T,F,x_init,T1, TF_Opti.CompSelector, TF_Opti.OptTypeSelector, TF_Opti.Omega, TF_Opti.Fhat, TF_Opti.Mass, 1, 0, 0);;
