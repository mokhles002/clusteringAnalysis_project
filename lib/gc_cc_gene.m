function CI = gc_cc_gene(CI, num_bootstrp, base, bmus, num_sample)
%% consensus index loop
for m = 1:(num_sample-1)
    for n = (m+1):(num_sample)
        list_m = base(bmus(m));
        list_n = base(bmus(n));
        common = intersect(list_m,list_n);
        if ~isempty(common)
            CI.connectivity(m,n) = CI.connectivity(m,n) + 1;
        end
        
    end
end

CI.indicator = ones(num_sample,num_sample).*num_bootstrp;
