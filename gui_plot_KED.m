function gui_plot_KED(h,name)

ax=figure;    hold on; %stiffness figure
ax.Name = [name,' >> KED (Kinetic Energy Decoupling)'];


xlim([0 7]); ylim([0 110])
xticks([1 2 3 4 5 6])
xticklabels({'Longitudinal','Lateral','Bounce','Roll','Pitch','Yaw'})
xtickangle(45)



y=max(h.stage0.init.result.KED)';
leg="initial";

if strcmp(h.stage1.type,'None')==0
    
   y=[y,max(h.stage1.opt.result.KED)'];
   leg=[leg;string(['Stage 1 >> ',h.stage1.type])];
end
if strcmp(h.stage2.type,'None')==0
    
   y=[y,max(h.stage2.opt.result.KED)']; 
   leg=[leg;string(['Stage 2 >> ',h.stage2.type])];
end
if strcmp(h.stage3.type,'None')==0
    
   y=[y,max(h.stage3.opt.result.KED)']; 
   leg=[leg;string(['Stage 3 >> ',h.stage3.type])];
end
bar(y)
line([0 7],[h.KED.per  h.KED.per],'color','red');
leg=[leg;string([num2str(h.KED.per),' % Criteria'])];
legend(leg)