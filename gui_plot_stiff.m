function gui_plot_stiff(h,name)
    ax=figure;    hold on; %stiffness figure
    ax.Name = [name,' >> Stiffness'];
    x=1:9;
    y=h.stage0.x_init(19:27)'/1000;
    y_ub = h.stage0.ub(19:27)'/1000-y;
    y_lb = y-h.stage0.lb(19:27)'/1000;
    errorbar(x,y,y_lb,y_ub,'o');
    leg = [string([name,' : initial'])];
    for i=1:h.N
    x=[1:9] + 0.1*i;
    y=h.stage(i).x_opt(19:27)'/1000;
    y_ub = h.stage(i).ub(19:27)'/1000-y;
    y_lb = y-h.stage(i).lb(19:27)'/1000;
    errorbar(x,y,y_lb,y_ub,'o');
    leg = [leg;string(['Stage ',num2str(i),'>>', h.stage(i).stage_name])];    
        
    end
    
%     if strcmp(h.stage1.type,'None')==0
%         x=[1:9]+0.1;
% 
%         y=h.stage1.opt.x(19:27)'/1000;
%         y_ub = h.stage1.ub(19:27)'/1000-y;
%         y_lb = y-h.stage1.lb(19:27)'/1000;
%         errorbar(x,y,y_lb,y_ub,'o');
%         leg = [leg;string([name,' : Stage1 >> ',h.stage1.type])]
%     end
%     
%     if strcmp(h.stage2.type,'None')==0
%         x=[1:9]+0.2;
% 
%         y=h.stage2.opt.x(19:27)'/1000;
%         y_ub = h.stage2.ub(19:27)'/1000-y;
%         y_lb = y-h.stage2.lb(19:27)'/1000;
%         errorbar(x,y,y_lb,y_ub,'o');
%         leg = [leg;string([name,' : Stage2 >> ',h.stage2.type])];
%     end
%     
%     if strcmp(h.stage3.type,'None')==0
%         x=[1:9]+0.3;
%         y=h.stage3.opt.x(19:27)'/1000;
%         y_ub = h.stage3.ub(19:27)'/1000-y;
%         y_lb = y-h.stage3.lb(19:27)'/1000;
%         errorbar(x,y,y_lb,y_ub,'o');
%         leg = [leg;string([name,' : Stage3 >> ',h.stage3.type])];
%     end
    ylabel('Stiffness (N/mm)')
    xlim([0 10]);
    ylim([10 max(h.stage0.ub(19:27)/1000 +10)]);
    xticks(1:9);
    xticklabels({'Mount1:k_x' , 'Mount1:k_y' , 'Mount1:k_z',...
                 'Mount2:k_x' , 'Mount2:k_y' , 'Mount2:k_z',...
                 'Mount3:k_x' , 'Mount3:k_y' , 'Mount3:k_z'});
    xtickangle(45);
    legend(leg);


end