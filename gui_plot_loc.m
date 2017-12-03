function gui_plot_loc(h,name)



    figure(11)
    xlabel('x')
    ylabel('y')
    zlabel('z')
    
   
    mount_plane=[1 2 3];
    
        
        pos_mount1 = rotz(180) * rotz(str2num(h.sus.rotz)) * (h.sus.trans' + h.sus.E_cm' + h.stage0.x_opt(1:3)*1e3 );
        pos_mount2 = rotz(180) * rotz(str2num(h.sus.rotz)) * (h.sus.trans' + h.sus.E_cm' + h.stage0.x_opt(4:6)*1e3 );
        pos_mount3 = rotz(180) * rotz(str2num(h.sus.rotz)) * (h.sus.trans' + h.sus.E_cm' + h.stage0.x_opt(7:9)*1e3 );
        mount_pos_init = [pos_mount1'; pos_mount2';pos_mount3'];
        patch('Faces',mount_plane,'Vertices',mount_pos_init,'FaceColor',rand(1,3),'DisplayName',[name,' : initial ']);

    for i=1:h.N
%         pos = [h.stage(i).x_opt(1:3)';    h.stage(i).x_opt(4:6)';   h.stage(i).x_opt(7:9)'] * 1000;
        pos_mount1 = rotz(180) * rotz(str2num(h.sus.rotz)) * (h.sus.trans' + h.sus.E_cm' + h.stage(i).x_opt(1:3)*1e3 );
        pos_mount2 = rotz(180) * rotz(str2num(h.sus.rotz)) * (h.sus.trans' + h.sus.E_cm' + h.stage(i).x_opt(4:6)*1e3 );
        pos_mount3 = rotz(180) * rotz(str2num(h.sus.rotz)) * (h.sus.trans' + h.sus.E_cm' + h.stage(i).x_opt(7:9)*1e3 );
        mount_pos_opt = [pos_mount1'; pos_mount2';pos_mount3'];
        patch('Faces',mount_plane,'Vertices',mount_pos_opt,'FaceColor',rand(1,3),'DisplayName',[name,' : STAGE ',num2str(i),' > ',h.stage(i).stage_name]);
%         leg = [leg;string([name,' : STAGE ',num2str(i),' > ',h.stage(i).type])];
%         legend(handle,string([name,' : STAGE ',num2str(i),' > ',h.stage(i).type]));
        
        
    end
    mount_pos_opt - mount_pos_init
end