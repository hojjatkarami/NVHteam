
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
        
        TRA2;
        
    case 'TF'
        TF2;
    case 'TA'
        TA2;
    case 'Ar'
        Ar2;
     
end
h.stage(j).x_opt = stage1.x_opt;
h.stage(j).results = Result_Calc(h.stage(j).x_opt, Result_Parameters)
%         h.stage(j).lb = lb;
%         h.stage(j).ub = ub;
