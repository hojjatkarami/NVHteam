function h = save_mat(g)
% this function converts gui units to code units
% g is handle to saved .mat file
% h is handle to code datas
%% SUSPENSION PARAMETERS %%
% Ohadi's Data
% Note: 1 & 4 belong to the front of the vehicle.
% Note: 1 & 2 belong to the driver side of the vehicle.
% unsprung mass %
h=g;
h.sus.Mu1 = g.sus.Mu1; h.sus.Mu4 = h.sus.Mu1;  % Front
h.sus.Mu2 = g.sus.Mu2; h.sus.Mu3 = h.sus.Mu2;  % Back

% tires stiffness %
h.sus.kt1 = g.sus.kt1;
h.sus.kt2 = h.sus.kt1;
h.sus.kt3 = h.sus.kt1;
h.sus.kt4 = h.sus.kt1;

% suspension stiffness and damping %
h.sus.ks1 = g.sus.ks1;
h.sus.cs1 = g.sus.cs1;
h.sus.ks2 = g.sus.ks2;
h.sus.cs2 = g.sus.cs2;
h.sus.ks3 = g.sus.ks3;
h.sus.cs3 = g.sus.cs3;
h.sus.ks4 = g.sus.ks4;
h.sus.cs4 = g.sus.cs4;

% sprung mass %
h.sus.Ms = g.sus.Ms;
h.sus.Isxx = g.sus.Isxx;
h.sus.Isyy = g.sus.Isyy;

% axle positions %
h.sus.Xs1 = g.sus.Xs1 * 1e3; % m to mm
h.sus.Ys1 = g.sus.Ys1 * 1e3; % m to mm
h.sus.Xs3 = g.sus.Xs3 * 1e3; % m to mm
h.sus.Ys3 = g.sus.Ys3 * 1e3; % m to mm
h.sus.Xs2 = g.sus.Xs2 * 1e3; % m to mm
h.sus.Ys2 = g.sus.Ys2 * 1e3; % m to mm
h.sus.Xs4 = g.sus.Xs4 * 1e3; % m to mm
h.sus.Ys4 = g.sus.Ys4 * 13; % m to mm

% engine center of mass in vehicle coordinates %
h.sus.E_cm = g.sus.E_cm * 1e3; % m to mm

%% Engine Properties
h.eng.mass = g.eng.mass; %kg
h.eng.inertia = g.eng.inertia; %kg.m^2
h.eng.idle_speed = g.eng.rpm; %rpm
h.eng.max_torque = g.eng.torque; %N.m
% h.eng.DeltaStatic = g.DeltaStatic'; 
% h.eng.Fhat = [0;0;0;0;h.eng.max_torque;0];
% h.eng.omega = (h.eng.idle_speed)*pi/15;

h.eng.M = [h.eng.mass*eye(3)  zeros(3,3); zeros(3,3) h.eng.inertia];

%% Initial mounts properties %%
%% Mounts Positions %%
h.mount.r_1 = g.mount.r_1' *1e3;
h.mount.r_2 = g.mount.r_2' *1e3;
h.mount.r_3 = g.mount.r_3' *1e3;

%% Mounts Orientations %%
h.mount.o_1 = g.mount.o_1'*180/pi;
h.mount.o_2 = g.mount.o_2'*180/pi;
h.mount.o_3 = g.mount.o_3'*180/pi;

%% Mounts Stiffness %%
h.mount.k_l_1 = g.mount.k_l_1' ./1000;      %N/m to N/mm
h.mount.k_l_2 = g.mount.k_l_1' ./1000;
h.mount.k_l_3 = g.mount.k_l_1' ./1000;

