%% Initial mounts properties %%
%% Mounts Positions %%
r_1 = h.mount.r_1' *1e-3;
r_2 = h.mount.r_2' *1e-3;
r_3 = h.mount.r_3' *1e-3;

%% Mounts Orientations %%
o_1 = h.mount.o_1'*pi/180;
o_2 = h.mount.o_2'*pi/180;
o_3 = h.mount.o_3'*pi/180;

%% Mounts Stiffness %%
k_l_1 = h.mount.k_l_1' .*1000;
k_l_2 = h.mount.k_l_1' .*1000;
k_l_3 = h.mount.k_l_1' .*1000;

%% Mounts Damping %%
etha = 0.01;%h.mount.etha;
c_l_1 = h.mount.c_l_1';
c_l_2 = h.mount.c_l_2';
c_l_3 = h.mount.c_l_3';

%% Lower and upper bounds for design variables %%

%% Lower Bounds for Positions %%
lb_r_1 = h.mount.lb_r_1'*1e-3;    
lb_r_2 = h.mount.lb_r_2'*1e-3;
lb_r_3 = h.mount.lb_r_3'*1e-3;

%% Upper Bounds for Positions %%
ub_r_1 = h.mount.ub_r_1'*1e-3;
ub_r_2 = h.mount.ub_r_2'*1e-3;
ub_r_3 = h.mount.ub_r_3'*1e-3;

%% Lower Bounds for Orientation %%
lb_o_1 = h.mount.lb_o_1'*pi/180;
lb_o_2 = h.mount.lb_o_2'*pi/180;
lb_o_3 = h.mount.lb_o_3'*pi/180;

%% Upper Bounds for Orientation %%
ub_o_1 = h.mount.ub_o_1'*pi/180;
ub_o_2 = h.mount.ub_o_2'*pi/180;
ub_o_3 = h.mount.ub_o_3'*pi/180;

%% Lower Bounds for Stiffness %%
lb_k_1 = h.mount.lb_k_1' .*1000;
lb_k_2 = h.mount.lb_k_2' .*1000;
lb_k_3 = h.mount.lb_k_3' .*1000;

%% Upper Bounds for Stiffness %%
ub_k_1 = h.mount.ub_k_1' .*1000;
ub_k_2 = h.mount.ub_k_2' .*1000;
ub_k_3 = h.mount.ub_k_3' .*1000;

%% Mode frequency bounds
f_nat_lb = g.lb_freq';
f_nat_ub = g.ub_freq';

%% Lower Bound for TRA frequency %%
lb_w_TRA = 2*pi*f_nat_lb(5);

%% Upper Bound for TRA frequency %%
ub_w_TRA = 2*pi*f_nat_ub(5);

%% Totally %%
lb = [lb_r_1; lb_r_2; lb_r_3; lb_o_1; lb_o_2; lb_o_3; lb_k_1; lb_k_2; lb_k_3; lb_w_TRA];
ub = [ub_r_1; ub_r_2; ub_r_3; ub_o_1; ub_o_2; ub_o_3; ub_k_1; ub_k_2; ub_k_3; ub_w_TRA];

%% Initial States %%
x_init = [r_1;r_2;r_3;o_1;o_2;o_3;k_l_1;k_l_2;k_l_3];
