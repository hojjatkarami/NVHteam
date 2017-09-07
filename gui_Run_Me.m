%% In the name of Allah the beneficent the merciful
% This Code is the core of NVE Application
% The code is written by NVE Team on 1396/05/21

%% Clearing
clc; clear; close all

global tb

fig_cmd = figure(10);
set(fig_cmd,'Name','cmd','Units','normalized','Position',[.75 .1 .25 .8]);

tb = uicontrol('style','text');
set(tb,'Units','normalized','Position',[.05 .05 .9 .9],'String','starting...',...
        'HorizontalAlignment','left','FontSize',10);


%% Parameters %%
load(['SavedResults/','gui_curr.mat']);
load(['SavedResults/',gui_curr.input_name]);
cmd('input file loaded');
load(['SavedResults/',gui_curr.opt_name]);
cmd('optimization file loaded');

h = eval(gui_curr.input_name(1:end-4)); %handle to input file
f = eval(gui_curr.opt_name(1:end-4));   %handle to optimization file

g = read_mat(f);

%% Result Options

Result_Parameters.TimeStep = 0.005;
Result_Parameters.FinalTime = .1;
Result_Parameters.InitialState = zeros(12,1);
Result_Parameters.Eng = g.eng;
Result_Parameters.Mass = g.eng.M;

%% STAGE 0 (initial state)

g.stage0.init.result = Result_Calc(g.stage0.init.x, Result_Parameters);

g.stage0.opt.x = g.stage0.init.x;
g.stage0.opt.result = g.stage0.init.result;

%% STAGE 1
cmd('stage 1 initiated ...');

switch g.stage1.type
    
    case 'TRA'
        g.stage1 = TRA(g,g.stage0,g.stage1,Result_Parameters);
    case 'TF'
        g.stage1 = TF(g,g.stage0,g.stage1,Result_Parameters);
    case 'TA'
        TA(g.stage1)
    case 'Ar'
        Ar(g.stage1)
     
end
cmd('stage 1 finished ...');
%% STAGE 2
cmd('stage 2 initiated ...');
switch g.stage2.type
    
    case 'TRA'
        g.stage2 = TRA(g,g.stage1,g.stage2,Result_Parameters);
    case 'TF'
        g.stage2 = TF(g,g.stage1,g.stage2,Result_Parameters);
    case 'TA'
        TA(g.stage2)
    case 'Ar'
        Ar(g.stage2)
     
end
cmd('stage 2 finished ...');
%% STAGE 3
cmd('stage 3 initiated ...');
switch g.stage3.type
    
    case 'TRA'
        g.stage3 = TRA(g,g.stage2,g.stage3,Result_Parameters);
    case 'TF'
        g.stage3 = TF(g,g.stage2,g.stage3,Result_Parameters);
    case 'TA'
        TA(g.stage3)
    case 'Ar'
        Ar(g.stage3)
     
end
cmd('stage 3 finished ...');
%% Saving results ... %%

q=save_mat(g);
eval([gui_curr.res_name(1:end-4),'=q;']);
save(['SavedResults/',gui_curr.res_name], gui_curr.res_name(1:end-4));
cmd('results saved in .mat file');

diary('log.txt');
cmd('log file created');


% End of Code