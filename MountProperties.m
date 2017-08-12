%% Initial mounts properties %%

%% Mounts Positions %%
r_1 = [900 476.267 440.66]'*1e-3 - [807.342 153.998 312.416]'*1e-3;
r_2 = [1133 -182.685 57]'*1e-3 - [807.342 153.998 312.416]'*1e-3;
r_3 = [619.09 -122 116.167]'*1e-3 - [807.342 153.998 312.416]'*1e-3;

%% Mounts Orientations %%
o_1 = [0 0 90]'*pi/180;
o_2 = [0 0 0]'*pi/180;
o_3 = [0 -10 0]'*pi/180;

%% Mounts Stiffness %%
k_l_1 = ([18.2 40 31])'*1e3*5;
k_l_2 = ([29.4 12.2 28])'*1e3*5;
k_l_3 = ([16 31.2 30])'*1e3*5;

%% Mounts Damping %%
eta = 0.01;
c_l_1 = eta*k_l_1;
c_l_2 = eta*k_l_2;
c_l_3 = eta*k_l_3;
% c_l_1 = diag([30 30 30]);
% c_l_2 = diag([30 30 30]);
% c_l_3 = diag([30 30 30]);

%% Lower and upper bounds for design variables %%

%% Lower Bounds for Positions %%
lb_r_1 = [-200 -380 -50]'*1e-3;    
lb_r_2 = [415 -390 -180]'*1e-3;
lb_r_3 = [-190 -460 -70]'*1e-3;

%% Upper Bounds for Positions %%
ub_r_1 = [250 400 215]'*1e-3;
ub_r_2 = [430 210 -170]'*1e-3;
ub_r_3 = [250 450 210]'*1e-3;

%% Lower Bounds for Orientation %%
lb_o_1 = o_1;%+[-0.1 -0.1 -0.1]'*pi/4;
lb_o_2 = o_2;%+[-0.1 -0.1 -0.1]'*pi/4;
lb_o_3 = o_3;%+[-0.1 -0.1 -0.1]'*pi/4;

%% Upper Bounds for Orientation %%
ub_o_1 = o_1;%+[0.1 0.1 0.1]'*pi/4;
ub_o_2 = o_2;%+[0.1 0.1 0.1]'*pi/4;
ub_o_3 = o_3;%+[0.1 0.1 0.1]'*pi/4;

%% Lower Bounds for Stiffness %%
lb_k_1 = [1e4 3e4 2e4]'*5;
lb_k_2 = [2e4 1e4 1.5e4]'*5;
lb_k_3 = [1e4 2e4 2e4]'*5;

%% Upper Bounds for Stiffness %%
ub_k_1 = [3e4 5e4 4e4]'*5;
ub_k_2 = [4e4 2e4 4e4]'*5;
ub_k_3 = [3e4 4e4 4e4]'*5;

%% Mode frequency bounds
f_nat_lb = [7;7;9;11;11;0];
f_nat_ub = [100;100;11;14;14;18];

%% Lower Bound for TRA frequency %%
lb_w_TRA = 2*pi*f_nat_lb(5);

%% Upper Bound for TRA frequency %%
ub_w_TRA = 2*pi*f_nat_ub(5);

%% Totally %%
lb = [lb_r_1; lb_r_2; lb_r_3; lb_o_1; lb_o_2; lb_o_3; lb_k_1; lb_k_2; lb_k_3; lb_w_TRA];
ub = [ub_r_1; ub_r_2; ub_r_3; ub_o_1; ub_o_2; ub_o_3; ub_k_1; ub_k_2; ub_k_3; ub_w_TRA];

%% Initial States %%
x_init = [r_1;r_2;r_3;o_1;o_2;o_3;k_l_1;k_l_2;k_l_3];