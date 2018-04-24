function C = CC_CDF(CI)

A = CI.CI;
uptri = triu(A,1);
A(isnan(A))=0;
A = A+uptri'+eye(length(A));

B = [];
for i=1:length(A)
    B = [B,A(i,i:length(A))];
end

C = zeros(1,101);
for i = 1:100
    C(i+1)  = sum(B<=(i/100))/length(B);
end
