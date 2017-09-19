%% In the name of Allah the beneficent the merciful
% This Code is the core of NVE Application
% The code is written by NVE Team on 1396/05/21

%% Clearing
clc

%% run
data = app.data;
for i=1:4
stage_name = char(data(i,i));
if strcmp(stage_name,'none')==1
    continue;
    
end

global tb h

fig_cmd = figure(10);   %this is status figure
set(fig_cmd,'Name','cmd','Units','normalized','Position',[.75 .1 .25 .8]);

tb = uicontrol('style','text');
set(tb,'Units','normalized','Position',[.05 .05 .9 .9],'String','starting...',...
        'HorizontalAlignment','left','FontSize',10);


%% Parameters %%
load(['SavedResults/','gui_curr.mat']);
load(['SavedResults/',gui_curr.input_name]);
cmd('input file loaded');

g = eval(gui_curr.input_name(1:end-4)); %handle to input file
N =0;
%% Result Options

Result_Parameters.TimeStep = 0.005;
Result_Parameters.FinalTime = .1;
Result_Parameters.InitialState = zeros(12,1);
Result_Parameters.Eng = g.eng;
Result_Parameters.Mass = g.eng.M;
for j=1:4
    
    stage_name = char(data(j,i))
    if strcmp(stage_name,'none')==1
        break;
    end
        
        N=N+1;
        load(['SavedResults/stg_',stage_name]);    
        f = eval(stage_name);   %handle to stage file
        read_mat2
        run
    

end
h.stage0.results = Result_Calc(h.stage0.x_init,Result_Parameters);
h.N = N;
q=save_mat(h);
eval([gui_curr.res_name(1:end-4),'=q;']);
save(['SavedResults/',gui_curr.res_name], gui_curr.res_name(1:end-4));
cmd('results saved in .mat file');


%% STAGE 0 (initial state)
% 
% g.stage0.init.result = Result_Calc(g.stage0.init.x,g.stage0.T, Result_Parameters);
% 
% g.stage0.opt.x = g.stage0.init.x;
% g.stage0.opt.result = g.stage0.init.result;

%% Saving results ... %%

% 
% diary('log.txt');
% cmd('log file created');
end
% End of Code