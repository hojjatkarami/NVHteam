%% In the name of Allah the beneficent the merciful
% This Code is the core of NVE Application
% The code is written by NVE Team on 1396/05/21

%% Clearing
clc

%% run
data = app.data
for i=1:4
stage_name = char(data(i,2));
if isvarname(stage_name)==0
    continue;
    
end
global tb h
h.name = char(data(i,1));


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
for j=2:4
    
    stage_name = char(data(i,j))
    if isvarname(stage_name)==0
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
eval([h.name,'_res=q;']);
save(['SavedResults/',[h.name,'_res.mat']], [h.name,'_res']);
cmd(['results saved in ',h.name,'_res.mat file']);


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