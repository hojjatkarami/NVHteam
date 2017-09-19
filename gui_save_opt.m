load(['SavedResults/','gui_curr.mat']);
load(['SavedResults/',gui_curr.opt_name]);
load(['SavedResults/',gui_curr.input_name]);
gui_curr.opt_name = app.OptimizationFileEditField.Value;
h = eval(gui_curr.opt_name(1:end-4));

h.name = app.StageNameEditField.Value;
h.type = app.StagetypeDropDown.Value;



h.stage1.TF.method = [app.MinimizemaximumForceButton_2.Value,               app.MinimizesummationofForcesButton_2.Value];
h.stage1.TA.method = [app.MinimizemaximumAccelerationButton_2.Value,        app.MinimizesummationofAccelerationsButton_2.Value];
h.stage1.Ar.method = [app.MinimizemaximumAccelerationratioButton_2.Value,   app.MinimizesummationofAccelerationratiosButton_2.Value];


h.stage1.TA.dir = [app.LocalXCheckBox_9.Value,  app.LocalYCheckBox_9.Value, app.LocalZCheckBox_9.Value, app.MagnitudeCheckBox_9.Value;...
                   app.LocalXCheckBox_10.Value,  app.LocalYCheckBox_10.Value, app.LocalZCheckBox_10.Value, app.MagnitudeCheckBox_10.Value;... 
                   app.LocalXCheckBox_11.Value,  app.LocalYCheckBox_11.Value, app.LocalZCheckBox_11.Value, app.MagnitudeCheckBox_11.Value];

h.stage1.Ar.dir = [app.LocalXCheckBox_12.Value,  app.LocalYCheckBox_12.Value, app.LocalZCheckBox_12.Value, app.MagnitudeCheckBox_12.Value;...
                   app.LocalXCheckBox_13.Value,  app.LocalYCheckBox_13.Value, app.LocalZCheckBox_13.Value, app.MagnitudeCheckBox_13.Value;... 
                   app.LocalXCheckBox_14.Value,  app.LocalYCheckBox_14.Value, app.LocalZCheckBox_14.Value, app.MagnitudeCheckBox_14.Value];

h.stage1.TF.dir = [app.LocalXCheckBox_4.Value,  app.LocalYCheckBox_4.Value, app.LocalZCheckBox_4.Value, app.MagnitudeCheckBox_4.Value;...
                   app.LocalXCheckBox_7.Value,  app.LocalYCheckBox_7.Value, app.LocalZCheckBox_7.Value, app.MagnitudeCheckBox_7.Value;... 
                   app.LocalXCheckBox_8.Value,  app.LocalYCheckBox_8.Value, app.LocalZCheckBox_8.Value, app.MagnitudeCheckBox_8.Value];




h.KED = app.percentageEditField.Value;
h.ked = app.percentageEditField.Value;
h.DeltaStatic =[app.EditField_25.Value,app.EditField_26.Value,...
                app.EditField_27.Value,app.EditField_28.Value,...
                app.EditField_29.Value,app.EditField_30.Value];
h.ub_freq =[app.EditField_32.Value,app.EditField_38.Value,...
            app.EditField_39.Value,app.EditField_40.Value,...
            app.EditField_41.Value,app.EditField_42.Value];
h.lb_freq =[app.EditField_31.Value,app.EditField_33.Value,...
            app.EditField_34.Value,app.EditField_35.Value,...
            app.EditField_36.Value,app.EditField_37.Value];

h.purt.stiff1 = app.UITable_purt.Data(1,2:10);

h.stage1.swarmsize = app.swarmsizeEditField_4.Value;
h.stage1.MaxFuncEval = app.MaxFuncEvalEditField_4.Value;
h.stage1.FuncTol = app.FuncTolEditField_4.Value;
h.stage1.MaxIter = app.MaxIterEditField_4.Value;
h.stage1.PenFuncWeight = app.PenFuncWeightEditField_4.Value;

load(['SavedResults/','gui_curr']);
% delete(['SavedResults/',gui_curr.opt_name]);
gui_curr.opt_name = app.OptimizationFileEditField.Value;
eval([gui_curr.opt_name(1:end-4),'=h;']);
save(['SavedResults/',gui_curr.opt_name],gui_curr.opt_name(1:end-4));
