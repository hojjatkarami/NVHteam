function Fval = obj_ST(x,M,K, delta_s, StaticTests, st2dy)
% 960908 Code Readed





mg = M(1,1)*9.81;

% stc_Mat(:,1) = (abs((K(1:6,1:6)/1.5)^(-1))) * mg * [0;0;-1;0;0;0];
% stc_Mat(:,2) = (abs((K(1:6,1:6)/1.5)^(-1))) * mg * [-0.4;0;-1;0;0;0];
% stc_Mat(:,3) = (abs((K(1:6,1:6)/1.5)^(-1))) * mg * [0.8;0;-1;0;0;0];
% stc_Mat(:,4) = (abs((K(1:6,1:6)/1.5)^(-1))) * mg * [0;0.8;-1;0;0;0];
% stc_Mat(:,5) = (abs((K(1:6,1:6)/1.5)^(-1))) * mg * [0;-0.8;-1;0;0;0];
% stc_Mat(:,6) = (abs((K(1:6,1:6)/1.5)^(-1))) * mg * [0;0;2.5;0;0;0];
% 
% stc_Mat(:,7) = (abs((K(1:6,1:6)/1.5)^(-1))) * mg * [0;0;2.5;0;0;0];
% stc_Mat(:,8) = (abs((K(1:6,1:6)/1.5)^(-1))) * mg * [0;0;2.5;0;0;0];
mat = cell2mat(StaticTests(:,2:end));

% size((K/st2dy)^(-1))
stc_Mat = (abs((K(1:6,1:6)/st2dy)^(-1))) * mg * [mat';zeros(3,size(mat,1))];

% stc = max(stc_Mat')';
stc = max(stc_Mat,[],2);


B = stc - delta_s';

Fval = heaviside(B)'*B;



end

