function KEDplotter(KEF_init,KEF_opt)


max_init=max(KEF_init');
max_opt=max(KEF_opt');
line([0 7],[85 85])
y=[]
for i=1:6
   y = [y;max_init(i) max_opt(i)] ;
       
end

bar(y)
legend('85 criteria','Initial','Optimized')

end