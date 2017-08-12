%% Engine properties %%

eng.m = 122.922;
eng.I = [5.163   0.301    -0.3680
         0.301    3.458     0.222
        -0.3680    0.222     4.431];
eng.idle_speed = 1000;
eng.max_torque = 70;

Fhat = [0;0;0;0;eng.max_torque;0];
omega = (eng.idle_speed)*pi/15;

M = [eng.m*eye(3)  zeros(3,3); zeros(3,3) eng.I];
