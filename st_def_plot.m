function st_def_plot(delta_s,stc_opt);

    line([1 2 3 4 5 6],delta_s','color','g','marker','*')
    line([1 2 3 4 5 6],stc_opt,'color','b','marker','+')

    legend('upper bound','optimized')
    
%     ylim([0 20])
    xlim([0 7])
    
    xticks([1 2 3 4 5 6])
%     xticklabels({'first mode','second mode','third mode','fourth mode','fifth mode','sixth mode'})
%     xtickangle(45)


end
