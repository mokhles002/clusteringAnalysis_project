function [tr, average_CI] = ci_tree(CI,name)
%% HC_jackknife
% clear;
% load('CI_som_redox.mat');
%%
method = 'average';

%% get distance matrix
A = CI.CI;
num_sample = CI.parameters.num_sample;
A(isnan(A)) = 0;
A = A + triu(A)'+eye(num_sample);

B = 1-A;
Dist = [];
for m = 1:(num_sample-1)
    Dist = cat(2,Dist,B(m,(m+1):num_sample));
end

%% build the tree
for i = length(name):-1:1
    name_order{i} = num2str(i);
end
orig_tree  = seqlinkage(Dist,method,name_order);
% orig_tree  = seqlinkage(Dist,method,name);
%%
for i = num_sample-1:-1:1  % for every branch, reverse order to preallocate
    branch_pointer = i + num_sample;
    sub_tree = subtree(orig_tree,branch_pointer);
    orig_pointers{i} = getcanonical(sub_tree);
    orig_sample{i} = sort(get(sub_tree,'LeafNames'));
    temp = flatten(orig_sample{i});
    temp2 = zeros(1);
    for j = length(temp):-1:1
        temp2(j) = str2double(temp{j});
    end
    sub_node{i} = temp2;
end

%% get average CI
for i = (num_sample - 1):-1:1
    branch_len = length(sub_node{i});
    CI_sum = 0;
    count = 0;
    for j = 1:branch_len - 1
        for k = j+1:branch_len
            CI_sum = CI_sum + CI.CI(j,k);
            count = count + 1;
        end
    end
    average_CI(i) = CI_sum / count;
end

%%
[ptrs dist names] = get(orig_tree,'POINTERS','DISTANCES','NODENAMES');
% names = name;
for i = 1 : num_sample -1  % for every branch
    branch_ptr = i + num_sample;
    names{branch_ptr} = [num2str(i) ', ' num2str(average_CI(i))];
end

%%
for i =num_sample:-1:1
    ind(i) =str2double(names{i});
end
tr = phytree(ptrs,dist,[name(ind);names(num_sample+1:end)]);
% phytreetool(tr);