function CI = gc_CI_SOM(data_in, sG, num_bootstrp, num_resample, norep, mapsize, training, data_name)
% [CI,bootScore] = gc_CI_SOM(data_all, sG_all3, 1000, 38, 1, [8 4], [10 100], name, orig_pointers)
%Carry out CC based on SOM.
%Use "type gc_CI_SOM" for details.

%For explanation of paramters, refer to gc_data_prep;
%version: 1.1
%author: Ce Gao
%release date: 2011-10-05 
%modification data: 2011-10-24
%reference: Monti, S., P. Tamayo, et al. (2003). Machine Learning 52(1): 91-118.

% norep
% 1: without replication; 
% 0 or other number: with replication.
%mapsize = [8 4];
%training = [10 100];

%% initialize structs and matrices
data_treated = gc_data_prep(data_in);
num_sample  = data_treated.num_sample;
data        = data_treated.data;
CI          = data_treated.CI;
% for m =10:-1:1
%     CI(m)   = data_treated.CI;
% end
% ------------------------------------------------------------------------------
%% Consensus Loop
disp('Computation started!');
for i = num_bootstrp:-1:1
    %% bootstrapping re-sample
    bootsample = gc_resamp(num_resample,num_sample,norep);
    data_temp = data(bootsample,:);
   
    %% SOM
    sD = som_data_struct(data_temp);
    sM = gc_som_make(sD,sG,'msize',mapsize,'training',training,'tracking',0);
    bmus = som_bmus(sM,sD);
    base = som_dmatclusters(sM);
    CI = consensusIndex(CI, bootsample, base, bmus, num_sample);
%     sC = som_cllinkage(sM); %hierarchical clustering
%     for m = 2:10
%         T = cluster(sC.tree,'maxclust',m);
%         CI(m) = consensusIndex2(CI(m), bootsample,bmus, T, num_sample);
%     end
    %% Connectivity matrix and indicator matrix
    disp(i); %just indicate the current status of program running
end
%summarized all the data into a structure
CI = gc_data_report(CI,...
    'data',data_name,...
    'perturbation','sample',...
    'sG',sG,...
    'num_sample',num_sample,...
    'num_bootstrp',num_bootstrp,...
    'num_resample',num_resample,...
    'training',training,...
    'nonreplication',norep,...
    'mapsize',mapsize,...
    'date',date);
end
