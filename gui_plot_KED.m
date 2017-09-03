function gui_plot_KED(KEF_init,KEF_opt,per)

xlim([0 7]); ylim([0 100])
xticks([1 2 3 4 5 6])
xticklabels({'Longitudinal','Lateral','Bounce','Roll','Pitch','Yaw'})
xtickangle(45)

max_init=max(KEF_init');
max_opt=max(KEF_opt');
line([0 7],[per per],'color','black')
y=[]
for i=1:6
   y = [y;max_init(i) max_opt(i)] ;
       
end

bar(y)
legend([num2str(per),' criteria'],'Initial','Optimized')

end