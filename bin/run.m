function h_new = run(h_old,j)
    stage1 = h_old.stage(j);
    n=stage1.n;
    T = stage1.T;

    T1 = stage1.T1;
    size(T1)
    F = stage1.F;


    x_init = stage1.x_init;

    F_zero = find(F==0);
    lb = stage1.lb(F_zero);
    ub = stage1.ub(F_zero);
f_val_total = inf;
    for k=1:h_old.stage(j).option.repeat

        switch h_old.stage(j).type

            case 'TRA'
                [x_opt, fval] = TRA_Optimizer(h_old.stage(j).option,n,T,F,x_init,T1,lb,ub);
            case 'TF'
                [x_opt, fval] = TF_Optimizer(h_old.stage(j).option,n,T,F,x_init,T1,lb,ub);
            case 'TA'
                [x_opt, fval] = TA_Optimizer(h_old.stage(j).option,n,T,F,x_init,T1,lb,ub);
            case 'Ar'
                [x_opt, fval] = Ar_Optimizer(h_old.stage(j).option,n,T,F,x_init,T1,lb,ub);

        end
          % !!!!!!!!!!!!!!!!!!!      
        if fval<f_val_total
            f_val_total = fval;
            x_opt_total = x_opt;
       end

    end
    h_old.stage(j).x_opt_partial = x_opt';
        h_old.stage(j).x_opt =  T * (F .* x_init + T1*x_opt');
        h_new=h_old;