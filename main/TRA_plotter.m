function TRA_plotter(q_TRA)
% source : http://jialunliu.com/how-to-use-matlab-to-plot-3d-cubes/

    line([-q_TRA(4),q_TRA(4)],[-q_TRA(5),q_TRA(5)],[-q_TRA(6),q_TRA(6)])
    text(q_TRA(4),q_TRA(5),q_TRA(6),'TRA','color','k')
    
   
    origin=[0 0 0];
    X=.2; Y=.5; Z=.4;
    
    % Define the vertexes of the unit cubic
ver = [1 -1 -1;
       1 1 -1;
       -1 1 -1;
       -1 -1 -1;
       1 -1 1;
       1 1 1;
       -1 1 1;
       -1 -1 1];
%  Define the faces of the unit cubic
fac = [1 2 3 4;
    5 6 7 8;
    2 3 7 6;
    1 4 8 5;
    1 2 6 5;
    4 3 7 8];
cube = [ver(:,1)*X+origin(1),ver(:,2)*Y+origin(2),ver(:,3)*Z+origin(3)];
patch('Faces',fac,'Vertices',cube,'FaceColor','w');
axis equal;
grid on;
xlabel('X axis');
ylabel('Y axis')
zlabel('Z axis')
h = gca;
material metal
alpha (h,0.5); %sets transparency
% alphamap('rampup');
% Set the view point
view(30,30);
hold off;
% readSTL('nut.stl')

end