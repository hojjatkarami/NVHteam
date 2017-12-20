function h = read_stage(x_opt_previous,stage,t1,t2,T,lb_p,ub_p)
%% read obj structure
h.obj = stage.obj;

h.obj.ST.DeltaStatic = [0.001 0.001 0.001 pi/180 pi/180 pi/180] .* stage.obj.ST.DeltaStatic;


a = stage.ub_purt;
h.ub_purt = [a.loc1, a.loc2, a.loc3,...
                     a.ori1, a.ori2, a.ori3,...
                     a.stiff1, a.stiff2, a.stiff3,...
                     a.damp1, a.damp2, a.damp3,...
                     0,0,0,...
                     100,100]'/100;
a = stage.lb_purt;
h.lb_purt = [a.loc1, a.loc2, a.loc3,...
                     a.ori1, a.ori2, a.ori3,...
                     a.stiff1, a.stiff2, a.stiff3,...
                     a.damp1, a.damp2, a.damp3,...
                     0,0,0,...
                     100,100]'/100;

t_ub = h.ub_purt; %vector corresponding to purturbed values of each variable
t_lb = h.lb_purt; %vector corresponding to purturbed values of each variable

%%
size(t1)
size(t2)
size(t_ub)
F = (((t_ub+t_lb)~=0).*(t1) .* (t2))==0; % vector : 0 for bounded-independent-purturbed variables and 1 for others
t3 = find(F==0); % vector of optimization indices which are bounded-independent-purturbed varibles
                            
n=length(t3);       % number of optimization variables

T1 = zeros(41,n);   %Transformation matrix where T*x(optimizition var)=x(design variables)
% x_main = T (F x_init + T1 x_opt)

for i=1:n
    
       T1(t3(i),i)=1; 
end

h.n = n;
h.t1 = t1;
h.t2 = t2;
h.T = T;
h.T1 = T1;
h.F = F;
% h.x_opt_partial = h.stage0.x_opt(find(F==0));
%%

   
    h.x_init = x_opt_previous;
h.lb = (h.x_init - h.lb_purt .* ( h.x_init - lb_p));
h.ub = (h.x_init + h.ub_purt .* ( ub_p - h.x_init));
%     F_zero = find(F==0);
%     h.lb = lb(F_zero);
%     h.ub = ub(F_zero);
    
%% PSO options
h.pso.swarmsize = stage.swarmsize;
h.pso.FuncTol = stage.FuncTol;
h.pso.MaxIter = stage.MaxIter;
h.pso.MaxFuncEval = stage.MaxFuncEval;
h.repeat = stage.repeat;




end