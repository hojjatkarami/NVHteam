
%% SUSPENSION PARAMETERS %%
% Ohadi's Data
% Note: 1 & 4 belong to the front of the vehicle.
% Note: 1 & 2 belong to the driver side of the vehicle.
% unsprung mass %
sus.Mu1 = h.sus.Mu1; sus.Mu4 = sus.Mu1;  % Front
sus.Mu2 = h.sus.Mu2; sus.Mu3 = sus.Mu2;  % Back

% tires stiffness %
sus.kt1 = h.sus.kt1;
sus.kt2 = sus.kt1;
sus.kt3 = sus.kt1;
sus.kt4 = sus.kt1;

% suspension stiffness and damping %
sus.ks1 = h.sus.ks1;
sus.cs1 = h.sus.cs1;
sus.ks2 = h.sus.ks2;
sus.cs2 = h.sus.cs2;
sus.ks3 = h.sus.ks3;
sus.cs3 = h.sus.cs3;
sus.ks4 = h.sus.ks4;
sus.cs4 = h.sus.cs4;

% sprung mass %
sus.Ms = h.sus.Ms;
sus.Isxx = h.sus.Isxx;
sus.Isyy = h.sus.Isyy;

% axle positions %
sus.Xs1 = h.sus.Xs1;
sus.Ys1 = h.sus.Ys1;
sus.Xs3 = h.sus.Xs3;
sus.Ys3 = h.sus.Ys3;
sus.Xs2 = h.sus.Xs2;
sus.Ys2 = h.sus.Ys2;
sus.Xs4 = h.sus.Xs4;
sus.Ys4 = h.sus.Ys4;

% engine center of mass in vehicle coordinates %
sus.E_cm = h.sus.E_cm;
%% *************************THIS IS MAIN FILE******************************

% %% SUSPENSION PARAMETERS %%
% % Ohadi's Data
% % Note: 1 & 4 belong to the front of the vehicle.
% % Note: 1 & 2 belong to the driver side of the vehicle.
% 
% % unsprung mass %
% sus.Mu1 = 29.5; sus.Mu4 = sus.Mu1;  % Front
% sus.Mu2 = 27.5; sus.Mu3 = sus.Mu2;  % Back
% 
% % tires stiffness %
% sus.kt1 = 200e3;
% sus.kt2 = sus.kt1;
% sus.kt3 = sus.kt1;
% sus.kt4 = sus.kt1;
% 
% % suspension stiffness and damping %
% sus.ks1 = 20580;
% sus.cs1 = 3200;
% sus.ks2 = 19600;
% sus.cs2 = 1700;
% sus.ks3 = 19600;
% sus.cs3 = 1700;
% sus.ks4 = 20580;
% sus.cs4 = 3200;
% 
% % sprung mass %
% sus.Ms = 868;
% sus.Isxx = 235;
% sus.Isyy = 920;
% 
% % axle positions %
% sus.Xs1 = -1400e-3;
% sus.Ys1 = -720e-3;
% sus.Xs3 = 1400e-3;
% sus.Ys3 = 720e-3;
% sus.Xs2 = 1400e-3;
% sus.Ys2 = -720e-3;
% sus.Xs4 = -1400e-3;
% sus.Ys4 = 720e-3;
% 
% % engine center of mass in vehicle coordinates %
% sus.E_cm = [-807.342 -153.998 312.416]'*1e-3;