function dz = eng_vehicle(t, z, x, eta, M, eng, sus)

m = M(1,1);
I = M(4:6,4:6);

dz = z;
dz(1:13) = z(14:26);

rm1 = [x(1);x(2);x(3)];
rm2 = [x(4);x(5);x(6)];
rm3 = [x(7);x(8);x(9)];

om1 = [x(10);x(11);x(12)];
om2 = [x(13);x(14);x(15)];
om3 = [x(16);x(17);x(18)];

km1 = diag(x(19:21));
km2 = diag(x(22:24));
km3 = diag(x(25:27));

cm1 = eta*km1;
cm2 = eta*km2;
cm3 = eta*km3;

Am1 = [cos(om1(3))*cos(om1(2)) -sin(om1(3))*cos(om1(1))+cos(om1(3))*sin(om1(2))*sin(om1(1)) sin(om1(3))*sin(om1(1))+cos(om1(3))*sin(om1(2))*cos(om1(1));
    sin(om1(3))*cos(om1(2)) cos(om1(3))*cos(om1(1))+sin(om1(3))*sin(om1(2))*sin(om1(1)) -cos(om1(3))*sin(om1(1))+sin(om1(3))*sin(om1(2))*cos(om1(1));
    -sin(om1(2)) cos(om1(2))*sin(om1(1)) cos(om1(2))*cos(om1(1))];
Am2 = [cos(om2(3))*cos(om2(2)) -sin(om2(3))*cos(om2(1))+cos(om2(3))*sin(om2(2))*sin(om2(1)) sin(om2(3))*sin(om2(1))+cos(om2(3))*sin(om2(2))*cos(om2(1));
    sin(om2(3))*cos(om2(2)) cos(om2(3))*cos(om2(1))+sin(om2(3))*sin(om2(2))*sin(om2(1)) -cos(om2(3))*sin(om2(1))+sin(om2(3))*sin(om2(2))*cos(om2(1));
    -sin(om2(2)) cos(om2(2))*sin(om2(1)) cos(om2(2))*cos(om2(1))];
Am3 = [cos(om3(3))*cos(om3(2)) -sin(om3(3))*cos(om3(1))+cos(om3(3))*sin(om3(2))*sin(om3(1)) sin(om3(3))*sin(om3(1))+cos(om3(3))*sin(om3(2))*cos(om3(1));
    sin(om3(3))*cos(om3(2)) cos(om3(3))*cos(om3(1))+sin(om3(3))*sin(om3(2))*sin(om3(1)) -cos(om3(3))*sin(om3(1))+sin(om3(3))*sin(om3(2))*cos(om3(1));
    -sin(om3(2)) cos(om3(2))*sin(om3(1)) cos(om3(2))*cos(om3(1))];

Km1 = Am1*km1*Am1';
Km2 = Am2*km2*Am2';
Km3 = Am3*km3*Am3';


Cm1 = Am1*cm1*Am1';
Cm2 = Am2*cm2*Am2';
Cm3 = Am3*cm3*Am3';

Be1  = [0 -rm1(3) rm1(2) ; rm1(3) 0 -rm1(1) ; -rm1(2) rm1(1) 0];
Be2  = [0 -rm2(3) rm2(2) ; rm2(3) 0 -rm2(1) ; -rm2(2) rm2(1) 0];
Be3  = [0 -rm3(3) rm3(2) ; rm3(3) 0 -rm3(1) ; -rm3(2) rm3(1) 0];

Rm1 = rm1 + sus.E_cm;
Rm2 = rm2 + sus.E_cm;
Rm3 = rm3 + sus.E_cm;

Bb1  = [0 -Rm1(3) Rm1(2) ; Rm1(3) 0 -Rm1(1) ; -Rm1(2) Rm1(1) 0];
Bb2  = [0 -Rm2(3) Rm2(2) ; Rm2(3) 0 -Rm2(1) ; -Rm2(2) Rm2(1) 0];
Bb3  = [0 -Rm3(3) Rm3(2) ; Rm3(3) 0 -Rm3(1) ; -Rm3(2) Rm3(1) 0];

