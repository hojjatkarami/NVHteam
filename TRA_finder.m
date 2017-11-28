function [q_TRA,R_TRA] = TRA_finder(I,v)
%%% 960906 Code Modified
%%% "I" is the Inertia Matrix (3*3) and "v" is the direction of the crankshaft (3*1)
%%% "q_TRA" is the direction of the TRA and "R_TRA" is the rotation matrix
%%% from the reference coordinate to TRA coordinate system.

if size(v,1) < size(v,2)
    v = v';
end

q_TRA_0 = I^(-1)*v;
q_TRA = q_TRA_0/norm(q_TRA_0);

% R_1 = q_TRA';
% v_yy0 = 0.2; v_yz0 = 0.35; v_zz0 = 0.79;
% v_yx0 = -(R_1(2)*v_yy0+R_1(3)*v_yz0)/R_1(1);
% R_2 = [v_yx0 v_yy0 v_yz0]/norm([v_yx0 v_yy0 v_yz0]);
% 
% R_3 = [(-[R_1(1) R_1(2);R_2(1) R_2(2)]^(-1)*[R_1(3);R_2(3)]*v_zz0)' v_zz0]...
%     /norm([(-[R_1(1) R_1(2);R_2(1) R_2(2)]^(-1)*[R_1(3);R_2(3)]*v_zz0)' v_zz0]);

e0 = [1; 0; 0];
c = cross(e0,q_TRA);
c = c/norm(c);
a = cross(q_TRA,c);
a = a/norm(a);

R_TRA = [a';q_TRA';c'];