function [M_v,C_v,K_v] = BodyParameters(x,sus,M_e)
% 960907 Code Readed
[~,~,k_1,k_2,k_3,c_1,c_2,c_3] = stiff_cal(x,1);

r_1 = x(1:3);
r_2 = x(4:6);
r_3 = x(7:9);
o_1 = x(10:12);
k_m_1 = x(38);
c_m_1 = x(39);

% Cross product matrices for position of the mounts
b_1 = [0 -r_1(3) r_1(2) ; r_1(3) 0 -r_1(1) ; -r_1(2) r_1(1) 0];
b_2 = [0 -r_2(3) r_2(2) ; r_2(3) 0 -r_2(1) ; -r_2(2) r_2(1) 0];
b_3 = [0 -r_3(3) r_3(2) ; r_3(3) 0 -r_3(1) ; -r_3(2) r_3(1) 0];

% Orientation of the mounts
s1_1 = sin(o_1(1));  s1_2 = sin(o_1(2)); s1_3 = sin(o_1(3));
% s2_1 = sin(o_2(1));  s2_2 = sin(o_2(2)); s2_3 = sin(o_2(3));
% s3_1 = sin(o_3(1));  s3_2 = sin(o_3(2)); s3_3 = sin(o_3(3));

c1_1 = cos(o_1(1));  c1_2 = cos(o_1(2)); c1_3 = cos(o_1(3));
% c2_1 = cos(o_2(1));  c2_2 = cos(o_2(2)); c2_3 = cos(o_2(3));
% c3_1 = cos(o_3(1));  c3_2 = cos(o_3(2)); c3_3 = cos(o_3(3));

A_1 = [c1_3*c1_2 -s1_3*c1_1+c1_3*s1_2*s1_1 s1_3*s1_1+c1_3*s1_2*c1_1;
            s1_3*c1_2 c1_3*c1_1+s1_3*s1_2*s1_1 -c1_3*s1_1+s1_3*s1_2*c1_1;
          -s1_2 c1_2*s1_1 c1_2*c1_1];
% A_2 = [c2_3*c2_2 -s2_3*c2_1+c2_3*s2_2*s2_1 s2_3*s2_1+c2_3*s2_2*c2_1;
%            s2_3*c2_2 c2_3*c2_1+s2_3*s2_2*s2_1 -c2_3*s2_1+s2_3*s2_2*c2_1;
%           -s2_2 c2_2*s2_1 c2_2*c2_1];
% A_3 = [c3_3*c3_2 -s3_3*c3_1+c3_3*s3_2*s3_1 s3_3*s3_1+c3_3*s3_2*c3_1;
%            s3_3*c3_2 c3_3*c3_1+s3_3*s3_2*s3_1 -c3_3*s3_1+s3_3*s3_2*c3_1;
%          -s3_2 c3_2*s3_1 c3_2*c3_1];

%%
R_1 = sus.E_cm + r_1;
R_2 = sus.E_cm + r_2;
R_3 = sus.E_cm + r_3;

B_1  = [0 -R_1(3) R_1(2) ; R_1(3) 0 -R_1(1) ; -R_1(2) R_1(1) 0];
B_2  = [0 -R_2(3) R_2(2) ; R_2(3) 0 -R_2(1) ; -R_2(2) R_2(1) 0];
B_3  = [0 -R_3(3) R_3(2) ; R_3(3) 0 -R_3(1) ; -R_3(2) R_3(1) 0];

M_v = zeros(14,14);
C_v = zeros(14,14);
K_v = zeros(14,14);

%% Total Mass
M_v(1:4,1:4) = diag([sus.Mu1 sus.Mu2 sus.Mu3 sus.Mu4]);
M_v(5:7,5:7) = diag([sus.Ms sus.Isxx sus.Isyy]);
M_v(8:14,8:14) = M_e;

%% Total Damping
C_v(1:4,1:4) = diag([sus.cs1, sus.cs2, sus.cs3, sus.cs4]);
C_v(1,5:7) = [-sus.cs1 -sus.cs1*sus.Ys1 sus.cs1*sus.Xs1];
C_v(2,5:7) = [-sus.cs2 -sus.cs2*sus.Ys2 sus.cs2*sus.Xs2];
C_v(3,5:7) = [-sus.cs3 -sus.cs3*sus.Ys3 sus.cs3*sus.Xs3];
C_v(4,5:7) = [-sus.cs4 -sus.cs4*sus.Ys4 sus.cs4*sus.Xs4];

