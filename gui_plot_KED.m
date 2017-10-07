function gui_plot_KED(h,name)

ax=figure;    hold on; %stiffness figure
ax.Name = [name,' >> KED (Kinetic Energy Decoupling)'];


xlim([0 7]); ylim([0 110])
xticks([1 2 3 4 5 6])
xticklabels({'Longitudinal','Lateral','Bounce','Roll','Pitch','Yaw'})
xtickangle(45)



y=max(h.stage0.results.KED)';
leg="initial";
for i=1:h.N
   
   y=[y,max(h.stage(i).results.KED)'];
   leg=[leg;string(['Stage ',num2str(i),' >> ',h.stage(i).type])];
end

bar(y)
y
line([0 7],[h.stage(1).KED  h.stage(1).KED],'color','red');
leg=[leg;string([num2str(h.stage(1).KED),' % Criteria'])];
legend(leg)