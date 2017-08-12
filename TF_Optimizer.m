function [x_opt, Fval] = TF_Optimizer(TF_Opti)

FitnessFcn2 = @(x) TF(x, TF_Opti.CompSelector, TF_Opti.OptTypeSelector, TF_Opti.Eta, TF_Opti.Omega, TF_Opti.Fhat, TF_Opti.Mass, TF_Opti.TFWeight, TF_Opti.KEDWeight, TF_Opti.PenFuncWeight);
TF_PSOoptions = optimoptions(@particleswarm,'PlotFcn',{@pswplotbestf},'SwarmSize',TF_Opti.SwarmSize,'FunctionTolerance',TF_Opti.FuncTol,'MaxIterations',TF_Opti.MaxIter);
[x_opt2,Fval] = particleswarm(FitnessFcn2,27,TF_Opti.Lb,TF_Opti.Ub,TF_PSOoptions);
x_opt2 = x_opt2';
FitnessFcn22 = @(x) TF(x, TF_Opti.CompSelector, TF_Opti.OptTypeSelector, TF_Opti.Eta, TF_Opti.Omega, TF_Opti.Fhat, TF_Opti.Mass, 1, 0, 0);
fminconOptions = optimoptions(@fmincon,'Display','iter','MaxFunctionEvaluations',TF_Opti.MaxFuncEval);
x_opt = fmincon(FitnessFcn22,x_opt2,[],[],[],[],TF_Opti.Lb-1e-5,TF_Opti.Ub+1e-5,@(x) nlcn(x, TF_Opti.Mass, TF_Opti.FreqLowerBound, TF_Opti.FreqUpperBound, TF_Opti.DeltaStatic),fminconOptions);
