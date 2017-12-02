function Fval = obj_KED(K_e, M_e,KED_cr)

    KEF = KEF_cal(K_e(1:6,1:6),M_e(1:6,1:6));
    KED = max(KEF)';
    dif = KED_cr*ones(6,1) - KED;
    Fval = heaviside(dif)' * dif;
    
  
end