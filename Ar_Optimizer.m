function [x_opt, Fval] = Ar_Optimizer(Ar_Opti,n,T,F,x_init,T1,lb,ub);
cmd('Ar_Optimizer started ...');
%% PSO
% options
cmd('PSO options are being set...')
Ar_PSOoptions = optimoptions(@particleswarm,'PlotFcn',{@pswplotbestf},'SwarmSize',Ar_Opti.SwarmSize,'FunctionTolerance',Ar_Opti.FuncTol,'MaxIterations',Ar_Opti.MaxIter);
% start
FitnessFcn3 = @(x) obj_Ar(x,T,F,x_init,T1, Ar_Opti.ComponentSelector, Ar_Opti.OptTypeSelector, Ar_Opti.Omega, Ar_Opti.Fhat, Ar_Opti.Mass, Ar_Opti.SuspensionStruct, Ar_Opti.ArWeight, Ar_Opti.KEDWeight, Ar_Opti.PenFuncWeight);
cmd('Ar PSO started...')
[x_opt3,Fval] = particleswarm(FitnessFcn3,n,lb,ub,Ar_PSOoptions);
%% Hybrid fmincon

% options
cmd('fmincon options are being set...')
fminconOptions = optimoptions(@fmincon,'PlotFcn',{@optimplotfval},'Display','iter','MaxFunctionEvaluations',Ar_Opti.MaxFuncEval);

% start
cmd('fmincon hybrid started');

FitnessFcn33 = @(x) obj_Ar(x,T,F,x_init,T1, Ar_Opti.ComponentSelector, Ar_Opti.OptTypeSelector, Ar_Opti.Omega, Ar_Opti.Fhat, Ar_Opti.Mass, Ar_Opti.SuspensionStruct, 1, 0, 0);
x_opt = fmincon(FitnessFcn33,x_opt3,[],[],[],[],lb,ub,...
    @(x) nlcn(x,T,F,x_init,T1, Ar_Opti.Mass, Ar_Opti.FreqLowerBound, Ar_Opti.FreqUpperBound, Ar_Opti.DeltaStatic),fminconOptions);



end