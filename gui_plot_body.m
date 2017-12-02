
figure(11);

% load(['SavedResults/','gui_curr.mat']);
% load(['SavedResults/',gui_curr.input_name]);            
% h = eval(gui_curr.input_name(1:end-4));

h_body = stlread('car_body2.stl');

% h_mount = stlread();
patch(h_body,'FaceColor',       [0.8 0.8 1.0], ...
'EdgeColor',       'none',         ...
'FaceLighting',    'gouraud',     ...
'AmbientStrength', 0.15,'FaceAlpha',0.3,'EdgeAlpha',0.3,'DisplayName','Car Body');
camlight('headlight');
material('dull');
axis('image');
view([5000 5000 5000]);
xlim([-3000 3000])
ylim([-1500 1500])
zlim([-1000 1000])

% ------------------------------Code Starts Here------------------------------ %
% Define the vertexes of the unit cubic
ver = [1 1 0;
    0 1 0;
    0 1 1;
    1 1 1;
    0 0 1;
    1 0 1;
    1 0 0;
    0 0 0];
%  Define the faces of the unit cubic
fac = [1 2 3 4;
    4 3 5 6;
    6 7 8 5;
    1 2 8 7;
    6 7 1 4;
    2 3 5 8];
lb = [h.mount.lb_r_1; h.mount.lb_r_2;h.mount.lb_r_3;...
               ];
ub = [h.mount.ub_r_1; h.mount.ub_r_2; h.mount.ub_r_3;...
               ]
X=max(abs([ub(1),ub(4),ub(7),lb(1),lb(4),lb(7)]));
Y=max(abs([ub(2),ub(5),ub(8),lb(2),lb(5),lb(8)]));
Z=max(abs([ub(3),ub(6),ub(9),lb(3),lb(6),lb(9)]));
X=400;Y=600;Z=300;
cm_eng=rotz(180) * h.sus.E_cm';

line([0 -100], [0 0], [0 0 ],'color','blue', 'HandleVisibility','off');
line([0 0], [0 -100], [0 0 ],'color','blue', 'HandleVisibility','off');
line([0 0], [0 0], [0 100 ],'color','blue', 'HandleVisibility','off');
text([-110 0 0],[0 -110 0],[0 0 110],['+X';'+Y';'+Z'],'FontSize',5);

line([cm_eng(1),cm_eng(1)-100], [cm_eng(2),cm_eng(2)], [cm_eng(3),cm_eng(3)],'color','blue', 'HandleVisibility','off');
line([cm_eng(1),cm_eng(1)], [cm_eng(2),cm_eng(2)+100], [cm_eng(3),cm_eng(3)],'color','blue', 'HandleVisibility','off');
line([cm_eng(1),cm_eng(1)], [cm_eng(2),cm_eng(2)], [cm_eng(3),cm_eng(3)+100],'color','blue', 'HandleVisibility','off');
text([cm_eng(1)-110 cm_eng(1) cm_eng(1)],[cm_eng(2) cm_eng(2)+110 cm_eng(2)],[cm_eng(3) cm_eng(3) cm_eng(3)+110],['+X';'+Y';'+Z'],'FontSize',5);

color = 'red';
cube = [ver(:,1)*X+cm_eng(1)-X/2,ver(:,2)*Y+cm_eng(2)-Y/2,ver(:,3)*Z+cm_eng(3)-Z/2];
handle = patch('Faces',fac,'Vertices',cube,'FaceColor',color,'FaceAlpha',0.5,'DisplayName','Engine');
% legend(handle,'Car Body')
% ------------------------------Code Ends Here-------------------------------- %
