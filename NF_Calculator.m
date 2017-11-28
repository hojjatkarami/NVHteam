function f_nat = NF_Calculator(x,M)
%%% 960906 Code Modified
[K,~] = stiff_cal(x,1);
KEF = KEF_cal(K(1:6,1:6),M);

[~,v] = eig(M\K(1:6,1:6));
FREQ = sqrt(v)/2/pi;

freq = zeros(6,2);
for j = 1:6
    [~,best_index] = max(KEF(:,j));
    freq(j,:) = [best_index,FREQ(j,j)];
end

freq = sortrows(freq);
f_nat = freq(:,2);
end