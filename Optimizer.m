function [x_opt, fval] = Optimizer(obj,option,n,T,F,x_init,T1,lb,ub,rpm,torque,M)

PSOoptions = optimoptions(@particleswarm,'PlotFcn',{@pswplotbestf},'SwarmSize',option.swarmsize,...
                                         'FunctionTolerance',option.FuncTol,'MaxIterations',option.MaxIter);

FitnessFcn1 = @(x) obj_main(x,T,F,x_init,T1, rpm,torque, M, obj);

[x_Opt,fval] = particleswarm(FitnessFcn1,n,lb,ub,PSOoptions);

 x_opt =  T * (F .* x_init + T1*x_Opt');

end
