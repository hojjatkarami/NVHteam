function comparison(x_opt,lb,ub,name)
% reza
figure('Name',name)
hold on
% h=gcf;
% h.name=name;
for i=1:9
   line([i i],[lb(18+i) ub(18+i)]) 
    plot(i,x_opt(18+i),'*')
    
end



end