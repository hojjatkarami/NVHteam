%% In the name of Allah the beneficent the merciful
% This Code is the core of NVE Application
% The code is written by NVE Team on 1396/05/21

%% Clearing
clc; clear; close all
global tb
fig_cmd = figure(10);
set(fig_cmd,'Name','Optimization Status','Units','normalized','Position',[.6 .1 .35 .7]);

tb = uicontrol('style','text');
set(tb,'Units','normalized','Position',[.05 .05 .9 .9],'String','starting...',...
        'HorizontalAlignment','left','FontSize',12);

cmd(2)
cmd('hojatKarami')
%% Parameters %%
load(['SavedResults/','gui_curr.mat']);

load(['SavedResults/',gui_curr.input_name]);
cmd('input file loaded');
load(['SavedResults/',gui_curr.opt_name]);
cmd('optimization file loaded');

h = eval(gui_curr.input_name(1:end-4)); %handle to input file
g = eval(gui_curr.opt_name(1:end-4));   %handle to optimization file

BodyProperties
EngineProperties
MountProperties
%% Result Options
Result_Parameters.Eta = etha;
Result_Parameters.TimeStep = 0.005;
Result_Parameters.FinalTime = 5;
Result_Parameters.InitialState = zeros(12,1);
Result_Parameters.Eng = eng;
Result_Parameters.Mass = eng.M;


save('workspace.mat','lb','ub','f_nat_lb','f_nat_ub','Result_Parameters','eng');
%% STAGE 1
cmd('stage 1 initiated ...');
switch g.stage1.type
    
    case 'TRA'
        TRA(g.stage1)
    case 'TF'
        TF(g.stage1)
    case 'TA'
        TA(g.stage1)
    case 'Ar'
        Ar(g.stage1)
     
end
cmd('stage 1 finished ...');
%% STAGE 1
cmd('stage 2 initiated ...');
switch g.stage2.type
    
    case 'TRA'
        TRA(g.stage2)
    case 'TF'
        TF(g.stage2)
    case 'TA'
        TA(g.stage2)
    case 'Ar'
        Ar(g.stage2)
     
end
cmd('stage 2 finished ...');
%% STAGE 1
cmd('stage 3 initiated ...');
switch g.stage3.type
    
    case 'TRA'
        TRA(g.stage3)
    case 'TF'
        TF(g.stage3)
    case 'TA'
        TA(g.stage3)
    case 'Ar'
        Ar(g.stage3)
     
end
cmd('stage 3 finished ...');
%% Initial Response %%
g.Res_Initial = Result_Calc(x_init, Result_Parameters);
g.x_init = x_init;
g.x_opt = x_init;

K_init = stiff_cal(g.x_init,etha);
K_opt = stiff_cal(g.x_opt,etha);
g.KED.init = KEF_cal(K_init,M);
g.KED.opt =  KEF_cal(K_opt,M);

gui_curr.res_name = [gui_curr.opt_name(1:end-7),'res.mat'];
eval([gui_curr.res_name(1:end-4),'=g;']);
save(['SavedResults/',gui_curr.res_name], gui_curr.res_name(1:end-4));
% save(['SavedResults/',gui_curr.res_name]);



diary('log.txt');

% End of Code