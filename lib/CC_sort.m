%draw heatmap
A = CI.CI;
uptri = triu(A,1);
A(isnan(A))=0;
A = A+uptri'+eye(40);
s = cell(1,40);
for i = 1:40
    s{i} = num2str(i);
end

C = 1-A;

% dist(1,:) = C(1,2:40);
% for i = 2:40
%     dist = cat(2,dist,C(i,(i+1):40));
% end

y = zeros(1,780);
j = 1;
for m = 1:39
    for n = (m+1):40
        y(j) = C(m,n);
        j = j + 1;
    end
end


Z = linkage(y,'complete');
[H,T,perm] = dendrogram(Z,0,'labels',s);

for num_cluster = 1:5
    C = cluster(Z,'maxclust',num_cluster,'criterion','distance');
    seq = [1:40];
    CI_mean = zeros(1,num_cluster);
    for k = 1:num_cluster
        temp = seq(C==k);
        lh = length(temp);
        for p = 1:(lh-1)
            for q = (p+1):lh
                CI_mean(k)=CI_mean(k) + A(temp(p),temp(q));
            end
        end
        CI_mean(k) = CI_mean(k)/(lh*(lh-1)/2);
    end
    
    D(1,num_cluster) = mean(CI_mean);
end
B = zeros(40,40);
for j = 1:40
    for k = 1:40
        B(j,k) = A(perm(j),perm(k));
    end
end

image(B*100);
clear dist;
