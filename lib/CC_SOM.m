function CC_SOM

num_bootstrp = 1000;
num_sample = 40;
addpath('./som');
% num_variable = 3276; %variable, or component number
% [temp,bootsample] = bootstrp(num_bootstrp,[],1:num_sample);
bootsample = [1:40]';
% initialize structs and matrices
matrix_ini = zeros(num_sample,num_sample);
matrix_CI = struct('CI',matrix_ini,'cluster',matrix_ini,'count',matrix_ini);

for i = 1:num_bootstrp
    % construct data struct sD
    sample_list_temp = bootsample(:,i);
    data_temp = data(sample_list_temp,:);
%   name_temp = name(sample_list_temp);
    
    sD = som_data_struct(data_temp,'labels',num2str([1:40]'));
%     sD = som_data_struct(data_temp,'labels',name_temp);
    sM = som_make(sD,'msize',[6 5],'init','randinit');
    sM = som_autolabel(sM,sD);
    bmus = som_bmus(sM,sD);
    
        
%     disp('Count:');
%     disp(i);
%     % check the appearance of items
%     for m = 1:(num_sample-1)
%         for n = (m+1):(num_sample)
%             if (ismember(m,bootsample(:,i))) && (ismember(n,bootsample(:,i)))
%                 matrix_CI.count(m,n) = matrix_CI.count(m,n) + 1;
%                 list_m = bmus(sample_list_temp==m);
%                 list_n = bmus(sample_list_temp==n);
%                 common = intersect(list_m,list_n);
%                 if ~isempty(common)
%                     matrix_CI.cluster(m,n) = matrix_CI.cluster(m,n) + 1;
%                 end
%             end
%         end
%     end
    
end

% matrix_CI.CI = (matrix_CI.cluster)./(matrix_CI.count);
% date_revised = date;
