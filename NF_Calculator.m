function f_nat = NF_Calculator(x,M)

[K,~] = stiff_cal(x,1);
KEF = KEF_cal(K(1:6,1:6),M);

[~,v] = eig(M\K(1:6,1:6));
FREQ = sqrt(v)/2/pi;

best_index = zeros(6,1);
freq = zeros(6,2);
for j = 1:6
    [~,best_index(j)] = max(KEF(:,j));
    freq(j,:) = [best_index(j),FREQ(j,j)];
end

freq = sortrows(freq);
f_nat = freq(:,2);
end