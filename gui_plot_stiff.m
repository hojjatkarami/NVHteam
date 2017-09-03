function gui_plot_stiff(h)
init = h.mount;
ub = h.ub(19:27);
lb = h.lb(19:27);
k_x_1=init.k_l_1(1);     k_y_1=init.k_l_1(2);    k_z_1=init.k_l_1(3);
k_x_2=init.k_l_2(1);     k_y_2=init.k_l_2(2);    k_z_2=init.k_l_2(3);
k_x_3=init.k_l_3(1);     k_y_3=init.k_l_3(2);    k_z_3=init.k_l_3(3);
    title('stiffness')
    subplot(1,3,1)
    line([1 2 3],ub(1:3),'color','b','marker','*')
    line([1 2 3],lb(1:3),'color','b','marker','*')
    line([1 2 3],[k_x_1 , k_y_1 , k_z_1],'color','r','marker','+')
    
    title('mount 1')
    xticklabels({'k_x' , 'k_y' , 'k_z'})
    
    subplot(1,3,2)
    line([1 2 3],ub(4:6),'color','b','marker','*')
    line([1 2 3],lb(4:6),'color','b','marker','*')
    line([1 2 3],[k_x_2 , k_y_2 , k_z_2],'color','r','marker','+')
    title('mount 2')
    xticklabels({'k_x' , 'k_y' , 'k_z'})
    
    subplot(1,3,3)
    line([1 2 3],ub(7:9),'color','b','marker','*')
    line([1 2 3],lb(7:9),'color','b','marker','*')
    line([1 2 3],[k_x_3 , k_y_3 , k_z_3],'color','r','marker','+')
    title('mount 3')
    xticklabels({'k_x' , 'k_y' , 'k_z'})
    
    
    



end