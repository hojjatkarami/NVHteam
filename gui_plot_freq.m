function gui_plot_freq(h,name)
    ax=figure;    hold on; %stiffness figure
    ax.Name = [name,' >> Natural Frequency'];
    
    % STAGE 0
    x=[1:6]-.1;
    y=h.stage0.results.Freq;
    y_ub = h.stage(1).ub_freq
    plot(x,y,'o')
    
    ss=h.stage(1).ub_freq
    y_lb = h.stage(1).lb_freq;
    y=(y_lb+y_ub)/2;
    errorbar(x,y,y-y_lb,y_ub-y,'.');
    
    leg = "initial";
    
    for i=1:h.N
        x=[1:6]+.1*(i-1);
        y=h.stage(i).results.Freq;
        plot(x,y,'o');
        
        y_ub = h.stage(i).ub_freq;
        sss=h.stage(i).ub_freq
        y_lb = h.stage(i).lb_freq;
        y2=(y_lb+y_ub)/2;
        errorbar(x,y2,y2-y_lb,y_ub-y2,'.');
        leg = [leg;string(['Stage ',num2str(i),' >> ',h.stage(i).type])];
    end
    
    ylim([0 30])
    xlim([0 7])
    
    xticks([1 2 3 4 5 6])
    xticklabels({'Longitudinal','Lateral','Bounce','Roll','Pitch','Yaw'})    
    xtickangle(45)
    legend(leg);
end