function Fval = obj_KED(K_e, M_e)

    KEF = KEF_cal(K_e(1:6,1:6),M_e(1:6,1:6));

    Fval = 0;
    for j = 1:6
%         Fval = Fval + (100-max(KEF(:,j)))^2;
        Fval = Fval + heaviside(max(KEF(:,j))-85)^2;           % Must be changed
    end
end