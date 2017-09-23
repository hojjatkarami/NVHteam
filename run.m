function h_new = run(h_old,j)
stage1 = h_old.stage(j);
n=stage1.n;
T = stage1.T;
T1 = stage1.T1;
F = stage1.F;
x_init = stage1.x_init;

F_zero = find(F==0);
lb = stage1.lb(F_zero);
ub = stage1.ub(F_zero);

switch h_old.stage(j).type
    
    case 'TRA'
        
        [x_opt, ~] = TRA_Optimizer(h_old.stage(j).option,n,T,F,x_init,T1,lb,ub);

        
    case 'TF'
        [x_opt, ~] = TF_Optimizer(h_old.stage(j).option,n,T,F,x_init,T1,lb,ub);
    case 'TA'
        [x_opt, ~] = TA_Optimizer(h_old.stage(j).option,n,T,F,x_init,T1,lb,ub);
    case 'Ar'
        [x_opt, ~] = Ar_Optimizer(h_old.stage(j).option,n,T,F,x_init,T1,lb,ub);
     
end
h_old.stage(j).x_opt_partial = x_opt';
h_old.stage(j).x_opt =  T * (F .* x_init + T1*x_opt');

h_new=h_old;