%% Mounts Damping %%
h.mount.c_l_1 = diag(g.mount.c_l_1' ./ 1000);
h.mount.c_l_2 = diag(g.mount.c_l_2' ./ 1000);
h.mount.c_l_3 = diag(g.mount.c_l_3' ./ 1000);


%% Hydraulic Properties
h.mount.m_m = g.mount.m_m;
h.mount.c_m = g.mount.k_m / 1000;
h.mount.k_m = g.mount.c_m / 1000;
%% Lower and upper bounds for design variables %%

%% Lower Bounds for Positions %%
h.mount.lb_r_1 = g.mount.lb_r_1'*1e3;    
h.mount.lb_r_2 = g.mount.lb_r_2'*1e3;
h.mount.lb_r_3 = g.mount.lb_r_3'*1e3;

%% Upper Bounds for Positions %%
h.mount.ub_r_1 = g.mount.ub_r_1'*1e3;
h.mount.ub_r_2 = g.mount.ub_r_2'*1e3;
h.mount.ub_r_3 = g.mount.ub_r_3'*1e3;

%% Lower Bounds for Orientation %%
h.mount.lb_o_1 = g.mount.lb_o_1'/pi/180;
h.mount.lb_o_2 = g.mount.lb_o_2'/pi/180;
h.mount.lb_o_3 = g.mount.lb_o_3'/pi/180;

%% Upper Bounds for Orientation %%
h.mount.ub_o_1 = g.mount.ub_o_1'/pi/180;
h.mount.ub_o_2 = g.mount.ub_o_2'/pi/180;
h.mount.ub_o_3 = g.mount.ub_o_3'/pi/180;

%% Lower Bounds for Stiffness %%
h.mount.lb_k_1 = g.mount.lb_k_1' ./1000;
h.mount.lb_k_2 = g.mount.lb_k_2' ./1000;
h.mount.lb_k_3 = g.mount.lb_k_3' ./1000;

%% Upper Bounds for Stiffness %%
h.mount.ub_k_1 = g.mount.ub_k_1' ./1000;
h.mount.ub_k_2 = g.mount.ub_k_2' ./1000;
h.mount.ub_k_3 = g.mount.ub_k_3' ./1000;
%% Lower Bounds for Damping %%
h.mount.lb_c_1 = g.mount.lb_c_1' ./1000;
h.mount.lb_c_2 = g.mount.lb_c_2' ./1000;
h.mount.lb_c_3 = g.mount.lb_c_3' ./1000;

%% Upper Bounds for Damping %%
h.mount.ub_c_1 = g.mount.ub_c_1' ./1000;
h.mount.ub_c_2 = g.mount.ub_c_2' ./1000;
h.mount.ub_c_3 = g.mount.ub_c_3' ./1000;
%% Mode frequency bounds
% h.lb_freq = g.lb_freq';
% h.ub_freq = g.ub_freq';


%% Totally %%
% h.stage0.lb = [h.mount.lb_r_1; h.mount.lb_r_2;h.mount.lb_r_3;...
%                h.mount.lb_o_1; h.mount.lb_o_2;h.mount.lb_o_3;...
%                h.mount.lb_k_1; h.mount.lb_k_2;h.mount.lb_k_3;...
%                h.mount.lb_c_1; h.mount.lb_c_2; h.mount.lb_c_3;...
%                h.mount.etha1; h.mount.etha2; h.mount.etha3;...
%                h.mount.m_m; h.mount.k_m; h.mount.c_m;...
%                lb_w_TRA];
% h.stage0.ub = [h.mount.ub_r_1; h.mount.ub_r_2; h.mount.ub_r_3;...
%                h.mount.ub_o_1; h.mount.ub_o_2; h.mount.ub_o_3;...
%                h.mount.ub_k_1; h.mount.ub_k_2; h.mount.ub_k_3;...
%                h.mount.ub_c_1; h.mount.ub_c_2; h.mount.ub_c_3;...
%                h.mount.etha1; h.mount.etha2; h.mount.etha3;...
%                h.mount.m_m; h.mount.k_m; h.mount.c_m;...
%                ub_w_TRA];
%% Initial States %%
% h.stage0.init.x = [h.mount.r_1; h.mount.r_2; h.mount.r_3;...
%                    h.mount.o_1; h.mount.o_2; h.mount.o_3;...
%                    h.mount.k_l_1; h.mount.k_l_2; h.mount.k_l_3;...
%                    h.mount.c_l_1; h.mount.c_l_2; h.mount.c_l_3;...
%                    h.mount.etha1; h.mount.etha2; h.mount.etha3;...
%                    h.mount.m_m; h.mount.k_m; h.mount.c_m;...
%                    10];
% 
% h.stage0.t1 = g.stage0.t1;
% h.stage1 = g.stage1;
% h.stage2 = g.stage2;
% h.stage3 = g.stage3;
% 
% h.DeltaStatic = g.DeltaStatic';
% R = zeros(27,9);
% for i=1:9
%    R(3*i-2,i) = 1;
%    R(3*i-1,i) = 1;
%    R(3*i,i) = 1;
% end
% 
% h.stage1.purt = [R * cell2mat(g.stage1.purt)';ones(16,1)];
% h.stage2.purt = [R * cell2mat(g.stage2.purt)';ones(16,1)];
% h.stage3.purt = [R * cell2mat(g.stage3.purt)';ones(16,1)];
% h.KED = g.KED;
% h.ked = g.ked;
% a=g.DeltaStatic;
% h.DeltaStatic = [a(1)*1000 , a(2)*1000 , a(3)*1000 , a(4) * 180/pi , a(5) * 180/pi , a(6) * 180/pi]


end