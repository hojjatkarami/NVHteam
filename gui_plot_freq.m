function gui_plot_freq(h,name)
    ax=figure;    hold on; %stiffness figure
    ax.Name = [name,' >> Natural Frequency'];
    
    % STAGE 0
    x=[1:6]-.1;
    y=h.stage0.init.result.Freq';
    y_ub = h.ub_freq-y;
    y_lb = y-h.lb_freq;
    errorbar(x,y,y_lb,y_ub,'o');
    leg = [string([name,' : initial'])];
    % STAGE 1
    if strcmp(h.stage1.type,'None')==0
        x=[1:6];
        y=h.stage1.opt.result.Freq';
        y_ub = h.ub_freq-y;
        y_lb = y-h.lb_freq;
        errorbar(x,y,y_lb,y_ub,'o');
        leg = [leg;string([name,' : Stage 1 >> ',h.stage1.type])];
    end
    % STAGE 2
    if strcmp(h.stage2.type,'None')==0
        x=[1:6]+.1;
        y=h.stage2.opt.result.Freq';
        y_ub = h.ub_freq-y;
        y_lb = y-h.lb_freq;
        errorbar(x,y,y_lb,y_ub,'o');
        leg = [leg;string([name,' : Stage 2 >> ',h.stage2.type])];
    end
    % STAGE 3
    if strcmp(h.stage3.type,'None')==0
        x=[1:6]+.2;
        y=h.stage3.opt.result.Freq';
        y_ub = h.ub_freq-y;
        y_lb = y-h.lb_freq;
        errorbar(x,y,y_lb,y_ub,'o');
        leg = [leg;string([name,' : Stage 3 >> ',h.stage3.type])];
    end
    ylim([0 30])
    xlim([0 7])
    
    xticks([1 2 3 4 5 6])
    xticklabels({'Longitudinal','Lateral','Bounce','Roll','Pitch','Yaw'})    
    xtickangle(45)
    legend(leg);
end