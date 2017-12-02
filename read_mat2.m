function h=read_mat2(h_input,h_stage,j)

%% STAGE 1
if strcmp(h.stage(j).type,'TRA')
    t1(40)=1;       %now w_k_TRA will is an optimization variable
else
    t1(40)=0;
end
if strcmp(g.mount.config,'1 Hydraulic-2 Elastomeric')
    t1(41)=1;       %now w_c_TRA will is an optimization variable
else
    t1(41)=0;
end
h.stage(j).t_ub = t_ub;
%t1 and t2 are same as STAGE 0
h.stage(j).n = n;
h.stage(j).T = T;
h.stage(j).T1 = T1;
h.stage(j).F = F;
if j==1
    stage0=h.stage0;
else
    stage0=h.stage(j-1);
end

h.stage(j).x_init = stage0.x_opt;

x_init = h.stage(j).x_init;
% size(x_init)
% size(stage0.lb)
% size(h.stage(j).ub_purt)
lb = (x_init - h.stage(j).lb_purt .* ( x_init - stage0.lb));
ub = (x_init + h.stage(j).ub_purt .* ( stage0.ub - x_init));
save('xp')

h.stage(j).lb = lb;
h.stage(j).ub = ub;

%%
h_new=h;
