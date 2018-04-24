%% HC_jackknife
clear;
load('matlab','data_all','name');
%%
method = 'weighted';
num_sample = size(data_all,1);
orig_dist  = pdist(data_all);
orig_tree  = seqlinkage(orig_dist,method,name);

%% prepare boot samples
num_boots = 1000;
boots = cell(num_boots,1);
num_resample = num_sample - 2 ;
for n = 1:num_boots
    reorder_index = randsample(num_sample,num_resample,false);
    bootSample.Name = name(reorder_index);
    bootSample.Sample = data_all(reorder_index,:);
    boots{n} = bootSample;
end

%%
boot_trees = cell(num_boots,1);
for n = 1:num_boots
    dist_tmp = pdist(boots{n}.Sample);
    boot_trees{n} = seqlinkage(dist_tmp,method,boots{n}.Name);
end

%%
for i = num_sample-1:-1:1  % for every branch, reverse order to preallocate
    branch_pointer = i + num_sample;
    sub_tree = subtree(orig_tree,branch_pointer);
    orig_pointers{i} = getcanonical(sub_tree);
    orig_sample{i} = sort(get(sub_tree,'LeafNames'));
end

%%
num_app = zeros(num_sample-1,1);
for j = num_boots:-1:1
    for k = num_sample-1:-1:1
        if all(ismember(orig_sample{k},boots{j}.Name))
            num_app(k) = num_app(k) + 1;
        end
    end
    for i = num_resample-1:-1:1  % for every branch
        branch_ptr = i + num_resample;
        sub_tree = subtree(boot_trees{j},branch_ptr);
        clusters_pointers{i,j} = getcanonical(sub_tree);
        clusters_sample{i,j} = sort(get(sub_tree,'LeafNames'));
    end
end

%%
count = zeros(num_sample-1,1);
for i = 1 : num_sample -1  % for every branch
    for j = 1 : num_boots * (num_resample-1)
%         if isequal(orig_pointers{i},clusters_pointers{j}) % for subtree order
            if isequal(orig_sample{i},clusters_sample{j})
                count(i) = count(i) + 1;
            end
%         end
    end
end
Pc = count ./ num_app  ; % num_boots 

%%
[ptrs dist names] = get(orig_tree,'POINTERS','DISTANCES','NODENAMES');

for i = 1 : num_sample -1  % for every branch
    branch_ptr = i + num_sample;
    names{branch_ptr} = [num2str(i) ', ' num2str(100*Pc(i)) ' %'];
end

tr = phytree(ptrs,dist,names);
phytreetool(tr);