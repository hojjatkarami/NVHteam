function gui_plot_Variation(h,name)

ax=figure;    hold on; %stiffness figure
ax.Name = [name,' >> Variation'];


xlim([0 37]); ylim([-110 110])
xticks(0:37)
xticklabels(0:37)
xtickangle(45)


y = zeros(36,1);
% y=max(h.stage0.results.KED)';
leg="initial";
for i=1:h.N
   
    
    change = (h.stage(i).x_opt(1:36) - h.stage0.x_init(1:36)) ./ h.stage0.x_init(1:36) *100
   y=[y,change];
   
   leg=[leg;string(['Stage ',num2str(i),' >> ',h.stage(i).stage_name])]
end

bar(y)
y
% line([0 7],[h.stage(1).obj.KED.percent  h.stage(1).obj.KED.percent],'color','red');
leg=[leg;string([num2str(h.stage(1).obj.KED.percent),' % Criteria'])];
legend(leg)