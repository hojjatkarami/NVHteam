function gui_Run_Me2(input_name, opt_matrix) 
%% In the name of Allah the beneficent the merciful
% This Code is the core of NVE Application
% The code is written by NVE Team on 1396/05/21

%% Clearing

clc; close all;
textbox_init();
run_count = size(opt_matrix,1);

%% initialization
  
load(['SavedResults/',input_name,'.mat']);
cmd('input file loaded');

eval(['h_input = ',input_name]); %handle to input file
h.stage0 = read_input(h_input);


%% run
for i=1:run_count

    h.run_name = char(opt_matrix(i,1));
    stage_name = char(opt_matrix(i,2));
if isvarname(stage_name)==0
    continue;
end

N =0; % number of stages at each run


x_opt_previous = h.stage0.x_opt;
lb_p = h.stage0.lb;
ub_p = h.stage0.ub;
for j=1:4
    
    stage_name = char(opt_matrix(i,j+1));
    if isvarname(stage_name)==0     %if stage name is a number then it is empty
        break;
    end
        
          
        load(['SavedResults/stg_',stage_name]);    
        h_stage = eval(stage_name);   %handle to stage file
        
        
        a=h.stage0;        
        
        h.stage(j) = read_stage(x_opt_previous,h_stage,a.t1,a.t2,a.T,lb_p,ub_p);
        h.stage(j).stage_name = stage_name;
        
        
        h.stage(j).x_opt = run2(h.stage(j),h.stage0,j);
        N=N+1;
        
        h.stage(j).results = Result_Calc2(h.stage(j).x_opt,h.stage0.eng,h.stage0.sus, h.stage(j).obj);
        
        x_opt_previous = h.stage(j).x_opt;
        lb_p = h.stage(j).lb;
        ub_p = h.stage(j).ub;
end

h.stage0.results = Result_Calc2(h.stage0.x_opt,h.stage0.eng,h.stage0.sus, h.stage(1).obj);


h.N = N;
save('xp')
h_saved=save_mat2(h,h_input);
eval([h.run_name,'_res=h_saved;']);
save(['SavedResults/',[h.run_name,'_res.mat']], [h.run_name,'_res']);
cmd(['results saved in ',h.run_name,'_res.mat file']);
clear 'h' 'q'
end
% End of Code