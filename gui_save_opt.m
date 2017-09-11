load(['SavedResults/','gui_curr.mat']);
load(['SavedResults/',gui_curr.opt_name]);
load(['SavedResults/',gui_curr.input_name]);
gui_curr.opt_name = app.OptimizationFileEditField.Value;
h = eval(gui_curr.opt_name(1:end-4));



h.stage1.type = app.Stage1DropDown.Value;
h.stage2.type = app.Stage2DropDown.Value;
h.stage3.type = app.Stage3DropDown.Value;

h.stage1.TF.method = [app.MinimizemaximumForceButton_2.Value,               app.MinimizesummationofForcesButton_2.Value];
h.stage1.TA.method = [app.MinimizemaximumAccelerationButton_2.Value,        app.MinimizesummationofAccelerationsButton_2.Value];
h.stage1.Ar.method = [app.MinimizemaximumAccelerationratioButton_2.Value,   app.MinimizesummationofAccelerationratiosButton_2.Value];

h.stage2.TF.method = [app.MinimizemaximumForceButton_3.Value,               app.MinimizesummationofForcesButton_3.Value];
h.stage2.TA.method = [app.MinimizemaximumAccelerationButton_3.Value,        app.MinimizesummationofAccelerationsButton_3.Value];
h.stage2.Ar.method = [app.MinimizemaximumAccelerationratioButton_3.Value,   app.MinimizesummationofAccelerationratiosButton_3.Value];

h.stage3.TF.method = [app.MinimizemaximumForceButton_4.Value,               app.MinimizesummationofForcesButton_4.Value];
h.stage3.TA.method = [app.MinimizemaximumAccelerationButton_4.Value,        app.MinimizesummationofAccelerationsButton_4.Value];
h.stage3.Ar.method = [app.MinimizemaximumAccelerationratioButton_4.Value,   app.MinimizesummationofAccelerationratiosButton_4.Value];

h.stage1.TA.dir = [app.LocalXCheckBox_9.Value,  app.LocalYCheckBox_9.Value, app.LocalZCheckBox_9.Value, app.MagnitudeCheckBox_9.Value;...
                   app.LocalXCheckBox_10.Value,  app.LocalYCheckBox_10.Value, app.LocalZCheckBox_10.Value, app.MagnitudeCheckBox_10.Value;... 
                   app.LocalXCheckBox_11.Value,  app.LocalYCheckBox_11.Value, app.LocalZCheckBox_11.Value, app.MagnitudeCheckBox_11.Value];

h.stage1.Ar.dir = [app.LocalXCheckBox_12.Value,  app.LocalYCheckBox_12.Value, app.LocalZCheckBox_12.Value, app.MagnitudeCheckBox_12.Value;...
                   app.LocalXCheckBox_13.Value,  app.LocalYCheckBox_13.Value, app.LocalZCheckBox_13.Value, app.MagnitudeCheckBox_13.Value;... 
                   app.LocalXCheckBox_14.Value,  app.LocalYCheckBox_14.Value, app.LocalZCheckBox_14.Value, app.MagnitudeCheckBox_14.Value];

h.stage1.TF.dir = [app.LocalXCheckBox_4.Value,  app.LocalYCheckBox_4.Value, app.LocalZCheckBox_4.Value, app.MagnitudeCheckBox_4.Value;...
                   app.LocalXCheckBox_7.Value,  app.LocalYCheckBox_7.Value, app.LocalZCheckBox_7.Value, app.MagnitudeCheckBox_7.Value;... 
                   app.LocalXCheckBox_8.Value,  app.LocalYCheckBox_8.Value, app.LocalZCheckBox_8.Value, app.MagnitudeCheckBox_8.Value];


h.stage2.TA.dir = [app.LocalXCheckBox_18.Value,  app.LocalYCheckBox_18.Value, app.LocalZCheckBox_18.Value, app.MagnitudeCheckBox_18.Value;...
                   app.LocalXCheckBox_19.Value,  app.LocalYCheckBox_19.Value, app.LocalZCheckBox_19.Value, app.MagnitudeCheckBox_19.Value;... 
                   app.LocalXCheckBox_20.Value,  app.LocalYCheckBox_20.Value, app.LocalZCheckBox_20.Value, app.MagnitudeCheckBox_20.Value];

