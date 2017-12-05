function h_new = run3(h_old,j)
    stage1 = h_old.stage(j);
    n=stage1.n;    T = stage1.T;    T1 = stage1.T1;        F = stage1.F;
    
    x_init = stage1.x_init;

    F_zero = find(F==0);
    lb = stage1.lb(F_zero);
    ub = stage1.ub(F_zero);
    
    f_val_total = inf;
    
    for k=1:h_old.stage(j).option.repeat
        save('xp1')
        [x_opt, fval] = Optimizer(h_old.obj,h_old.stage(j).option,n,T,F,x_init,T1,lb,ub,h_old.eng.rpm,h_old.eng.torque,h_old.eng.M,h_old.sus);
              
        if fval<f_val_total
            f_val_total = fval;
            x_opt_total = x_opt;
       end

    end
    h_old.stage(j).x_opt_partial = x_opt';
        h_old.stage(j).x_opt = x_opt_total;
        h_new=h_old;
       end