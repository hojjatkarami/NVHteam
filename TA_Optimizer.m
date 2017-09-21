function [x_opt, Fval] = TA_Optimizer(option,n,T,F,x_init,T1,lb,ub)
cmd('optionmizer started ...');
%% PSO
% options
cmd('PSO options are being set...')
TA_PSOoptions = optimoptions(@particleswarm,'PlotFcn',{@pswplotbestf},'SwarmSize',option.swarmsize,'FunctionTolerance',option.FuncTol,'MaxIterations',option.MaxIter);
% start
FitnessFcn3 = @(x) obj_TA(x,T,F,x_init,T1, option.TA_CompSelector, option.TA_OptTypeSelector, option.Omega, option.Fhat, option.Mass, option.SuspensionStruct, option.TAWeight, option.KEDWeight, option.PenFuncWeight);
cmd('TA PSO started...')
[x_opt3,Fval] = particleswarm(FitnessFcn3,n,lb,ub,TA_PSOoptions);
%% Hybrid fmincon

% options
cmd('fmincon options are being set...')
fminconOptions = optimoptions(@fmincon,'PlotFcn',{@optimplotfval},'Display','iter','MaxFunctionEvaluations',option.MaxFuncEval);

% start
cmd('fmincon hybrid started');

FitnessFcn33 = @(x) obj_TA(x,T,F,x_init,T1, option.TA_CompSelector, option.TA_OptTypeSelector, option.Omega, option.Fhat, option.Mass, option.SuspensionStruct, 1, 0, 0);
x_opt = fmincon(FitnessFcn33,x_opt3,[],[],[],[],lb,ub,...
    @(x) nlcn(x,T,F,x_init,T1, option.Mass, option.FreqLowerBound, option.FreqUpperBound, option.DeltaStatic),fminconOptions);



end