
% load(['SavedResults/','temp_inpp.mat']);


h.sus.ChassisID = app.ChasisIDEditField.Value;
h.sus.Isxx = app.I_xxkgm2EditField.Value;
h.sus.Isyy = app.I_yykgm2EditField.Value;
h.sus.Ms = app.SprungMasskgEditField.Value;
h.sus.Mu1 = app.UnsprungMasskgEditField_2.Value;%front
h.sus.Mu4 = app.UnsprungMasskgEditField_2.Value;%front
h.sus.Mu3 = app.UnsprungMasskgEditField.Value;%rear
h.sus.Mu2 = app.UnsprungMasskgEditField.Value;%rear
h.sus.ks1 = app.StiffnessNmmEditField_2.Value;
h.sus.ks4 = app.StiffnessNmmEditField_2.Value;
h.sus.ks3 = app.StiffnessNmmEditField.Value;
h.sus.ks2 = app.StiffnessNmmEditField.Value;
h.sus.cs1 = app.DampingNsmmEditField_2.Value;
h.sus.cs4 = app.DampingNsmmEditField_2.Value;
h.sus.cs3 = app.DampingNsmmEditField.Value;
h.sus.cs2 = app.DampingNsmmEditField.Value;
t=num2cell(eval(app.Wheel1positionmmEditField.Value));[h.sus.Xs1, h.sus.Ys1] = t{:};
t=num2cell(eval(app.Wheel2positionmmEditField.Value));[h.sus.Xs2, h.sus.Ys2] = t{:};
t=num2cell(eval(app.Wheel3positionmmEditField.Value));[h.sus.Xs3, h.sus.Ys3] = t{:};
t=num2cell(eval(app.Wheel4positionmmEditField.Value));[h.sus.Xs4, h.sus.Ys4] = t{:};

h.sus.kt1 = app.TireStiffnessEditField.Value;
h.sus.kt2 = app.TireStiffnessEditField.Value;
h.sus.kt3 = app.TireStiffnessEditField.Value;
h.sus.kt4 = app.TireStiffnessEditField.Value;
h.StiffLocBody.k1 = eval(app.Mount1EditField.Value);
h.StiffLocBody.k2 = eval(app.Mount2EditField.Value);
h.StiffLocBody.k3 = eval(app.Mount3EditField.Value);

h.StiffLocBody.c1 = eval(app.Mount1EditField_2.Value);
h.StiffLocBody.c2 = eval(app.Mount2EditField_2.Value);
h.StiffLocBody.c3 = eval(app.Mount3EditField_2.Value);

h.sus.E_cm = eval(app.COMofEnginexyzinmmEditField.Value);
h.eng.name = app.EngineNameEditField.Value;
h.eng.model = app.EngineModelEditField.Value;
% h.eng.tire = app.ModelEditField.Value;
h.eng.mass = app.EngineMasskgEditField.Value;

value = app.SymmetricCheckBox.Value;
if value == 1
    app.I_yxEditField.Value = app.I_xyEditField.Value;
    app.I_zxEditField.Value = app.I_xzEditField.Value;
    app.I_zyEditField.Value = app.I_yzEditField.Value;

end
h.eng.inertia = [app.I_xxEditField_2.Value app.I_xyEditField.Value app.I_xzEditField.Value;...
                app.I_yxEditField.Value app.I_yyEditField_2.Value app.I_yzEditField.Value;...
                app.I_zxEditField.Value app.I_zyEditField.Value app.I_zzEditField.Value];
h.eng.M = [h.eng.mass * eye(3),zeros(3);zeros(3),h.eng.inertia];

h.eng.rpm = eval(app.rpmMatrixEditField.Value);
h.eng.torque = eval(app.TorqueMatrixEditField.Value);
h.mount.config = app.ConfigurationDropDown.Value;
h.mount.k_l_1 = eval(app.edit_mount1stiff.Value);
h.mount.k_l_2 = eval(app.edit_mount2stiff.Value);
h.mount.k_l_3 = eval(app.edit_mount3stiff.Value);
h.mount.ub_k_1 = eval(app.edit_mount1stiff_ub.Value);
h.mount.ub_k_2 = eval(app.edit_mount2stiff_ub.Value);
h.mount.ub_k_3 = eval(app.edit_mount3stiff_ub.Value);
h.mount.lb_k_1 = eval(app.edit_mount1stiff_lb.Value);
h.mount.lb_k_2 = eval(app.edit_mount2stiff_lb.Value);
h.mount.lb_k_3 = eval(app.edit_mount3stiff_lb.Value);

h.mount.c_l_1 = eval(app.edit_mount1damp.Value);
h.mount.c_l_2 = eval(app.edit_mount2damp.Value);
h.mount.c_l_3 = eval(app.edit_mount3damp.Value);
h.mount.ub_c_1 = eval(app.edit_mount1damp_ub.Value);
h.mount.ub_c_2 = eval(app.edit_mount2damp_ub.Value);
h.mount.ub_c_3 = eval(app.edit_mount3damp_ub.Value);
h.mount.lb_c_1 = eval(app.edit_mount1damp_lb.Value);
h.mount.lb_c_2 = eval(app.edit_mount2damp_lb.Value);
h.mount.lb_c_3 = eval(app.edit_mount3damp_lb.Value);



h.mount.k_m = eval(app.edit_mount1_km.Value);
h.mount.m_m = eval(app.edit_mount1_mm.Value);
h.mount.c_m = eval(app.edit_mount1_cm.Value);

h.stage0.t_k1 = app.t_k1;
h.stage0.t_k2 = app.t_k2;
h.stage0.t_k3 = app.t_k3;
h.stage0.t_c1 = app.t_c1;
h.stage0.t_c2 = app.t_c2;
h.stage0.t_c3 = app.t_c3;

h.mount.r_1 = eval(app.edit_mount1position.Value);
h.mount.r_2 = eval(app.edit_mount2position.Value);
h.mount.r_3 = eval(app.edit_mount3position.Value);
h.mount.ub_r_1 = eval(app.edit_mount1locup.Value);
h.mount.ub_r_2 = eval(app.edit_mount2locup.Value);
h.mount.ub_r_3 = eval(app.edit_mount3locup.Value);
h.mount.lb_r_1 = eval(app.edit_mount1loclow.Value);
h.mount.lb_r_2 = eval(app.edit_mount2loclow.Value);
h.mount.lb_r_3 = eval(app.edit_mount3loclow.Value);

h.mount.o_1 = eval(app.edit_mount1orientation.Value);
h.mount.o_2 = eval(app.edit_mount2orientation.Value);
h.mount.o_3 = eval(app.edit_mount3orientation.Value);
h.mount.ub_o_1 = eval(app.edit_mount1oriup.Value);
h.mount.ub_o_2 = eval(app.edit_mount2oriup.Value);
h.mount.ub_o_3 = eval(app.edit_mount3oriup.Value);
h.mount.lb_o_1 = eval(app.edit_mount1orilow.Value);
h.mount.lb_o_2 = eval(app.edit_mount2orilow.Value);
h.mount.lb_o_3 = eval(app.edit_mount3orilow.Value);


h.stage0.t1 = app.t1;

load(['SavedResults/','gui_curr']);
load(['SavedResults/',gui_curr.input_name]);
% delete(['SavedResults/',gui_curr.input_name]);
gui_curr.input_name = [app.InputNameEditField.Value,'_inp'];
eval([gui_curr.input_name,'=h;']);
save(['SavedResults/',gui_curr.input_name,'.mat'],gui_curr.input_name);
