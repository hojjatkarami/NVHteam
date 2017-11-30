function Fval_total = obj_main(x,T,F,x_init,T1, rpm,torque, M, obj)
Fval_total = 0;

x = T * (F .* x_init + T1*x');

[K_e,C_e] = stiff_cal(x,1);

if obj.TRA.value == 1

    Fval_total = Fval_total + obj.TRA.weight * obj_TRA_pure(x, M, K_e(1:6,1:6));
%     disp('TRA')
end
    if obj.TF.value == 1
    Fval_total = Fval_total + obj.TF.weight * obj_TF_pure(x,obj.TF.dir, obj.TF.method, rpm, torque, M,K_e(1:6,1:6),C_e(1:6,1:6));
% disp('TF')
    end
if obj.NF.value == 1
    Fval_total = Fval_total + obj.NF.weight * obj_NF(x, M,obj.NF.lb_freq',obj.NF.ub_freq');
% disp('NF')
end
if obj.KED.value == 1
    Fval_total = Fval_total + obj.KED.weight * obj_KED(K_e, M);
% disp('KED')
end

if obj.ST.value == 1
    Fval_total = Fval_total + obj.ST.weight * obj_ST(x,M,K_e, obj.ST.DeltaStatic, obj.ST.StaticTests, 1.5);
% disp('ST')
end

end