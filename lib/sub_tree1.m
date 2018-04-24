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

%%
for i = num_sample-1:-1:1  % for every branch, reverse order to preallocate
    branch_pointer = i + num_sample;
    sample_sub_tree = subtree(sample_tree,branch_pointer);
    rev_pointers{i} = getcanonical(sample_sub_tree);
    rev_sample{i} = sort(get(sample_sub_tree,'LeafNames'));
    temp = flatten(rev_sample{i});
    temp2 = zeros(1);
    for j = length(temp):-1:1
        temp2(j) = str2double(temp{j});
    end
    sample_sub_node{i} = temp2;
end

%%
CI_sum = 0;
for i = (num_sample - 1):-1:1
    for j = 1:num_sample-1
        if isequal(sample_sub_node{j},sub_node{i})
            CI_sum = CI_sum + 1;
        end        
    end
end