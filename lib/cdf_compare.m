figure;
hold on;
C = zeros(101,9);
for i = 2:10
    C(:,i-1) = CC_CDF(CI(i))';
end
X = 0:0.01:1;
plot(X,C);
hold off;
A = sum(C)/100;
distr = zeros(9,1);
distr(1) = A(1);
distr(2:9) = (A(2:9)- A(1:8))./A(1:8);
plot(2:10,distr);