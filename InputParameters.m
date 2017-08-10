%% Engine and initial mounts properties %%

%% Engine Properties %%
eng.m = 122.922;
eng.I = [5.163   0.301    -0.3680
        0.301    3.458     0.222
        -0.3680    0.222     4.431];
eng.idle_speed = 1000;
eng.max_torque = 70;

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
res