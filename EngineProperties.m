%% Engine properties %%
eng.m = h.eng.mass;
eng.I = h.eng.inertia;
eng.idle_speed = h.eng.idle_speed;
eng.max_torque = h.eng.max_torque;
eng.DeltaStatic = g.DeltaStatic';
Fhat = [0;0;0;0;eng.max_torque;0];
omega = (eng.idle_speed)*pi/15;

eng.M = [eng.m*eye(3)  zeros(3,3); zeros(3,3) eng.I];

%% *******************************THIS IS MAIN FILE*******************
% %% Engine properties %%
% 
% eng.m = 122.922;
% eng.I = [5.163   0.301    -0.3680
%          0.301    3.458     0.222
%         -0.3680    0.222     4.431];
% eng.idle_speed = 1000;
% eng.max_torque = 70;
% 
% Fhat = [0;0;0;0;eng.max_torque;0];
% omega = (eng.idle_speed)*pi/15;
% 
% M = [eng.m*eye(3)  zeros(3,3); zeros(3,3) eng.I];
