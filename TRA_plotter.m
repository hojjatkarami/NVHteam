function TRA_plotter(q_TRA,E_cm)
% source : http://jialunliu.com/how-to-use-matlab-to-plot-3d-cubes/

    line([-600*q_TRA(4)+E_cm(1),600*q_TRA(4)+E_cm(1)],...
        [-600*q_TRA(5)+E_cm(2),600*q_TRA(5)+E_cm(2)],...
        [-600*q_TRA(6)+E_cm(3),600*q_TRA(6)+E_cm(3)],'Color','green')
    text(600*q_TRA(4)+E_cm(1),600*q_TRA(5)+E_cm(2),600*q_TRA(6)+E_cm(3),'TRA','color','k')
    
 
end