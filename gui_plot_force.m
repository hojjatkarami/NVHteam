function gui_plot_force(h,name)
    width=.05;
    color = {'blue','green','yellow','black'};
    ax=figure;    hold on; %stiffness figure
    ax.Name = [name,' >> Mount Forces'];
    
    % STAGE 0
    x=[1:9]-.1;
    y_rms=rms(h.stage0.results.F,1);
    
    y_max=max(h.stage0.results.F);
    leg = "initial";
    subplot(2,1,1)
    hold on
    bar(x,y_rms,width,'red')
    subplot(2,1,2)
    hold on
    bar(x,y_max,width,'red')
     
    for i=1:h.N
        x=[1:9] + .1*(i-1);
        y_rms=rms(h.stage(i).results.F,1);
        y_max=max(h.stage(i).results.F);
        leg = [leg;string(['Stage ',num2str(i),' >> ',h.stage(i).stage_name])];
        subplot(2,1,1)
        bar(x,y_rms,width,char(color(i)))
        subplot(2,1,2)
        bar(x,y_max,width,char(color(i)))
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
    %%
    ax2=figure;    hold on; %new figure
    ax2.Name = [name,' >> Transient Mount Forces'];
    
    F = h.stage(h.N).results.F;
    t = 0:h.stage(h.N).results.TimeStep:h.stage(h.N).results.FinalTime;
    for i=1:9
    subplot(3,3,i)
        plot(t,F(:,i))
    end
        %     subplot(3,3,2)
%         plot(t,F(:,2))
%     subplot(3,3,3)
%         plot(t,F(:,3))
% %     subplot(3,1,1)
% %         plot(t,F(:,1))
    
end