h.stage2.Ar.dir = [app.LocalXCheckBox_21.Value,  app.LocalYCheckBox_21.Value, app.LocalZCheckBox_21.Value, app.MagnitudeCheckBox_21.Value;...
                   app.LocalXCheckBox_22.Value,  app.LocalYCheckBox_22.Value, app.LocalZCheckBox_22.Value, app.MagnitudeCheckBox_22.Value;... 
                   app.LocalXCheckBox_23.Value,  app.LocalYCheckBox_23.Value, app.LocalZCheckBox_23.Value, app.MagnitudeCheckBox_23.Value];

h.stage2.TF.dir = [app.LocalXCheckBox_15.Value,  app.LocalYCheckBox_15.Value, app.LocalZCheckBox_15.Value, app.MagnitudeCheckBox_15.Value;...
                   app.LocalXCheckBox_16.Value,  app.LocalYCheckBox_16.Value, app.LocalZCheckBox_16.Value, app.MagnitudeCheckBox_16.Value;... 
                   app.LocalXCheckBox_17.Value,  app.LocalYCheckBox_17.Value, app.LocalZCheckBox_17.Value, app.MagnitudeCheckBox_17.Value];

h.stage3.TA.dir = [app.LocalXCheckBox_27.Value,  app.LocalYCheckBox_27.Value, app.LocalZCheckBox_27.Value, app.MagnitudeCheckBox_27.Value;...
                   app.LocalXCheckBox_28.Value,  app.LocalYCheckBox_28.Value, app.LocalZCheckBox_28.Value, app.MagnitudeCheckBox_28.Value;... 
                   app.LocalXCheckBox_29.Value,  app.LocalYCheckBox_29.Value, app.LocalZCheckBox_29.Value, app.MagnitudeCheckBox_29.Value];

h.stage3.Ar.dir = [app.LocalXCheckBox_30.Value,  app.LocalYCheckBox_30.Value, app.LocalZCheckBox_30.Value, app.MagnitudeCheckBox_30.Value;...
                   app.LocalXCheckBox_31.Value,  app.LocalYCheckBox_31.Value, app.LocalZCheckBox_31.Value, app.MagnitudeCheckBox_31.Value;... 
                   app.LocalXCheckBox_32.Value,  app.LocalYCheckBox_32.Value, app.LocalZCheckBox_32.Value, app.MagnitudeCheckBox_32.Value];

h.stage3.TF.dir = [app.LocalXCheckBox_24.Value,  app.LocalYCheckBox_24.Value, app.LocalZCheckBox_24.Value, app.MagnitudeCheckBox_24.Value;...
                   app.LocalXCheckBox_25.Value,  app.LocalYCheckBox_25.Value, app.LocalZCheckBox_25.Value, app.MagnitudeCheckBox_25.Value;... 
                   app.LocalXCheckBox_26.Value,  app.LocalYCheckBox_26.Value, app.LocalZCheckBox_26.Value, app.MagnitudeCheckBox_26.Value];






h.KED.per = app.percentageEditField.Value;
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

h.stage1.purt = app.UITable_purt.Data(1,2:10);
h.stage2.purt = app.UITable_purt.Data(2,2:10);
h.stage3.purt = app.UITable_purt.Data(3,2:10);

h.stage1.swarmsize = app.swarmsizeEditField_4.Value;
h.stage2.swarmsize = app.swarmsizeEditField_5.Value;
h.stage3.swarmsize = app.swarmsizeEditField_6.Value;
h.stage1.MaxFuncEval = app.MaxFuncEvalEditField_4.Value;
h.stage2.MaxFuncEval = app.MaxFuncEvalEditField_5.Value;
h.stage3.MaxFuncEval = app.MaxFuncEvalEditField_6.Value;
h.stage1.FuncTol = app.FuncTolEditField_4.Value;
h.stage2.FuncTol = app.FuncTolEditField_5.Value;
h.stage3.FuncTol = app.FuncTolEditField_6.Value;
h.stage1.MaxIter = app.MaxIterEditField_4.Value;
h.stage2.MaxIter = app.MaxIterEditField_5.Value;
h.stage3.MaxIter = app.MaxIterEditField_6.Value;
h.stage1.PenFuncWeight = app.PenFuncWeightEditField_4.Value;
h.stage2.PenFuncWeight = app.PenFuncWeightEditField_5.Value;
h.stage3.PenFuncWeight = app.PenFuncWeightEditField_6.Value;

load(['SavedResults/','gui_curr']);
% delete(['SavedResults/',gui_curr.opt_name]);
gui_curr.opt_name = app.OptimizationFileEditField.Value;
eval([gui_curr.opt_name(1:end-4),'=h;']);
save(['SavedResults/',gui_curr.opt_name],gui_curr.opt_name(1:end-4));
