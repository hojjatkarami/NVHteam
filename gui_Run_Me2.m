%% In the name of Allah the beneficent the merciful
% This Code is the core of NVE Application
% The code is written by NVE Team on 1396/05/21

%% Clearing


%% run
for i=1:app.num_run
clc; close all;
data = app.data;

    stage_name = char(data(i,2));
if isvarname(stage_name)==0
    continue;
    
end
global tb 
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

g = eval(gui_curr.input_name); %handle to input file
N =0;
%% Result Options

Result_Parameters.TimeStep = 0.005;
Result_Parameters.FinalTime = .1;
Result_Parameters.InitialState = zeros(12,1);
Result_Parameters.Eng = g.eng;
Result_Parameters.Mass = g.eng.M;
for j=1:4
    
    stage_name = char(data(i,j+1));
    if isvarname(stage_name)==0
        break;
    end
        
        N=N+1;
        load(['SavedResults/stg_',stage_name]);    
        h_stage = eval(stage_name);   %handle to stage file
        h = read_mat2(h,g,h_stage,j);
        h = run(h,j);
        h.stage(j).results = Result_Calc(h.stage(j), Result_Parameters);

end
h.stage0.results = Result_Calc(h.stage0,Result_Parameters);
h.N = N;
q=save_mat(h);
eval([h.name,'_res=q;']);
save(['SavedResults/',[h.name,'_res.mat']], [h.name,'_res']);
cmd(['results saved in ',h.name,'_res.mat file']);
clear 'h'
end
% End of Code