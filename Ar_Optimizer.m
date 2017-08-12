function [x_opt, Fval] = Ar_Optimizer(Ar_Options)

FitnessFcn4 = @(x) Ar(x, Ar_Options.MountSelector, Ar_Options.OptTypeSelector, Ar_Options.Eta, Ar_Options.Omega, Ar_Options.Fhat, Ar_Options.Mass, Ar_Options.SuspensionStruct, Ar_Options.TVWeight, Ar_Options.KEDWeight, Ar_Options.PenFuncWeight);
Ar_PSOoptions = optimoptions(@particleswarm,'PlotFcn',{@pswplotbestf},'SwarmSize',Ar_Options.SwarmSize,'FunctionTolerance',Ar_Options.FuncTol,'MaxIterations',Ar_Options.MaxIter);
[x_opt4,Fval] = particleswarm(FitnessFcn4,27,Ar_Options.Lb,Ar_Options.Ub,Ar_PSOoptions);
x_opt4 = x_opt4';
Ar_fminconOptions = optimoptions(@fmincon,'Display','iter','MaxFunctionEvaluations',Ar_Options.MaxFuncEval);
FitnessFcn44 = @(x) Ar(x, Ar_Options.MountSelector, Ar_Options.OptTypeSelector, Ar_Options.Eta, Ar_Options.Omega, Ar_Options.Fhat, Ar_Options.Mass, Ar_Options.SuspensionStruct, 1, 0, 0);
x_opt = fmincon(FitnessFcn44,x_opt4,[],[],[],[],Ar_Options.Lb-1e-5,Ar_Options.Ub+1e-5,@(x) nlcn(x, Ar_Options.Mass, Ar_Options.FreqLowerBound, Ar_Options.FreqUpperBound, Ar_Options.DeltaStatic),Ar_fminconOptions);
