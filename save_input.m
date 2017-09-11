
% load(['SavedResults/','temp_inpp.mat']);


h.sus.ChassisID = app.ChasisIDEditField.Value;
h.sus.Isxx = app.I_xxEditField.Value;
h.sus.Isyy = app.I_yyEditField.Value;
h.sus.Ms = app.SprungMassEditField.Value;
h.sus.Mu1 = app.UnsprungMassEditField.Value;%front
h.sus.Mu4 = app.UnsprungMassEditField.Value;%front
h.sus.Mu3 = app.UnsprungMassEditField_2.Value;%rear
h.sus.Mu2 = app.UnsprungMassEditField_2.Value;%rear
h.sus.ks1 = app.StiffnessEditField.Value;
h.sus.ks4 = app.StiffnessEditField.Value;
h.sus.ks3 = app.StiffnessEditField_2.Value;
h.sus.ks2 = app.StiffnessEditField_2.Value;
h.sus.cs1 = app.DampingEditField.Value;
h.sus.cs4 = app.DampingEditField.Value;
h.sus.cs3 = app.DampingEditField_2.Value;
h.sus.cs2 = app.DampingEditField_2.Value;
h.sus.Xs1 = app.wheel_pos(1); h.sus.Ys1 = app.wheel_pos(2);
h.sus.Xs2 = app.wheel_pos(3); h.sus.Ys2 = app.wheel_pos(4);
h.sus.Xs3 = app.wheel_pos(5); h.sus.Ys3 = app.wheel_pos(6);
h.sus.Xs4 = app.wheel_pos(7); h.sus.Ys4 = app.wheel_pos(8);
h.sus.kt1 = app.StiffnessEditField_3.Value;
h.sus.kt2 = app.StiffnessEditField_3.Value;
h.sus.kt3 = app.StiffnessEditField_3.Value;
h.sus.kt4 = app.StiffnessEditField_3.Value;
h.sus.E_cm = eval(app.COMofEnginexyzinmmEditField.Value);
h.eng.name = app.EngineNameEditField.Value;
h.eng.model = app.EngineModelEditField.Value;
h.eng.tire = app.ModelEditField.Value;
h.eng.mass = app.MasskgEditField.Value;

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

h.eng.idle_speed = app.IdlespeedEditField.Value;
h.eng.max_torque = app.TorqueIdlespeedEditField_2.Value;
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

h.mount.etha1 = app.ProportionalCheckBox.Value * app.ethaEditField.Value;
h.mount.etha2 = app.ProportionalCheckBox_2.Value * app.ethaEditField_2.Value;
h.mount.etha3 = app.ProportionalCheckBox_3.Value * app.ethaEditField_3.Value;


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
re =app.t1

load(['SavedResults/','gui_curr']);
load(['SavedResults/',gui_curr.input_name]);
% delete(['SavedResults/',gui_curr.input_name]);
gui_curr.input_name = app.InputNameEditField.Value;
eval([gui_curr.input_name(1:end-4),'=h;']);
save(['SavedResults/',gui_curr.input_name],gui_curr.input_name(1:end-4));
