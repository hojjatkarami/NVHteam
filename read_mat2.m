
global StiffLocBody
% this function converts gui units to code units


% h.sus = g.sus;
% h.eng = g.eng;
% h.mount = g.mount;
% h.stage0 = g.stage0;

StiffLocBody = g.StiffLocBody;

% h.stage(j) = f;

%% SUSPENSION PARAMETERS %%
% Ohadi's Data
% Note: 1 & 4 belong to the front of the vehicle.
% Note: 1 & 2 belong to the driver side of the vehicle.
% unsprung mass %
h.sus.Mu1 = g.sus.Mu1; h.sus.Mu4 = h.sus.Mu1;  % Front
h.sus.Mu2 = g.sus.Mu2; h.sus.Mu3 = h.sus.Mu2;  % Back

% tires stiffness %
h.sus.kt1 = g.sus.kt1;
h.sus.kt2 = g.sus.kt1;
h.sus.kt3 = g.sus.kt1;
h.sus.kt4 = g.sus.kt1;

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
h.sus.Xs1 = g.sus.Xs1 * 1e-3; % mm to m
h.sus.Ys1 = g.sus.Ys1 * 1e-3; % mm to m
h.sus.Xs3 = g.sus.Xs3 * 1e-3; % mm to m
h.sus.Ys3 = g.sus.Ys3 * 1e-3; % mm to m
h.sus.Xs2 = g.sus.Xs2 * 1e-3; % mm to m
h.sus.Ys2 = g.sus.Ys2 * 1e-3; % mm to m
h.sus.Xs4 = g.sus.Xs4 * 1e-3; % mm to m
h.sus.Ys4 = g.sus.Ys4 * 1e-3; % mm to m

% engine center of mass in vehicle coordinates %
h.sus.E_cm = g.sus.E_cm * 1e-3; % mm to m

%% Engine Properties
h.eng.mass = g.eng.mass; %kg
h.eng.inertia = g.eng.inertia; %kg.m^2
h.eng.rpm = g.eng.rpm; %rpm
h.eng.torque = g.eng.torque; %N.m
 
h.eng.Fhat = [0;0;0;0;h.eng.torque;0];
h.eng.omega = (h.eng.rpm)*pi/15;

h.eng.M = [h.eng.mass*eye(3)  zeros(3,3); zeros(3,3) h.eng.inertia];


%% Initial mounts properties %%
%% Mounts Positions %%
h.mount.r_1 = g.mount.r_1' *1e-3;
h.mount.r_2 = g.mount.r_2' *1e-3;
h.mount.r_3 = g.mount.r_3' *1e-3;

%% Mounts Orientations %%
h.mount.o_1 = g.mount.o_1'*pi/180;
h.mount.o_2 = g.mount.o_2'*pi/180;
h.mount.o_3 = g.mount.o_3'*pi/180;

%% Mounts Stiffness %%
h.mount.k_l_1 = g.mount.k_l_1' .*1000;      %N/mm to N/m
h.mount.k_l_2 = g.mount.k_l_2' .*1000;
h.mount.k_l_3 = g.mount.k_l_3' .*1000;

%% Mounts Damping %%
h.mount.c_l_1 = g.mount.c_l_1' .* 1000;
h.mount.c_l_2 = g.mount.c_l_2' .* 1000;
h.mount.c_l_3 = g.mount.c_l_3' .* 1000;


%% Hydraulic Properties
h.mount.m_m = g.mount.m_m;
h.mount.c_m = g.mount.k_m * 1000;
h.mount.k_m = g.mount.c_m * 1000;
%% Lower and upper bounds for design variables %%

%% Lower Bounds for Positions %%
h.mount.lb_r_1 = g.mount.lb_r_1'*1e-3;    
h.mount.lb_r_2 = g.mount.lb_r_2'*1e-3;
h.mount.lb_r_3 = g.mount.lb_r_3'*1e-3;

