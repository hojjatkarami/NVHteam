function gui_Run_Me2(input_FileName,input_PathName, opt_matrix,file_name,desc,folder_name) 
%% In the name of Allah the beneficent the merciful
% This Code is the core of NVE Application
% The code is written by NVE Team on 1396/05/21

%% Clearing

clc; close all;
textbox_init();
run_count = size(opt_matrix,1);
h_file.file_name = file_name;

h_file.run_count = run_count;

%% initialization
  
load([input_PathName,input_FileName]);
cmd('input file loaded');

eval(['h_input = ',input_FileName(1:end-4),';']); %handle to input file
h.stage0 = read_input(h_input);
h_file.description = desc;


%% run
for i=1:run_count
    h.stage0 = read_input(h_input);
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
%         a=j
%         fsa = h.stage(j).x_opt(19)
        h.stage(j).results = Result_Calc2(h.stage(j).x_opt,h.stage0.eng,h.stage0.sus, h.stage(j).obj);
%         fsa = h.stage(1).x_opt(19)
        x_opt_previous = h.stage(j).x_opt;
        lb_p = h.stage(j).lb;
        ub_p = h.stage(j).ub;
%         fsa = h.stage(1).x_opt(19)
end

h.stage0.results = Result_Calc2(h.stage0.x_opt,h.stage0.eng,h.stage0.sus, h.stage(1).obj);
h.N = N;
% fsa = h.stage(1).x_opt(19)
        
h_file.run(i) = save_mat2(h,h_input); 


% h_saved=save_mat2(h,h_input);


clear 'h' 'q'
end
c=[file_name,'_res'];
eval([c ,'=h_file;']);
% [folder_name,[h_file.file_name,'_res.mat']];
save([folder_name,'\',[h_file.file_name,'_res.mat']], c );
cmd(['results saved in : ',[folder_name,[h_file.file_name,'_res.mat']]]);
% End of Code