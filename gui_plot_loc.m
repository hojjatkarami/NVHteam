function gui_plot_loc(h,color)
% source : http://jialunliu.com/how-to-use-matlab-to-plot-3d-cubes/
    figure(1)
    h.sus.E_cm
    mount_pos=[h.sus.E_cm;h.sus.E_cm;h.sus.E_cm]+[h.mount.r_1; h.mount.r_2; h.mount.r_3];
    mount_plane=[1 2 3];
    patch('Faces',mount_plane,'Vertices',mount_pos,'FaceColor',color);
%     text(pos(1,1),pos(2,1),pos(3,1),'m1','Color',color,'FontSize',8)
%     text(pos(1,2),pos(2,2),pos(3,2),'m2','Color',color,'FontSize',8)
%     text(pos(1,3),pos(2,3),pos(3,3),'m3','Color',color,'FontSize',8)
    
% legend(name)

end