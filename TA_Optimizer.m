function [x_opt, Fval] = TA_Optimizer(TA_Opti,n,T,F,x_init,T1,lb,ub);
cmd('TA_Optimizer started ...');
%% PSO
% options
cmd('PSO options are being set...')
TA_PSOoptions = optimoptions(@particleswarm,'PlotFcn',{@pswplotbestf},'SwarmSize',TA_Opti.SwarmSize,'FunctionTolerance',TA_Opti.FuncTol,'MaxIterations',TA_Opti.MaxIter);
% start
FitnessFcn3 = @(x) obj_TA(x,T,F,x_init,T1, TA_Opti.ComponentSelector, TA_Opti.OptTypeSelector, TA_Opti.Omega, TA_Opti.Fhat, TA_Opti.Mass, TA_Opti.SuspensionStruct, TA_Opti.TAWeight, TA_Opti.KEDWeight, TA_Opti.PenFuncWeight);
cmd('TA PSO started...')
[x_opt3,Fval] = particleswarm(FitnessFcn3,n,lb,ub,TA_PSOoptions);
%% Hybrid fmincon

% options
cmd('fmincon options are being set...')
fminconOptions = optimoptions(@fmincon,'PlotFcn',{@optimplotfval},'Display','iter','MaxFunctionEvaluations',TA_Opti.MaxFuncEval);

% start
cmd('fmincon hybrid started');

FitnessFcn33 = @(x) obj_TA(x,T,F,x_init,T1, TA_Opti.ComponentSelector, TA_Opti.OptTypeSelector, TA_Opti.Omega, TA_Opti.Fhat, TA_Opti.Mass, TA_Opti.SuspensionStruct, 1, 0, 0);
x_opt = fmincon(FitnessFcn33,x_opt3,[],[],[],[],lb,ub,...
    @(x) nlcn(x,T,F,x_init,T1, TA_Opti.Mass, TA_Opti.FreqLowerBound, TA_Opti.FreqUpperBound, TA_Opti.DeltaStatic),fminconOptions);



end