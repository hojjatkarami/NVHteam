function stage0 = read_input(h)
    %h is handle to input file
unit_conv = [1e-3*ones(9,1); pi/180 * ones(9,1); 1e3*ones(18,1); 1;1000;1000;1;1];    

stage0.x_init = unit_conv .* ...
                [h.mount.r_1, h.mount.r_2, h.mount.r_3,...
               h.mount.o_1, h.mount.o_2, h.mount.o_3,...
               h.mount.k_l_1, h.mount.k_l_2, h.mount.k_l_3,...
               h.mount.c_l_1, h.mount.c_l_2, h.mount.c_l_3,...
               h.mount.m_m, h.mount.k_m, h.mount.c_m,...
               10,10]';
stage0.x_opt = stage0.x_init;               
stage0.lb = unit_conv .* ... 
               [h.mount.lb_r_1, h.mount.lb_r_2,h.mount.lb_r_3,...
               h.mount.lb_o_1, h.mount.lb_o_2,h.mount.lb_o_3,...
               h.mount.lb_k_1, h.mount.lb_k_2,h.mount.lb_k_3,...
               h.mount.lb_c_1, h.mount.lb_c_2,h.mount.lb_c_3,...
               h.mount.m_m, h.mount.k_m, h.mount.c_m,...
               0,0]';
stage0.ub = unit_conv .* ...
            [h.mount.ub_r_1, h.mount.ub_r_2, h.mount.ub_r_3,...
               h.mount.ub_o_1, h.mount.ub_o_2, h.mount.ub_o_3,...
               h.mount.ub_k_1, h.mount.ub_k_2, h.mount.ub_k_3,...
               h.mount.ub_c_1, h.mount.ub_c_2, h.mount.ub_c_3,...
               h.mount.m_m, h.mount.k_m, h.mount.c_m,...
               100,100]';
           
%% SUSPENSION PARAMETERS %%
% Ohadi's Data
% Note: 1 & 4 belong to the front of the vehicle.
% Note: 1 & 2 belong to the driver side of the vehicle.
% unsprung mass %

stage0.sus.Mu1 = h.sus.Mu1; stage0.sus.Mu4 = stage0.sus.Mu1;  % Front
stage0.sus.Mu2 = h.sus.Mu2; stage0.sus.Mu3 = stage0.sus.Mu2;  % Back

% tires stiffness %
stage0.sus.kt1 = h.sus.kt1;
stage0.sus.kt2 = h.sus.kt1;
stage0.sus.kt3 = h.sus.kt1;
stage0.sus.kt4 = h.sus.kt1;

% suspension stiffness and damping %
stage0.sus.ks1 = h.sus.ks1;
stage0.sus.cs1 = h.sus.cs1;
stage0.sus.ks2 = h.sus.ks2;
stage0.sus.cs2 = h.sus.cs2;
stage0.sus.ks3 = h.sus.ks3;
stage0.sus.cs3 = h.sus.cs3;
stage0.sus.ks4 = h.sus.ks4;
stage0.sus.cs4 = h.sus.cs4;

% sprung mass %
stage0.sus.Ms = h.sus.Ms;
stage0.sus.Isxx = h.sus.Isxx;
stage0.sus.Isyy = h.sus.Isyy;

% axle positions %
stage0.sus.Xs1 = h.sus.Xs1 * 1e-3; % mm to m
stage0.sus.Ys1 = h.sus.Ys1 * 1e-3; % mm to m
stage0.sus.Xs3 = h.sus.Xs3 * 1e-3; % mm to m
stage0.sus.Ys3 = h.sus.Ys3 * 1e-3; % mm to m
stage0.sus.Xs2 = h.sus.Xs2 * 1e-3; % mm to m
stage0.sus.Ys2 = h.sus.Ys2 * 1e-3; % mm to m
stage0.sus.Xs4 = h.sus.Xs4 * 1e-3; % mm to m
stage0.sus.Ys4 = h.sus.Ys4 * 1e-3; % mm to m

% engine center of mass in vehicle coordinates %
stage0.sus.E_cm = h.sus.E_cm * 1e-3; % mm to m

%% Engine Properties
stage0.eng.mass = h.eng.mass; %kg
stage0.eng.inertia = h.eng.inertia; %kg.m^2
stage0.eng.rpm = h.eng.rpm * pi/15; %rpm
rpm = transpose(stage0.eng.rpm);

stage0.eng.torque = h.eng.torque; %N.m
 
stage0.eng.M_tilda = h.mount.m_m;
stage0.eng.M = [stage0.eng.mass*eye(3)  zeros(3,3); zeros(3,3) stage0.eng.inertia];
stage0.eng.M_e = [stage0.eng.M, zeros(6,1); zeros(1,6), stage0.eng.M_tilda];

%% interpolate local body stiffness

StiffLocBody = h.StiffLocBody;


rpm_stiff = StiffLocBody.k1(:,1)
StiffLocBody.k1(:,2:end)

Temp = interp1(rpm_stiff,StiffLocBody.k1(:,2:end),rpm,'linear','extrap');
StiffLocBody.k1 = Temp';
Temp = interp1(rpm_stiff,StiffLocBody.k2(:,2:end),rpm,'linear','extrap');
StiffLocBody.k2 = Temp';
Temp = interp1(rpm_stiff,StiffLocBody.k3(:,2:end),rpm,'linear','extrap');
StiffLocBody.k3 = Temp';

Temp = interp1(rpm_stiff,StiffLocBody.c1(:,2:end),rpm,'linear','extrap');
StiffLocBody.c1 = Temp';
Temp = interp1(rpm_stiff,StiffLocBody.c2(:,2:end),rpm,'linear','extrap');
StiffLocBody.c2 = Temp';
Temp = interp1(rpm_stiff,StiffLocBody.c3(:,2:end),rpm,'linear','extrap');
StiffLocBody.c3 = Temp';

%% determine optimization parameters
t1 = h.stage0.t1;  % vector  : 1 for bounded, 0 for fixed
t1(40)=1;
T = eye(41); %transform matrix
T(19:21,19:21)=h.stage0.t_k1;
T(22:24,22:24)=h.stage0.t_k2;
T(25:27,25:27)=h.stage0.t_k3;
T(28:30,19:21)=h.stage0.t_c1;
T(31:33,22:24)=h.stage0.t_c2;
T(34:36,25:27)=h.stage0.t_c3;
T(28:36,28:36) = zeros(9);
% structural constraints has been set

t2 = diag(T);   %vector : 1 for independent and 0 for dependent

stage0.t1 = t1;
stage0.T = T;
stage0.t2 = t2;

end