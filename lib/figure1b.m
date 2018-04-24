clear;
load;
load matlab_seed;
addpath('./som/'); %#ok<MCAP>

mapsize = [8 4];
training = [10 100];

sD = som_data_struct(data_all_rev,'labels',name);
sM = gc_som_make(sD,sG_all3,'msize',[8 4],'training',training,'tracking',0);
bmus = som_bmus(sM,sD);
orig_pointers = [(1:40)',bmus];

% base = som_dmatclusters(sM);

[CI,map] = gc_CI_SOM(data_all_rev, sG_all3, 1000, 38, 0, [8 4], [10 100], name);
bootScore = gc_bootScore(orig_pointers,map);