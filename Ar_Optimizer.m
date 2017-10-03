function [x_opt, Fval] = Ar_Optimizer(option,n,T,F,x_init,T1,lb,ub);
cmd('optionmizer started ...');
%% PSO
% options
cmd('PSO options are being set...')
Ar_PSOoptions = optimoptions(@particleswarm,'PlotFcn',{@pswplotbestf},'SwarmSize',option.swarmsize,'FunctionTolerance',option.FuncTol,'MaxIterations',option.MaxIter);
% start
FitnessFcn3 = @(x) obj_Ar(x,T,F,x_init,T1, option.Ar_CompSelector, option.Ar_OptTypeSelector, option.Omega, option.Fhat, option.Mass, option.SuspensionStruct, option.ArWeight, option.KEDWeight, option.PenFuncWeight);
cmd('Ar PSO started...')
[x_opt3,Fval] = particleswarm(FitnessFcn3,n,lb,ub,Ar_PSOoptions);
%% Hybrid fmincon

% options
cmd('fmincon options are being set...')
fminconOptions = optimoptions(@fmincon,'PlotFcn',{@optimplotfval},'Display','iter','MaxFunctionEvaluations',option.MaxFuncEval);

% start
cmd('fmincon hybrid started');

FitnessFcn33 = @(x) obj_Ar(x,T,F,x_init,T1, option.Ar_CompSelector, option.Ar_OptTypeSelector, option.Omega, option.Fhat, option.Mass, option.SuspensionStruct, 1, 0, 0);
x_opt = fmincon(FitnessFcn33,x_opt3,[],[],[],[],lb,ub,...
    @(x) nlcn(x,T,F,x_init,T1, option.Mass, option.FreqLowerBound, option.FreqUpperBound, option.DeltaStatic,option.StaticTests),fminconOptions);



end