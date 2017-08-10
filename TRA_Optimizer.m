function [x_opt, fval] = TRA_Optimizer(TRA_options)

FitnessFcn1 = @(x) TRA(x, TRA_options.M, TRA_options.TRAweight, TRA_options.KEDweight, TRA_options.PenFuncweight);
fminconOptions = optimoptions(@fmincon,'Display','iter','MaxFunctionEvaluations',50000);
PSOoptions = optimoptions(@particleswarm,'PlotFcn',{@pswplotbestf},'SwarmSize',1000,'FunctionTolerance',1e-5,'MaxIterations',10000);
%     options = optimoptions(options,'HybridFcn',{@fmincon, fminconOptions});
[x_opt1,fval] = particleswarm(FitnessFcn1,28,TRA_options.lb,TRA_options.ub,PSOoptions);
x_opt1 = x_opt1';
FitnessFcn11 = @(x) TRA(x, TRA_options.M, 1, 0, 0);
x_opt = fmincon(FitnessFcn11,x_opt1,[],[],[],[],TRA_options.lb-1e-5,TRA_options.ub+1e-5,...
    @(x) nlcn(x, TRA_options.M, TRA_options.f_nat_lb, TRA_options.f_nat_ub, TRA_options.delta_s),fminconOptions);