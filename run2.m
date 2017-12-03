function x_opt_total = run2(stage,stage0,j)
    F_zero = find(stage.F==0);
    
    lb = stage.lb(F_zero);
    ub = stage.ub(F_zero);
    
    f_val_total = inf;
    
    for k=1:stage.repeat
        a=stage.obj;
        [x_opt, fval] = Optimizer(stage.obj,stage.pso,stage.n,stage.T,stage.F,stage.x_init,stage.T1,lb,ub,stage0.eng.rpm,stage0.eng.torque,stage0.eng.M,stage0.sus);
              
        if fval<f_val_total
            f_val_total = fval;
            x_opt_total = x_opt;
       end

    end
%     h_old.stage(j).x_opt_partial = x_opt';
%         h_old.stage(j).x_opt = x_opt_total;
%         h_new=h_old;
       end