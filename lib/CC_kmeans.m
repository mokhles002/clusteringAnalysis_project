clear;
load;
clc;

num_bootstrp = 1000;
num_sample = 40;
num_resample = 30;
num_cluster = 10; % for HC, num_cluster is the maximum number of clusters


data = data_all;

h = waitbar(0,'In progress');

% initialize structs and matrices
matrix_ini = zeros(num_sample,num_sample);
for i = num_cluster:-1:1
    CI(i) = struct('CI',matrix_ini,'connectivity',matrix_ini,'indicator',matrix_ini);
end
%create a empty matrix the same size as our sample
sample_size = zeros(1,num_sample);


for i = 1:num_bootstrp
    bootsample = gcresamp(num_resample,sample_size,1)';
    data_temp = data(bootsample,:);
    %   name_temp = name(sample_list_temp);
    
    for j = 2:num_cluster
        T = kmeans(data_temp,j,'emptyaction','singleton');
        % check the appearance of items
        for m = 1:(num_sample-1)
            for n = (m+1):(num_sample)
                if (ismember(m,bootsample)) && (ismember(n,bootsample))
                    CI(j).indicator(m,n) = CI(j).indicator(m,n) + 1;
                    
                    %  common = intersect(T(bootsample==m),T(bootsample==n));
                    %  if ~isempty(common)
                    %       CI(j).connectivity(m,n) = CI(j).connectivity(m,n) + 1;
                    %  end
                    if T(bootsample==m) == T(bootsample==n)
                        CI(j).connectivity(m,n) = CI(j).connectivity(m,n) + 1;
                    end
                end
            end
        end
    end
    disp(i);
    waitbar(i/num_bootstrp,h);
end

close(h);
for j = 2:num_cluster
    CI(j).CI = (CI(j).connectivity)./(CI(j).indicator);
end
date_revised = date;

clear num_bootstrp num_sample num_resample num_cluster;
clear data data_temp bootsample Z T;
clear matrix_ini sample_size;
clear i j m n h;
clear common;
save;
