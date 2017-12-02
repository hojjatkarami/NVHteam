function [x_opt, fval] = Optimizer(obj,pso,n,T,F,x_init,T1,lb,ub,rpm,torque,M,sus)

PSOoptions = optimoptions(@particleswarm,'PlotFcn',{@pswplotbestf},'SwarmSize',pso.swarmsize,...
                                         'FunctionTolerance',pso.FuncTol,'MaxIterations',pso.MaxIter);

FitnessFcn1 = @(x) obj_main(x,T,F,x_init,T1, rpm,torque, M,sus, obj);

[x_Opt,fval] = particleswarm(FitnessFcn1,n,lb,ub,PSOoptions);

 x_opt =  T * (F .* x_init + T1*x_Opt');

end
