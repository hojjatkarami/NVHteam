function TRA2(h,j)
%% TRA Optimization %%
cmd('********* TRA *********');
cmd('TRA parameters are being set...');



[x_opt_TRA, Fval_TRA] = TRA_Optimizer(h.stage(j).option,n,T,F,x_init,T1,lb,ub);


cmd('calculating results ...');
option=h.stage(j).option;


% stage1.init.result = stage0.opt.result;


 
cmd('results saved');



