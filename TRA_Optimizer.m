function [x_Opt, fval] = TRA_Optimizer(option,n,T,F,x_init,T1,lb,ub)
cmd('optionmizer started ...');
%% PSO
% options
cmd('PSO options are being set...')
PSOoptions = optimoptions(@particleswarm,'PlotFcn',{@pswplotbestf},'SwarmSize',option.swarmsize,'FunctionTolerance',option.FuncTol,'MaxIterations',option.MaxIter);
                        %     options = optimoptions(options,'HybridFcn',{@fmincon, fminconOptions});

% start

FitnessFcn1 = @(x) obj_TRA(x,T,F,x_init,T1, option.Mass, option.FreqLowerBound, option.FreqUpperBound,...
                            option.TRAWeight, option.KEDWeight, option.PenFuncWeight);
cmd('TRA PSO started...')
[x_opt1,fval] = particleswarm(FitnessFcn1,n,lb,ub,PSOoptions);
cmd(['TRA value is : ',num2str(fval)]);
x_Opt=x_opt1;
% %% Hybrid fmincon
% % options
% cmd('fmincon options are being set...')
% FminconOptions = optimoptions(@fmincon,'PlotFcn',{@optimplotfval}, 'Display','iter','MaxFunctionEvaluations',option.MaxFuncEval);
% 
% % start
% cmd('fmincon hybrid started');
% FitnessFcn11 = @(x) obj_TRA(x,T,F,x_init,T1, option.Mass, option.FreqLowerBound, option.FreqUpperBound,...
%                             1, 0, 0);
% [x_Opt,fval2] = fmincon(FitnessFcn11,x_opt1,[],[],[],[],lb,ub,...
%                 @(x) nlcn(x,T,F,x_init,T1, option.Mass, option.FreqLowerBound, option.FreqUpperBound, option.DeltaStatic,option.StaticTests),FminconOptions);
% 
% cmd(['TRA value after hybrid is : ',num2str(fval2)]);
% % TRA_pure = obj_TRA(x_Opt,T,F,x_init,T1, option.Mass, 1, 0, 0);
% % cmd(['pure TRA value is : ',num2str(TRA_pure)]);         


end