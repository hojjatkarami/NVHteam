function [x_Opt, fval] = TRA_Optimizer(TRA_Opti,n,T,F,x_init,T1,lb,ub)
cmd('TRA_Optimizer started ...');
%% PSO
% options
cmd('PSO options are being set...')
PSOoptions = optimoptions(@particleswarm,'PlotFcn',{@pswplotbestf},'SwarmSize',TRA_Opti.SwarmSize,'FunctionTolerance',TRA_Opti.FuncTol,'MaxIterations',TRA_Opti.MaxIter);
                        %     options = optimoptions(options,'HybridFcn',{@fmincon, fminconOptions});

% start
FitnessFcn1 = @(x) obj_TRA(x,T,F,x_init,T1, TRA_Opti.Mass, TRA_Opti.TRAWeight, TRA_Opti.KEDWeight, TRA_Opti.PenFuncWeight);
cmd('TRA PSO started...')
[x_opt1,fval] = particleswarm(FitnessFcn1,n,lb,ub,PSOoptions);
cmd(['TRA value is : ',num2str(fval)]);

%% Hybrid fmincon
% options
cmd('fmincon options are being set...')
FminconOptions = optimoptions(@fmincon,'PlotFcn',{@optimplotfval}, 'Display','iter','MaxFunctionEvaluations',TRA_Opti.MaxFuncEval);

% start
cmd('fmincon hybrid started');
FitnessFcn11 = @(x) obj_TRA(x,T,F,x_init,T1, TRA_Opti.Mass, 1, 0, 0);
[x_Opt,fval2] = fmincon(FitnessFcn11,x_opt1,[],[],[],[],lb,ub,...
                @(x) nlcn(x,T,F,x_init,T1, TRA_Opti.Mass, TRA_Opti.FreqLowerBound, TRA_Opti.FreqUpperBound, TRA_Opti.DeltaStatic),FminconOptions);

cmd(['TRA value after hybrid is : ',num2str(fval2)]);
TRA_pure = obj_TRA(x_Opt,T,F,x_init,T1, TRA_Opti.Mass, 1, 0, 0);
cmd(['pure TRA value is : ',num2str(TRA_pure)]);         


end