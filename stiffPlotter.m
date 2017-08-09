function stiffPlotter(ub,lb,x_opt1_f)
   
k_x_1=x_opt1_f(19);     k_y_1=x_opt1_f(20);     k_z_1=x_opt1_f(21);
k_x_2=x_opt1_f(22);     k_y_2=x_opt1_f(23);     k_z_2=x_opt1_f(24);
k_x_3=x_opt1_f(25);     k_y_3=x_opt1_f(26);     k_z_3=x_opt1_f(27);
    title('stiffness')
    subplot(1,3,1)
    
    line([1 2 3],ub(1,:),'color','b','marker','*')
    line([1 2 3],lb(1,:),'color','b','marker','*')
    line([1 2 3],[x_opt1_f(19) , x_opt1_f(20) , x_opt1_f(21)],'color','r','marker','+')
    
    title('mount 1')
    xticklabels({'k_x' , 'k_y' , 'k_z'})
    
    subplot(1,3,2)
    line([1 2 3],ub(2,:),'color','b','marker','*')
    line([1 2 3],lb(2,:),'color','b','marker','*')
    line([1 2 3],[x_opt1_f(22) , x_opt1_f(23) , x_opt1_f(24)],'color','r','marker','+')
    title('mount 2')
    xticklabels({'k_x' , 'k_y' , 'k_z'})
    
    subplot(1,3,3)
    line([1 2 3],ub(3,:),'color','b','marker','*')
    line([1 2 3],lb(3,:),'color','b','marker','*')
    line([1 2 3],[x_opt1_f(25) , x_opt1_f(26) , x_opt1_f(27)],'color','r','marker','+')
    title('mount 3')
    xticklabels({'k_x' , 'k_y' , 'k_z'})
    
    
    



end