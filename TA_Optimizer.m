function [x_opt, Fval] = TA_Optimizer(TA_Opti)

FitnessFcn3 = @(x) TA(x, TA_Opti.MountSelector, TA_Opti.OptTypeSelector, TA_Opti.Eta, TA_Opti.Omega, TA_Opti.Fhat, TA_Opti.Mass, TA_Opti.SuspensionStruct, TA_Opti.TAWeight, TA_Opti.KEDWeight, TA_Opti.PenFuncWeight);
TA_PSOoptions = optimoptions(@particleswarm,'PlotFcn',{@pswplotbestf},'SwarmSize',TA_Opti.SwarmSize,'FunctionTolerance',TA_Opti.FuncTol,'MaxIterations',TA_Opti.MaxIter);
[x_opt3,Fval] = particleswarm(FitnessFcn3,27,TA_Opti.Lb,TA_Opti.Ub,TA_PSOoptions);
x_opt3 = x_opt3';
FitnessFcn33 = @(x) TA(x, TA_Opti.MountSelector, TA_Opti.OptTypeSelector, TA_Opti.Eta, TA_Opti.Omega, TA_Opti.Fhat, TA_Opti.Mass, TA_Opti.SuspensionStruct, 1, 0, 0);
fminconOptions = optimoptions(@fmincon,'Display','iter','MaxFunctionEvaluations',TA_Opti.MaxFuncEval);
x_opt = fmincon(FitnessFcn33,x_opt3,[],[],[],[],TA_Opti.Lb-1e-5,TA_Opti.Ub+1e-5,...
    @(x) nlcn(x, TA_Opti.Mass, TA_Opti.FreqLowerBound, TA_Opti.FreqUpperBound, TA_Opti.DeltaStatic),fminconOptions);
