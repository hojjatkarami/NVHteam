%% Engine properties %%
eng.m = h.eng.mass;
eng.I = h.eng.inertia;
eng.idle_speed = h.eng.idle_speed;
eng.max_torque = h.eng.max_torque;
eng.DeltaStatic = g.DeltaStatic';
g.Fhat = [0;0;0;0;eng.max_torque;0];
g.omega = (eng.idle_speed)*pi/15;

eng.M = [eng.m*eye(3)  zeros(3,3); zeros(3,3) eng.I];
