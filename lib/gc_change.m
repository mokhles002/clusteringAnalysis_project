cluster = sM.labels;
[a,b] = size(cluster);
for i = 1:a
    for j = 1:b
        cluster{i,j} = str2double(cluster{i,j});
        if isempty(cluster{i,j})
            cluster{i,j}=0; 
        end
    end
end
cluster = cell2mat(cluster);

clear a b;

CI = zeros(30,1);
list = [];

for i = 1:30
    for j = 1:7
        if cluster(i,j)~=0
            list(j) = cluster(i,j);
        else
            break;
        end
    end
    
    len = length(list);
    if len == 0
        CI(i,1) = 0;
        list = [];
    end
    
    if len == 1
        CI(i,1) = 1;
        list = [];
    end
    
    if len>1
        for m = 1:(len-1)
            for n = (m+1):len
                CI(i,1) = CI(i,1) + A(list(m),list(n));
            end
        end
        CI(i,1) = CI(i,1)/(len*(len-1)/2);
        list = [];
    end
end

clear i j m n len list;