%% Upper Bounds for Positions %%
h.mount.ub_r_1 = g.mount.ub_r_1'*1e-3;
h.mount.ub_r_2 = g.mount.ub_r_2'*1e-3;
h.mount.ub_r_3 = g.mount.ub_r_3'*1e-3;

%% Lower Bounds for Orientation %%
h.mount.lb_o_1 = g.mount.lb_o_1'*pi/180;
h.mount.lb_o_2 = g.mount.lb_o_2'*pi/180;
h.mount.lb_o_3 = g.mount.lb_o_3'*pi/180;

%% Upper Bounds for Orientation %%
h.mount.ub_o_1 = g.mount.ub_o_1'*pi/180;
h.mount.ub_o_2 = g.mount.ub_o_2'*pi/180;
h.mount.ub_o_3 = g.mount.ub_o_3'*pi/180;

%% Lower Bounds for Stiffness %%
h.mount.lb_k_1 = g.mount.lb_k_1' .*1000;
h.mount.lb_k_2 = g.mount.lb_k_2' .*1000;
h.mount.lb_k_3 = g.mount.lb_k_3' .*1000;

%% Upper Bounds for Stiffness %%
h.mount.ub_k_1 = g.mount.ub_k_1' .*1000;
h.mount.ub_k_2 = g.mount.ub_k_2' .*1000;
h.mount.ub_k_3 = g.mount.ub_k_3' .*1000;
%% Lower Bounds for Damping %%
h.mount.lb_c_1 = g.mount.lb_c_1' .*1000;
h.mount.lb_c_2 = g.mount.lb_c_2' .*1000;
h.mount.lb_c_3 = g.mount.lb_c_3' .*1000;

%% Upper Bounds for Damping %%
h.mount.ub_c_1 = g.mount.ub_c_1' .*1000;
h.mount.ub_c_2 = g.mount.ub_c_2' .*1000;
h.mount.ub_c_3 = g.mount.ub_c_3' .*1000;
%% Mode frequency bounds
h.stage(j).lb_freq = f.lb_freq';
h.stage(j).ub_freq = f.ub_freq';

%% Lower Bound for TRA frequency %%
lb_w_TRA = 2*pi*h.stage(j).lb_freq(5);

%% Upper Bound for TRA frequency %%
ub_w_TRA = 2*pi*h.stage(j).ub_freq(5);
 

 

%% Totally %%

h.stage0.lb = [h.mount.lb_r_1; h.mount.lb_r_2;h.mount.lb_r_3;...
               h.mount.lb_o_1; h.mount.lb_o_2;h.mount.lb_o_3;...
               h.mount.lb_k_1; h.mount.lb_k_2;h.mount.lb_k_3;...
               h.mount.lb_c_1; h.mount.lb_c_2; h.mount.lb_c_3;...
               h.mount.m_m; h.mount.k_m; h.mount.c_m;...
               lb_w_TRA];
h.stage0.ub = [h.mount.ub_r_1; h.mount.ub_r_2; h.mount.ub_r_3;...
               h.mount.ub_o_1; h.mount.ub_o_2; h.mount.ub_o_3;...
               h.mount.ub_k_1; h.mount.ub_k_2; h.mount.ub_k_3;...
               h.mount.ub_c_1; h.mount.ub_c_2; h.mount.ub_c_3;...
               h.mount.m_m; h.mount.k_m; h.mount.c_m;...
               ub_w_TRA];

                          h.stage0.x_init = [h.mount.r_1; h.mount.r_2; h.mount.r_3;...
                                   h.mount.o_1; h.mount.o_2; h.mount.o_3;...
                                   h.mount.k_l_1; h.mount.k_l_2; h.mount.k_l_3;...
                                   h.mount.c_l_1; h.mount.c_l_2; h.mount.c_l_3;...
                                   h.mount.m_m; h.mount.k_m; h.mount.c_m;...
                                   10];
h.stage0.x_opt = h.stage0.x_init;

t1 = g.stage0.t1;  % vector  : 1 for bounder, 0 for fixed

