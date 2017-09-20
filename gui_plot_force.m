function gui_plot_force(h,name)
    width=.05;
    ax=figure;    hold on; %stiffness figure
    ax.Name = [name,' >> Mount Forces'];
    
    % STAGE 0
    x=[1:9]-.1;
    y_rms=rms(h.stage0.results.F,1);
    
    y_max=max(h.stage0.results.F);
    leg = "initial";
    subplot(2,1,1)
    hold on
    bar(x,y_rms,width)
    subplot(2,1,2)
    hold on
    bar(x,y_max,width)
     
    for i=1:h.N
        color = rand(1,3);
        x=[1:9] + .1*(i-1);
        y_rms=rms(h.stage(i).results.F,1);
        y_max=max(h.stage(i).results.F);
        leg = [leg;string(['Stage ',num2str(i),' >> ',h.stage(i).type])];
        subplot(2,1,1)
        bar(x,y_rms,width,'FaceColor',color)
        subplot(2,1,2)
        bar(x,y_max,width,'FaceColor',color)
    end


    

    subplot(2,1,1)
    xlim([0 10]); %ylim([0 200])
    xticks([1 2 3 4 5 6 7 8 9])
    xticklabels({'m1 : F_x','m1 : F_y','m1 : F_z','m2 : F_x','m2 : F_y','m2 : F_z','m3 : F_x','m3 : F_y','m3 : F_z',})
    xtickangle(45)
    ylabel('RMS Force (N)')
    legend(leg);
    subplot(2,1,2)
    xlim([0 10]); %ylim([0 200])
    xticks([1 2 3 4 5 6 7 8 9])
    xticklabels({'m1 : F_x','m1 : F_y','m1 : F_z','m2 : F_x','m2 : F_y','m2 : F_z','m3 : F_x','m3 : F_y','m3 : F_z',})
    xtickangle(45)
    ylabel('MAX Force (N)')
    legend(leg);

end
