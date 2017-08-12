function [x_Opt, fval] = TRA_Optimizer(TRA_Opti)

FitnessFcn1 = @(x) TRA(x, TRA_Opti.Mass, TRA_Opti.TRAWeight, TRA_Opti.KEDWeight, TRA_Opti.PenFuncWeight);
FminconOptions = optimoptions(@fmincon,'Display','iter','MaxFunctionEvaluations',TRA_Opti.MaxFuncEval);
PSOoptions = optimoptions(@particleswarm,'PlotFcn',{@pswplotbestf},'SwarmSize',TRA_Opti.SwarmSize,'FunctionTolerance',TRA_Opti.FuncTol,'MaxIterations',TRA_Opti.MaxIter);
%     options = optimoptions(options,'HybridFcn',{@fmincon, fminconOptions});
[x_opt1,fval] = particleswarm(FitnessFcn1,28,TRA_Opti.Lb,TRA_Opti.Ub,PSOoptions);
x_opt1 = x_opt1';
FitnessFcn11 = @(x) TRA(x, TRA_Opti.Mass, 1, 0, 0);
x_Opt = fmincon(FitnessFcn11,x_opt1,[],[],[],[],TRA_Opti.Lb-1e-5,TRA_Opti.Ub+1e-5,...
    @(x) nlcn(x, TRA_Opti.Mass, TRA_Opti.FreqLowerBound, TRA_Opti.FreqUpperBound, TRA_Opti.DeltaStatic),FminconOptions);