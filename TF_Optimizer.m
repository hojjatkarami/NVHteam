function [x_opt, Fval] = TF_Optimizer(option,n,T,F,x_init,T1,lb,ub)
cmd('optionmizer started ...');
%% PSO
% options
cmd('PSO options are being set...')
TF_PSOoptions = optimoptions(@particleswarm,'PlotFcn',{@pswplotbestf},'SwarmSize',option.swarmsize,'FunctionTolerance',option.FuncTol,'MaxIterations',option.MaxIter);

% start
FitnessFcn2 = @(x) obj_TF(x,T,F,x_init,T1 ,option.TF_CompSelector, option.TF_OptTypeSelector, option.rpm,...
                            option.torque, option.Mass,option.FreqLowerBound,option.FreqUpperBound,...
                            option.TFWeight, option.KEDWeight, option.PenFuncWeight);
hyd=sum(T1(41,:));   %1 for hydraulic and 0 for elastomeric config
if hyd==1
   FitnessFcn2 = @(x) obj_TF_hyd(x,T,F,x_init,T1 ,option.TF_CompSelector, option.TF_OptTypeSelector, option.rpm,...
                            option.torque, option.Mass,option.FreqLowerBound,option.FreqUpperBound,...
                            option.TFWeight, option.KEDWeight, option.PenFuncWeight); 
   disp('hyd')
end
cmd('TF PSO started...')
[x_opt2,Fval] = particleswarm(FitnessFcn2,n,lb,ub,TF_PSOoptions);
%% Hybrid fmincon

% options
cmd('fmincon options are being set...')
fminconOptions = optimoptions(@fmincon,'PlotFcn',{@optimplotfval},'Display','iter','MaxFunctionEvaluations',option.MaxFuncEval);

% start
cmd('fmincon hybrid started');

FitnessFcn22 = @(x) obj_TF(x,T,F,x_init,T1 ,option.TF_CompSelector, option.TF_OptTypeSelector, option.rpm,...
                            option.torque, option.Mass,option.FreqLowerBound,option.FreqUpperBound,...
                            1, 0, 0);
if hyd==1
   FitnessFcn22 = @(x) obj_TF_hyd(x,T,F,x_init,T1 ,option.TF_CompSelector, option.TF_OptTypeSelector, option.rpm,...
                            option.torque, option.Mass,option.FreqLowerBound,option.FreqUpperBound,...
                            1, 0, 0);
   disp('hyd')
end
x_opt = fmincon(FitnessFcn22,x_opt2,[],[],[],[],lb,ub,...
        @(x) nlcn(x,T,F,x_init,T1,option.Mass,option.FreqLowerBound, option.FreqUpperBound, option.DeltaStatic,option.StaticTests),fminconOptions);