T = eye(40); %transform matrix
T(19:21,19:21)=g.stage0.t_k1;
T(22:24,22:24)=g.stage0.t_k2;
T(25:27,25:27)=g.stage0.t_k3;
T(19:21,28:30)=g.stage0.t_c1;
T(22:24,31:33)=g.stage0.t_c2;
T(25:27,34:36)=g.stage0.t_c3;

% structural constraints has been set
t2 = diag(T);   %vector : 1 for independent and 0 for dependent

F = (t1 .* t2)==0; % vector : 0 for bounded and independent variables and 1 for others

% t1(43)=1;       %now w_TRA will is an optimization variable

t3 = find(F==0); % vector of optimization indices which are bounded-independent varibles

n=length(t3);       % number of optimization variables

T1 = zeros(40,n);   %Transformation matrix where T*x(optimizition var)=x(design variables)
% x_main = T (F x_init + T1 x_opt)

for ii=1:n
    
       T1(t3(ii),ii)=1; 
end
h.stage0.n = n;
h.stage0.t1 = t1;
h.stage0.t2 = t2;
h.stage0.T = T;
h.stage0.T1 = T1;
h.stage0.F = F;


%%  %%
a=f.DeltaStatic;
h.stage(j).DeltaStatic = [a(1)/1000 , a(2)/1000 , a(3)/1000 , a(4) / 180/pi , a(5) / 180/pi , a(6) / 180/pi]';
h.stage(j).KED = f.KED;
h.stage(j).TF = f.TF;
h.stage(j).TA = f.TA;
h.stage(j).Ar = f.Ar;

h.stage(j).type=f.type;
h.stage(j).name=f.name;
h.stage(j).swarmsize=f.swarmsize;
h.stage(j).MaxFuncEval=f.MaxFuncEval;
h.stage(j).FuncTol=f.FuncTol;
h.stage(j).MaxIter=f.MaxIter;
h.stage(j).PenFuncWeight=f.PenFuncWeight;

a = f.ub_purt;
h.stage(j).ub_purt = [a.loc1, a.loc2, a.loc3,...
             a.ori1, a.ori2, a.ori3,...
             a.stiff1, a.stiff2, a.stiff3,...
             a.damp1, a.damp2, a.damp3,...
             0,0,0,...
             1]'/100;
a = f.lb_purt;
h.stage(j).lb_purt = [a.loc1, a.loc2, a.loc3,...
             a.ori1, a.ori2, a.ori3,...
             a.stiff1, a.stiff2, a.stiff3,...
             a.damp1, a.damp2, a.damp3,...
             0,0,0,...
             1]'/100;

         
%% STAGE 1
if strcmp(h.stage(j).type,'TRA')
    t1(40)=1;       %now w_TRA will is an optimization variable
else
    t1(40)=0;
end
t_ub = h.stage(j).ub_purt; %vector corresponding to purturbed values of each variable
t_lb = h.stage(j).lb_purt; %vector corresponding to purturbed values of each variable
F = ((t_ub~=0).*t1 .* t2)==0; % vector : 0 for bounded-independent-purturbed variables and 1 for others
t3 = find(F==0); % vector of optimization indices which are bounded-independent-purturbed varibles
                            
n=length(t3);       % number of optimization variables

T1 = zeros(40,n);   %Transformation matrix where T*x(optimizition var)=x(design variables)
% x_main = T (F x_init + T1 x_opt)

for ii=1:n
    
       T1(t3(ii),ii)=1; 
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
    stage0=h.stage(j-1)
end
save('xp')
h.stage(j).x_init = stage0.x_opt;

x_init = h.stage(j).x_init;
size(x_init)
size(stage0.lb)
size(h.stage(j).ub_purt)
lb = (x_init - h.stage(j).ub_purt .* ( x_init - stage0.lb));
ub = (x_init + h.stage(j).ub_purt .* ( stage0.ub - x_init));
h.stage(j).lb = lb;
h.stage(j).ub = ub;
% lb = lb(find(F==0));
% ub = ub(find(F==0));

