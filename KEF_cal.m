function KEF = KEF_cal(K,M)
%%% 960906 Code Modified
% m = M(1,1);
% I = M(4:6,4:6);

[u,~] = eig(M\K);
KEF = zeros(6,6);

for i = 1:6
% KEF(1,i) = u(1,i)^2*m;
% KEF(2,i) = u(2,i)^2*m;
% KEF(3,i) = u(3,i)^2*m;
% KEF(4,i) = (u(4,i)^2*I(1,1) + u(4,i)*u(5,i)*I(1,2) + u(4,i)*u(6,i)*I(1,3));
% KEF(5,i) = (u(5,i)^2*I(2,2) + u(4,i)*u(5,i)*I(1,2) + u(5,i)*u(6,i)*I(2,3));
% KEF(6,i) = (u(6,i)^2*I(3,3) + u(4,i)*u(6,i)*I(1,3) + u(5,i)*u(6,i)*I(2,3));
% KEF(1:3,i) = u(1:3,i).*m*u(1:3,i);
% KEF(4:6,i) = u(4:6,i).*(I*u(4:6,i));

ModEng = u(:,i)'*M*u(:,i);
KEF(:,i) = u(:,i).*M*u(:,i)/ModEng*100;
end