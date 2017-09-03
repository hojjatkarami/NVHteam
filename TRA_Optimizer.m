function [x_Opt, fval] = TRA_Optimizer(TRA_Opti)
cmd('TRA_Optimizer started ...');
FitnessFcn1 = @(x) obj_TRA(x, TRA_Opti.Mass, TRA_Opti.TRAWeight, TRA_Opti.KEDWeight, TRA_Opti.PenFuncWeight);
cmd('fmincon options are being set...')
FminconOptions = optimoptions(@fmincon,'Display','iter','MaxFunctionEvaluations',TRA_Opti.MaxFuncEval);
cmd('PSO options are being set...')
PSOoptions = optimoptions(@particleswarm,'PlotFcn',{@pswplotbestf},'SwarmSize',TRA_Opti.SwarmSize,'FunctionTolerance',TRA_Opti.FuncTol,'MaxIterations',TRA_Opti.MaxIter);
%     options = optimoptions(options,'HybridFcn',{@fmincon, fminconOptions});
cmd('TRA PSO started...')
[x_opt1,fval] = particleswarm(FitnessFcn1,28,TRA_Opti.Lb,TRA_Opti.Ub,PSOoptions);
cmd(['TRA value is : ',num2str(fval)]);
cmd('fmincon hybrid started');
FitnessFcn11 = @(x) obj_TRA(x, TRA_Opti.Mass, 1, 0, 0);
[x_Opt,fval2] = fmincon(FitnessFcn11,x_opt1,[],[],[],[],TRA_Opti.Lb-1e-5,TRA_Opti.Ub+1e-5,...
                @(x) nlcn(x, TRA_Opti.Mass, TRA_Opti.FreqLowerBound, TRA_Opti.FreqUpperBound, TRA_Opti.DeltaStatic),FminconOptions);
cmd(['TRA value after hybrid is : ',num2str(fval2)]);
            
end