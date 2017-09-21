function h_new = run(h,j)
stage1 = h.stage(j);
n=stage1.n;
T = stage1.T;
T1 = stage1.T1;
F = stage1.F;
x_init = stage1.x_init;
lb = stage1.lb(find(F==0));
ub = stage1.ub(find(F==0));


switch h.stage(j).type
    
    case 'TRA'
        
        [x_opt, ~] = TRA_Optimizer(h.stage(j).option,n,T,F,x_init,T1,lb,ub);

        
    case 'TF'
        [x_opt, ~] = TF_Optimizer(h.stage(j).option,n,T,F,x_init,T1,lb,ub);
    case 'TA'
        [x_opt, ~] = TA_Optimizer(h.stage(j).option,n,T,F,x_init,T1,lb,ub);
    case 'Ar'
        [x_opt, ~] = Ar_Optimizer(h.stage(j).option,n,T,F,x_init,T1,lb,ub);
     
end
h.stage(j).x_opt_partial = x_opt';
h.stage(j).x_opt =  T * (F .* x_init + T1*x_opt');

h_new=h;


