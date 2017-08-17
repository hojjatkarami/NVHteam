%% Motor Parameters %%
eng.m = 139.5;
eng.I = [8.4930   -1.1870    -0.3680; -1.1870    3.5050     1.4760; -0.3680    1.4760     7.1470];
eng.idle_speed = 900;
eng.max_torque = 156;

%% Mounts Positions and Orientations %%
r_1 = [-13.5 389 203]'*1e-3;
r_2 = [424 -92 -175]'*1e-3;
r_3 = [-182 -454 -68]'*1e-3;

o_1 = [0 0 0]'*pi/180;
o_2 = [0 0 0]'*pi/180;
o_3 = [0 0 0]'*pi/180;

%% Elastomeric Mounts Parameters %%
% Mounts Stiffness %
k_l_1 = ([91 200 512.95])'*1e3;
k_l_2 = ([29.4 12.2 28])'*1e3*5;
k_l_3 = ([16 31.2 30])'*1e3*5;

% Mounts Damping %
eta = 0.01;
c_l_1 = eta*k_l_1;
c_l_1(3) = 198;
c_l_2 = eta*k_l_2;
c_l_3 = eta*k_l_3;

%% Hydraulic Mount Parameters %%
m_m_1 = 62.8; 
c_m_1 = 2666;
k_m_1 = 436.95e3;

%% Initial Design Parameters
x_init = [r_1; r_2; r_3; o_1; o_2; o_3; k_l_1; k_l_2; k_l_3; k_m_1; c_l_1; c_l_2; c_l_3; c_m_1];

%% SUSPENSION PARAMETERS %%
% Ohadi's Data
% Note: 1 & 4 belong to the front of the vehicle.
% Note: 1 & 2 belong to the driver side of the vehicle.

% unsprung mass %
sus.Mu1 = 29.5; sus.Mu4 = sus.Mu1;  % Front
sus.Mu2 = 27.5; sus.Mu3 = sus.Mu2;  % Back

% tires stiffness %
sus.kt1 = 200e3;
sus.kt2 = sus.kt1;
sus.kt3 = sus.kt1;
sus.kt4 = sus.kt1;

% suspension stiffness and damping %
sus.ks1 = 20580;
sus.cs1 = 3200;
sus.ks2 = 19600;
sus.cs2 = 1700;
sus.ks3 = 19600;
sus.cs3 = 1700;
sus.ks4 = 20580;
sus.cs4 = 3200;

% sprung mass %
sus.Ms = 868;
sus.Isxx = 235;
sus.Isyy = 920;

% axle positions %
sus.Xs1 = -1400e-3;
sus.Ys1 = -720e-3;
sus.Xs3 = 1400e-3;
sus.Ys3 = 720e-3;
sus.Xs2 = 1400e-3;
sus.Ys2 = -720e-3;
sus.Xs4 = -1400e-3;
sus.Ys4 = 720e-3;

% engine center of mass in vehicle coordinates %
sus.E_cm = [-807.342 -153.998 312.416]'*1e-3;