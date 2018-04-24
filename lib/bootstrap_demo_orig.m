%%
primates = fastaread('primatesaligned.fa');
num_seqs = length(primates);
orig_primates_dist = seqpdist(primates);
orig_primates_tree = seqlinkage(orig_primates_dist,'average',primates);
phytreetool(orig_primates_tree);

%%
num_boots = 100;
seq_len = length(primates(1).Sequence);

boots = cell(num_boots,1);
for n = 1:num_boots
    reorder_index = randsample(seq_len,seq_len,true);
    for i = num_seqs:-1:1 %reverse order to preallocate memory
        bootseq(i).Header = primates(i).Header;
        bootseq(i).Sequence = strrep(primates(i).Sequence(reorder_index),'-','');
    end
    boots{n} = bootseq;
end

%%

fun = @(x) seqlinkage(x,'average',{primates.Header});
boot_trees = cell(num_boots,1);
parfor (n = 1:num_boots)
    dist_tmp = seqpdist(boots{n});
    boot_trees{n} = fun(dist_tmp);
end

%%
for i = num_seqs-1:-1:1  % for every branch, reverse order to preallocate
    branch_pointer = i + num_seqs;
    sub_tree = subtree(orig_primates_tree,branch_pointer);
    orig_pointers{i} = getcanonical(sub_tree);
    orig_species{i} = sort(get(sub_tree,'LeafNames'));
end

%%
for j = num_boots:-1:1
    for i = num_seqs-1:-1:1  % for every branch
        branch_ptr = i + num_seqs;
        sub_tree = subtree(boot_trees{j},branch_ptr);
        clusters_pointers{i,j} = getcanonical(sub_tree);
        clusters_species{i,j} = sort(get(sub_tree,'LeafNames'));
    end
end

%%
count = zeros(num_seqs-1,1);
for i = 1 : num_seqs -1  % for every branch
    for j = 1 : num_boots * (num_seqs-1)
        if isequal(orig_pointers{i},clusters_pointers{j})
            if isequal(orig_species{i},clusters_species{j})
                count(i) = count(i) + 1;
            end
        end
    end
end

Pc = count ./ num_boots;

%%
[ptrs dist names] = get(orig_primates_tree,'POINTERS','DISTANCES','NODENAMES');

for i = 1 : num_seqs -1  % for every branch
    branch_ptr = i + num_seqs;
    names{branch_ptr} = [names{branch_ptr} ', confidence: ' num2str(10
0*Pc(i)) ' %'];
end

tr = phytree(ptrs,dist,names);
phytreetool(tr);