function gui_plot_loc(h,name)



    figure(11)
    eng_com = [h.sus.E_cm;h.sus.E_cm;h.sus.E_cm] .* [-1,1,1;-1,1,1;-1,1,1]
    
    mount_plane=[1 2 3];
    pos = [h.stage0.x_opt(1:3)';    h.stage0.x_opt(4:6)';   h.stage0.x_opt(7:9)'] * 1000;
        mount_pos = eng_com + pos .* [-1,1,1;-1,1,1;-1,1,1];
        patch('Faces',mount_plane,'Vertices',mount_pos,'FaceColor',rand(1,3),'DisplayName',[name,' : initial ']);

    for i=1:h.N
        pos = [h.stage(i).x_opt(1:3)';    h.stage(i).x_opt(4:6)';   h.stage(i).x_opt(7:9)'] * 1000;
        mount_pos = eng_com + pos .* [-1,1,1;-1,1,1;-1,1,1];
        patch('Faces',mount_plane,'Vertices',mount_pos,'FaceColor',rand(1,3),'DisplayName',[name,' : STAGE ',num2str(i),' > ',h.stage(i).type]);
%         leg = [leg;string([name,' : STAGE ',num2str(i),' > ',h.stage(i).type])];
%         legend(handle,string([name,' : STAGE ',num2str(i),' > ',h.stage(i).type]));
        
        
    end
%     % STAGE 0
%     pos = [h.stage0.init.x(1:3)';    h.stage0.init.x(4:6)';   h.stage0.init.x(7:9)'] * 1000;
%     mount_pos = eng_com + pos;
%     patch('Faces',mount_plane,'Vertices',mount_pos,'FaceColor',rand(1,3));
%     leg = [leg;string([name,' : initial'])];
%     % STAGE 1
%     if strcmp(h.stage1.type,'None') == 0
%     pos = [h.stage1.opt.x(1:3)';    h.stage1.opt.x(4:6)';   h.stage1.opt.x(7:9)'] * 1000;
%     mount_pos = eng_com + pos;
%     patch('Faces',mount_plane,'Vertices',mount_pos,'FaceColor',rand(1,3));
%     leg = [leg;string([name,' : STAGE 1 > ',h.stage1.type])];
%     end
%     
%     % STAGE 2
%     if strcmp(h.stage2.type,'None') == 0
%     pos = [h.stage2.opt.x(1:3)';    h.stage2.opt.x(4:6)';   h.stage2.opt.x(7:9)'] * 1000;
%     mount_pos = eng_com + pos;
%     patch('Faces',mount_plane,'Vertices',mount_pos,'FaceColor',rand(1,3));
%     leg = [leg;string([name,' : STAGE 2 > ',h.stage2.type])];
%     end
%     
%     % STAGE 3
%     if strcmp(h.stage3.type,'None') == 0
%     pos = [h.stage3.opt.x(1:3)';    h.stage3.opt.x(4:6)';   h.stage3.opt.x(7:9)'] * 1000;
%     mount_pos = eng_com + pos;
%     patch('Faces',mount_plane,'Vertices',mount_pos,'FaceColor',rand(1,3));
%     leg = [leg;string([name,' : STAGE 3 > ',h.stage3.type'])];
%     end
end