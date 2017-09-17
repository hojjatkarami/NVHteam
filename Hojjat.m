%% In the name of Allah the beneficent the merciful
% This Code is the core of NVE Application
% The code is written by NVE Team on 1396/05/21

%% Clearing
clc; clear; close all

global tb

fig_cmd = figure(10);   %this is status figure
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

g = read_mat(f,h);

%% Result Options

Result_Parameters.TimeStep = 0.005;
Result_Parameters.FinalTime = .1;
Result_Parameters.InitialState = zeros(12,1);
Result_Parameters.Eng = g.eng;
Result_Parameters.Mass = g.eng.M;

%% STAGE 0 (initial state)

g.stage0.init.result = Result_Calc(g.stage0.init.x,g.stage0.T, Result_Parameters);

g.stage0.opt.x = g.stage0.init.x;
g.stage0.opt.result = g.stage0.init.result;

%% HIGHER ORDER STAGES
for i = 1:3
    str = num2str(i);
    cmd(['stage ' str ' initiated ...']); 
    switch eval(['g.stage',str,'.type'])

        case 'TRA'
            StageValue = TRA(g,g.stage0,g.stage1,Result_Parameters);
        case 'TF'
            StageValue = TF(g,g.stage0,g.stage1,Result_Parameters);
        case 'TA'
            StageValue = TA(g,g.stage0,g.stage1,Result_Parameters);
        case 'Ar'
            StageValue = Ar(g,g.stage0,g.stage1,Result_Parameters);
    end
    eval(['g.stage',str,'.type','=StageValue;']);
    cmd(['stage ',str,' finished ...']);
end

%% Saving results ... %%
q=save_mat(g);
eval([gui_curr.res_name(1:end-4),'=q;']);
save(['SavedResults/',gui_curr.res_name], gui_curr.res_name(1:end-4));
cmd('results saved in .mat file');

diary('log.txt');
cmd('log file created');

% End of Code