%% mounts forces %%
re1 = [eye(3) Be1']*z(8:13);
re2 = [eye(3) Be2']*z(8:13);
re3 = [eye(3) Be3']*z(8:13);

re1_d = [eye(3) Be1']*z(21:26);
re2_d = [eye(3) Be2']*z(21:26);
re3_d = [eye(3) Be3']*z(21:26);

rb1 = [eye(3) Bb1']*[0;0;z(5:7);0];
rb2 = [eye(3) Bb2']*[0;0;z(5:7);0];
rb3 = [eye(3) Bb3']*[0;0;z(5:7);0];

rb1_d = [eye(3) Bb1']*[0;0;z(18:20);0];
rb2_d = [eye(3) Bb2']*[0;0;z(18:20);0];
rb3_d = [eye(3) Bb3']*[0;0;z(18:20);0];

Fm1 = Km1*(re1-rb1) + Cm1*(re1_d-rb1_d);
Fm2 = Km2*(re2-rb2) + Cm2*(re2_d-rb2_d);
Fm3 = Km3*(re3-rb3) + Cm3*(re3_d-rb3_d);

fm1 = [-Fm1 ; -Be1*Fm1];
fm2 = [-Fm2 ; -Be2*Fm2];
fm3 = [-Fm3 ; -Be3*Fm3];

%% suspension forces %%
Fs1 = sus.ks1*(z(1)-z(5)-z(6)*sus.Ys1+z(7)*sus.Xs1) + sus.cs1*(z(14)-z(18)-z(19)*sus.Ys1+z(20)*sus.Xs1);
Fs2 = sus.ks2*(z(2)-z(5)-z(6)*sus.Ys2+z(7)*sus.Xs2) + sus.cs2*(z(15)-z(18)-z(19)*sus.Ys2+z(20)*sus.Xs2);
Fs3 = sus.ks3*(z(3)-z(5)-z(6)*sus.Ys3+z(7)*sus.Xs3) + sus.cs3*(z(16)-z(18)-z(19)*sus.Ys3+z(20)*sus.Xs3);
Fs4 = sus.ks4*(z(4)-z(5)-z(6)*sus.Ys4+z(7)*sus.Xs4) + sus.cs4*(z(17)-z(18)-z(19)*sus.Ys4+z(20)*sus.Xs4);

%% Engine Forces %%
F = [0;0;0;0;eng.max_torque*sin((eng.idle_speed)*pi/15*t);0];

%% Second Derivatives %%
dz(14) = 1/sus.Mu1 * (-sus.kt1*z(1) - sus.ks1*(z(1)-z(5)-z(6)*sus.Ys1+z(7)*sus.Xs1) - sus.cs1*(z(14)-z(18)-z(19)*sus.Ys1+z(20)*sus.Xs1));
dz(15) = 1/sus.Mu2 * (-sus.kt2*z(2) - sus.ks2*(z(2)-z(5)-z(6)*sus.Ys2+z(7)*sus.Xs2) - sus.cs2*(z(15)-z(18)-z(19)*sus.Ys2+z(20)*sus.Xs2));
dz(16) = 1/sus.Mu3 * (-sus.kt3*z(3) - sus.ks3*(z(3)-z(5)-z(6)*sus.Ys3+z(7)*sus.Xs3) - sus.cs3*(z(16)-z(18)-z(19)*sus.Ys3+z(20)*sus.Xs3));
dz(17) = 1/sus.Mu4 * (-sus.kt4*z(4) - sus.ks4*(z(4)-z(5)-z(6)*sus.Ys4+z(7)*sus.Xs4) - sus.cs4*(z(17)-z(18)-z(19)*sus.Ys4+z(20)*sus.Xs4));

dz(18) = 1/sus.Ms * (Fm1(3)+Fm2(3)+Fm3(3) + Fs1+Fs2+Fs3+Fs4);
dz(19) = 1/sus.Isxx * (Fm1(3)*Rm1(2)-Fm1(2)*Rm1(3)+Fm2(3)*Rm2(2)-Fm2(2)*Rm2(3)+Fm3(3)*Rm3(2)-Fm3(2)*Rm3(3) + Fs1*sus.Ys1+Fs2*sus.Ys2+Fs3*sus.Ys3+Fs4*sus.Ys4);
dz(20) = 1/sus.Isyy * (Fm1(1)*Rm1(3)-Fm1(3)*Rm1(1)+Fm2(1)*Rm2(3)-Fm2(3)*Rm2(1)+Fm3(1)*Rm3(3)-Fm3(3)*Rm3(1) - Fs1*sus.Xs1-Fs2*sus.Xs2-Fs3*sus.Xs3-Fs4*sus.Xs4);

dz(21:26) = [m*eye(3) zeros(3,3); zeros(3,3) I]^(-1)*(F + fm1+fm2+fm3);