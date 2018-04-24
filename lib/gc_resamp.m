function res = gc_resamp(nsamps,size,noresamp)
% resampling program
% nsamps --- the number of resamples to take
% size: sample size
% noresamp = 1: samples WITHOUT REPLACEMENT
% (c) by Gao Ce


if noresamp == 1
    indstotal = randperm(size);
    res = indstotal(1:nsamps);
else
    res = ceil(size*rand(nsamps,1));
end

res = res(:);