C_v(5:7,1:14) = ...
    [-1;-sus.Ys1;sus.Xs1]*sus.cs1*[1 0 0 0 -1 -sus.Ys1 sus.Xs1 zeros(1,7)] + ...
    [-1;-sus.Ys2;sus.Xs2]*sus.cs2*[0 1 0 0 -1 -sus.Ys2 sus.Xs2 zeros(1,7)] + ...
    [-1;-sus.Ys3;sus.Xs3]*sus.cs3*[0 0 1 0 -1 -sus.Ys3 sus.Xs3 zeros(1,7)] + ...
    [-1;-sus.Ys4;sus.Xs4]*sus.cs4*[0 0 0 1 -1 -sus.Ys4 sus.Xs4 zeros(1,7)] + ...
    [0 0 -1;0 R_2(3) -R_2(2);-R_2(3) 0 R_2(1)]*c_2*([eye(3) B_2']*[zeros(6,7) eye(6,6) zeros(6,1)]-[eye(3) B_2']*[zeros(2,14);[zeros(3,4) eye(3) zeros(3,7)];zeros(1,14)]) + ...
    [0 0 -1;0 R_3(3) -R_3(2);-R_3(3) 0 R_3(1)]*c_3*([eye(3) B_3']*[zeros(6,7) eye(6,6) zeros(6,1)]-[eye(3) B_3']*[zeros(2,14);[zeros(3,4) eye(3) zeros(3,7)];zeros(1,14)]) +...
    [0 0 -1;0 R_1(3) -R_1(2);-R_1(3) 0 R_1(1)]*(c_1*([eye(3) B_1']*[zeros(6,7) eye(6,6) zeros(6,1)]-[eye(3) B_1']*[zeros(2,14);[zeros(3,4) eye(3) zeros(3,7)];zeros(1,14)]) + ...
                                                A_1*[0;0;c_m_1]*([zeros(1,13) 1]-[0 0 1]*[eye(3) B_1']*[zeros(2,14);[zeros(3,4) eye(3) zeros(3,7)];zeros(1,14)])) ;

C_v(8:13,1:14) = ...
    [eye(3);B_1]*c_1*([eye(3) B_1']*[zeros(6,7) eye(6,6) zeros(6,1)]-[eye(3) B_1']*[zeros(2,14);[zeros(3,4) eye(3) zeros(3,7)];zeros(1,14)]) + ...
    [eye(3);B_2]*c_2*([eye(3) B_2']*[zeros(6,7) eye(6,6) zeros(6,1)]-[eye(3) B_2']*[zeros(2,14);[zeros(3,4) eye(3) zeros(3,7)];zeros(1,14)]) + ...
    [eye(3);B_3]*c_3*([eye(3) B_3']*[zeros(6,7) eye(6,6) zeros(6,1)]-[eye(3) B_3']*[zeros(2,14);[zeros(3,4) eye(3) zeros(3,7)];zeros(1,14)]);

C_v(14,1:14) = c_m_1*([zeros(1,13) 1]-[0 0 1]*[eye(3) B_1']*[zeros(2,14);[zeros(3,4) eye(3) zeros(3,7)];zeros(1,14)]);

%% Total Stiffness
K_v(1:4,1:4) = diag([(sus.kt1+sus.ks1), (sus.kt2+sus.ks2), (sus.kt3+sus.ks3), (sus.kt4+sus.ks4)]);
K_v(1,5:7) = [-sus.ks1 -sus.ks1*sus.Ys1 sus.ks1*sus.Xs1];
K_v(2,5:7) = [-sus.ks2 -sus.ks2*sus.Ys2 sus.ks2*sus.Xs2];
K_v(3,5:7) = [-sus.ks3 -sus.ks3*sus.Ys3 sus.ks3*sus.Xs3];
K_v(4,5:7) = [-sus.ks4 -sus.ks4*sus.Ys4 sus.ks4*sus.Xs4];
K_v(5:7,1:14) = ...
    [-1;-sus.Ys1;sus.Xs1]*sus.ks1*[1 0 0 0 -1 -sus.Ys1 sus.Xs1 zeros(1,7)] + ...
    [-1;-sus.Ys2;sus.Xs2]*sus.ks2*[0 1 0 0 -1 -sus.Ys2 sus.Xs2 zeros(1,7)] + ...
    [-1;-sus.Ys3;sus.Xs3]*sus.ks3*[0 0 1 0 -1 -sus.Ys3 sus.Xs3 zeros(1,7)] + ...
    [-1;-sus.Ys4;sus.Xs4]*sus.ks4*[0 0 0 1 -1 -sus.Ys4 sus.Xs4 zeros(1,7)] + ...
    [0 0 -1;0 R_2(3) -R_2(2);-R_2(3) 0 R_2(1)]*k_2*([eye(3) B_2']*[zeros(6,7) eye(6,6) zeros(6,1)]-[eye(3) B_2']*[zeros(2,14);[zeros(3,4) eye(3) zeros(3,7)];zeros(1,14)]) + ...
    [0 0 -1;0 R_3(3) -R_3(2);-R_3(3) 0 R_3(1)]*k_3*([eye(3) B_3']*[zeros(6,7) eye(6,6) zeros(6,1)]-[eye(3) B_3']*[zeros(2,14);[zeros(3,4) eye(3) zeros(3,7)];zeros(1,14)]) +...
    [0 0 -1;0 R_1(3) -R_1(2);-R_1(3) 0 R_1(1)]*k_1*([eye(3) B_1']*[zeros(6,7) eye(6,6) zeros(6,1)]-[eye(3) B_1']*[zeros(2,14);[zeros(3,4) eye(3) zeros(3,7)];zeros(1,14)]) ;

K_v(8:13,1:14) = ...
    [eye(3);B_1]*(k_1*([eye(3) B_1']*[zeros(6,7) eye(6,6) zeros(6,1)]-[eye(3) B_1']*[zeros(2,14);[zeros(3,4) eye(3) zeros(3,7)];zeros(1,14)]) + ...
                  A_1*[0;0;k_m_1]*([0 0 1]*A_1'*[eye(3) B_1']*[zeros(6,7) eye(6,6) zeros(6,1)]-[zeros(1,13) 1])) + ...
    [eye(3);B_2]*k_2*([eye(3) B_2']*[zeros(6,7) eye(6,6) zeros(6,1)]-[eye(3) B_2']*[zeros(2,14);[zeros(3,4) eye(3) zeros(3,7)];zeros(1,14)]) + ...
    [eye(3);B_3]*k_3*([eye(3) B_3']*[zeros(6,7) eye(6,6) zeros(6,1)]-[eye(3) B_3']*[zeros(2,14);[zeros(3,4) eye(3) zeros(3,7)];zeros(1,14)]);

K_v(14,1:14) = k_m_1*([zeros(1,13) 1]-[0 0 1]*[eye(3) B_1']*[zeros(6,7) eye(6,6) zeros(6,1)]);


K_v(1:4,1:4) = diag([(sus.kt1+sus.ks1), (sus.kt2+sus.ks2), (sus.kt3+sus.ks3), (sus.kt4+sus.ks4)]);
K_v(1,5:7) = [-sus.ks1 -sus.ks1*sus.Ys1 sus.ks1*sus.Xs1];
K_v(2,5:7) = [-sus.ks2 -sus.ks2*sus.Ys2 sus.ks2*sus.Xs2];
K_v(3,5:7) = [-sus.ks3 -sus.ks3*sus.Ys3 sus.ks3*sus.Xs3];
K_v(4,5:7) = [-sus.ks4 -sus.ks4*sus.Ys4 sus.ks4*sus.Xs4];
K_v(5:7,1:13) = ...
    [-1;-sus.Ys1;sus.Xs1]*sus.ks1*[1 0 0 0 -1 -sus.Ys1 sus.Xs1 zeros(1,6)] + ...
    [-1;-sus.Ys2;sus.Xs2]*sus.ks2*[0 1 0 0 -1 -sus.Ys2 sus.Xs2 zeros(1,6)] + ...
    [-1;-sus.Ys3;sus.Xs3]*sus.ks3*[0 0 1 0 -1 -sus.Ys3 sus.Xs3 zeros(1,6)] + ...
    [-1;-sus.Ys4;sus.Xs4]*sus.ks4*[0 0 0 1 -1 -sus.Ys4 sus.Xs4 zeros(1,6)] + ...
    [0 0 -1;0 R_1(3) -R_1(2);-R_1(3) 0 R_1(1)]*k_1*([eye(3) B_1']*[zeros(6,7) eye(6,6)]-[eye(3) B_1']*[zeros(2,13);[zeros(3,4) eye(3) zeros(3,6)];zeros(1,13)]) + ...
    [0 0 -1;0 R_2(3) -R_2(2);-R_2(3) 0 R_2(1)]*k_2*([eye(3) B_2']*[zeros(6,7) eye(6,6)]-[eye(3) B_2']*[zeros(2,13);[zeros(3,4) eye(3) zeros(3,6)];zeros(1,13)]) + ...
    [0 0 -1;0 R_3(3) -R_3(2);-R_3(3) 0 R_3(1)]*k_3*([eye(3) B_3']*[zeros(6,7) eye(6,6)]-[eye(3) B_3']*[zeros(2,13);[zeros(3,4) eye(3) zeros(3,6)];zeros(1,13)]);
K_v(8:13,1:13) = ...
    [eye(3);B_1]*k_1*([eye(3) B_1']*[zeros(6,7) eye(6,6)]-[eye(3) B_1']*[zeros(2,13);[zeros(3,4) eye(3) zeros(3,6)];zeros(1,13)]) + ...
    [eye(3);B_2]*k_2*([eye(3) B_2']*[zeros(6,7) eye(6,6)]-[eye(3) B_2']*[zeros(2,13);[zeros(3,4) eye(3) zeros(3,6)];zeros(1,13)]) + ...
    [eye(3);B_3]*k_3*([eye(3) B_3']*[zeros(6,7) eye(6,6)]-[eye(3) B_3']*[zeros(2,13);[zeros(3,4) eye(3) zeros(3,6)];zeros(1,13)]);