
figure(1);

load(['SavedResults/','gui_curr.mat']);
load(['SavedResults/',gui_curr.input_name]);            
h = eval(gui_curr.input_name(1:end-4));

h_body = stlread('car_body2.stl');
% h_mount = stlread();
patch(h_body,'FaceColor',       [0.8 0.8 1.0], ...
'EdgeColor',       'none',         ...
'FaceLighting',    'gouraud',     ...
'AmbientStrength', 0.15,'FaceAlpha',0.3,'EdgeAlpha',0.3);
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
X=400; Y=800; Z=400;
cm_eng=h.sus.E_cm

line([0 100], [0 0], [0 0 ],'color','blue');
line([0 0], [0 100], [0 0 ],'color','blue');
line([0 0], [0 0], [0 100 ],'color','blue');
text([110 0 0],[0 110 0],[0 0 110],['+X';'+Y';'+Z'],'FontSize',5);

line([cm_eng(1),cm_eng(1)+100], [cm_eng(2),cm_eng(2)], [cm_eng(3),cm_eng(3)],'color','blue');
line([cm_eng(1),cm_eng(1)], [cm_eng(2),cm_eng(2)+100], [cm_eng(3),cm_eng(3)],'color','blue');
line([cm_eng(1),cm_eng(1)], [cm_eng(2),cm_eng(2)], [cm_eng(3),cm_eng(3)+100],'color','blue');
text([cm_eng(1)+110 cm_eng(1) cm_eng(1)],[cm_eng(2) cm_eng(2)+110 cm_eng(2)],[cm_eng(3) cm_eng(3) cm_eng(3)+110],['+X';'+Y';'+Z'],'FontSize',5);

color = 'red';
cube = [ver(:,1)*X+cm_eng(1)-X/2,ver(:,2)*Y+cm_eng(2)-Y/2,ver(:,3)*Z+cm_eng(3)-Z/2];
patch('Faces',fac,'Vertices',cube,'FaceColor',color,'FaceAlpha',0.5);

% ------------------------------Code Ends Here-------------------------------- %
