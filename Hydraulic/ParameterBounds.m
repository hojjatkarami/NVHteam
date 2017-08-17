%% Lower and upper bounds for design variables %%
% Lower Bounds for Positions %
lb_r_1 = [-200 -380 -50]'*1e-3;    
lb_r_2 = [415 -390 -180]'*1e-3;
lb_r_3 = [-190 -460 -70]'*1e-3;

% Upper Bounds for Positions %
ub_r_1 = [250 400 215]'*1e-3;
ub_r_2 = [430 210 -170]'*1e-3;
ub_r_3 = [250 450 210]'*1e-3;

% Lower Bounds for Orientation %
lb_o_1 = [-4 -4 -4]'*pi/4;
lb_o_2 = [-4 -4 -4]'*pi/4;
lb_o_3 = [-4 -4 -4]'*pi/4;

% Upper Bounds for Orientation %
ub_o_1 = [+4 +4 +4]'*pi/4;
ub_o_2 = [+4 +4 +4]'*pi/4;
ub_o_3 = [+4 +4 +4]'*pi/4;

% Lower Bounds for Stiffness %
lb_k_1 = [1e4 3e4 2e4]'*5;
lb_k_2 = [2e4 1e4 1.5e4]'*5;
lb_k_3 = [1e4 2e4 2e4]'*5;
lb_k_m_1 = 200e3;

% Upper Bounds for Stiffness %
ub_k_1 = [3e4 5e4 4e4]'*5;
ub_k_2 = [4e4 2e4 4e4]'*5;
ub_k_3 = [3e4 4e4 4e4]'*5;
ub_k_m_1 = 600e3;

% Lower Bounds for Damping %
lb_c_1 = [1e4 3e4 2e4]'*5*eta;
lb_c_2 = [2e4 1e4 1.5e4]'*5*eta;
lb_c_3 = [1e4 2e4 2e4]'*5*eta;
lb_c_m_1 = 1000;

% Upper Bounds for Damping %
ub_c_1 = [3e4 5e4 4e4]'*5*eta;
ub_c_2 = [4e4 2e4 4e4]'*5*eta;
ub_c_3 = [3e4 4e4 4e4]'*5*eta;
ub_c_m_1 = 4000;

% Lower Bound for TRA frequency %
lb_w_k_TRA = 2*pi*11;
lb_w_c_TRA = 0;

% Upper Bound for TRA frequency %
ub_w_k_TRA = Inf;
ub_w_c_TRA = Inf;

% Totally %
lb = [lb_r_1; lb_r_2; lb_r_3; lb_o_1; lb_o_2; lb_o_3; lb_k_1; lb_k_2; lb_k_3; lb_k_m_1; lb_c_1; lb_c_2; lb_c_3; lb_c_m_1; lb_w_k_TRA; lb_w_c_TRA];
ub = [ub_r_1; ub_r_2; ub_r_3; ub_o_1; ub_o_2; ub_o_3; ub_k_1; ub_k_2; ub_k_3; ub_k_m_1; ub_c_1; ub_c_2; ub_c_3; ub_c_m_1; ub_w_k_TRA; ub_w_c_TRA];
