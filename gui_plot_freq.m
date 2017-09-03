function gui_plot_freq(f_nat_init,f_nat_opt,f_nat_lb,f_nat_ub)
    
    line([1 2 3 4 5 6],f_nat_ub,'color','g','marker','*')
    line([1 2 3 4 5 6],f_nat_lb,'color','g','marker','*')
    line([1 2 3 4 5 6],f_nat_init,'color','r','marker','+')
    line([1 2 3 4 5 6],f_nat_opt,'color','b','marker','+')

    legend('upper bound','lower bound','initial','optimized')
    
    ylim([0 20])
    xlim([0 7])
    
    xticks([1 2 3 4 5 6])
    xticklabels({'first mode','second mode','third mode','fourth mode','fifth mode','sixth mode'})
    xtickangle(45)
end