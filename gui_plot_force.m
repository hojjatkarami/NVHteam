function gui_plot_force(h,name)

    ax=figure;    hold on; %stiffness figure
    ax.Name = [name,' >> Mount Forces'];
    
    % STAGE 0
    x=[1:9]-.1;
    y_rms=rms(h.stage0.init.result.F,1);
    
    y_max=max(h.stage0.init.result.F);
    leg = "initial";
    subplot(2,1,1)
    hold on
    scatter(x,y_rms,'*')
    subplot(2,1,2)
    hold on
    scatter(x,y_max,'o')
    %STAGE 1 
    if strcmp(h.stage1.type,'None')==0
        
        x=[1:9];
        y_rms=rms(h.stage1.opt.result.F,1);
        y_max=max(h.stage1.opt.result.F);
        leg = [leg;string(['Stage 1 >> ',h.stage1.type])];
        subplot(2,1,1)
        scatter(x,y_rms,'*')
        subplot(2,1,2)
        scatter(x,y_max,'o')
    end

%STAGE 2 
    if strcmp(h.stage2.type,'None')==0
        
        x=[1:9]+.1;
        y_rms=rms(h.stage2.opt.result.F,1);
        y_max=max(h.stage2.opt.result.F);
        leg = [leg;string(['Stage 2 >> ',h.stage2.type])];
        subplot(2,1,1)
        scatter(x,y_rms,'*')
        subplot(2,1,2)
        scatter(x,y_max,'o')
    end

%STAGE 3
    if strcmp(h.stage3.type,'None')==0
        
        x=[1:9]+.2;
        y_rms=rms(h.stage3.opt.result.F,1);
        y_max=max(h.stage3.opt.result.F);
        leg = [leg;string(['Stage 3 >> ',h.stage3.type])];
        subplot(2,1,1)
        scatter(x,y_rms,'*')
        subplot(2,1,2)
        scatter(x,y_max,'o')
    
    end
    

    subplot(2,1,1)
    xlim([0 10]); %ylim([0 200])
    xticks([1 2 3 4 5 6 7 8 9])
    xticklabels({'m1 : F_x','m1 : F_y','m2 : F_z','m2 : F_x','m2 : F_y','m3 : F_z','m3 : F_x','m3 : F_y','m3 : F_z',})
    xtickangle(45)
    ylabel('RMS Force (N)')
    legend(leg);
    subplot(2,1,2)
    xlim([0 10]); %ylim([0 200])
    xticks([1 2 3 4 5 6 7 8 9])
    xticklabels({'m1 : F_x','m1 : F_y','m2 : F_z','m2 : F_x','m2 : F_y','m3 : F_z','m3 : F_x','m3 : F_y','m3 : F_z',})
    xtickangle(45)
    ylabel('MAX Force (N)')
    legend(leg);

end
