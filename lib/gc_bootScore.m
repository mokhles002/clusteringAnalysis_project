function bootScore = gc_bootScore(orig_pointers,map)
num_cell = 32;
num_boot = length(map);
bootScore = zeros(num_cell,3);

for i = num_cell:-1:1
    temp_cluster = orig_pointers(orig_pointers(:,2) == i);
    orig_cluster{i} = sort(temp_cluster);
end

for m = i:num_boot
    boot_pointers = [map(m).bootsample(:),map(m).bmus(:)];
    for j = num_cell:-1:1
        temp_cluster = boot_pointers(boot_pointers(:,2) == j);
        boot_cluster{j} = sort(temp_cluster);
    end
    
    for i = 1:num_cell
        if ~isempty(orig_cluster{i}) && all(ismember(orig_cluster{i},boot_pointers(:,1)))
            bootScore(i,2) = bootScore(i,2) + 1;
            for j = 1:num_cell
                if isequal(orig_cluster{i},boot_cluster{j})
                    bootScore(i,1) = bootScore(i,1) + 1;
                end
            end
        end
    end
    
end
bootScore(:,3) = bootScore(:,1) ./ bootScore(:,2);