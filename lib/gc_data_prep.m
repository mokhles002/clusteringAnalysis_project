function out = gc_data_prep(data_in)
%Organze and filter data; initialize data struct.
%Use "type gc_data_prep" for details.

%Detailed Description
%1.data_in:a matrix
%   line:   treatment(a specific material at a specific concentration);
%   column: expression value of a specific gene at a specific time point;
%2.out: a struct containing info for further analysis, its fields include
%   data_in, data: original and treated matrices;
%   num_sample,num_gene: treatment and gene numbers;
%   CI: struct for consensus clustering, its fields include
%       CI: initialized consensus matrix;
%       connectivity: initialized connectivity matrix;
%       indicator: initialized indicator matrix;
%       parameters: struct for consensus clustering, its fields include
%             data:name of study;
%             filter: filtered (1) or not (0);
%             perturbation: type of disturbance-'sample' or 'gene'
%             sG: Fixed initial seed;
%             num_sample: number of original sample;
%             num_bootstrp: number of bootstrping;
%             num_resample: number of samples in new group;
%             nonreplication: EXclude replicates(1) or not(0)for resampling
%             mapsize: geometry of self-organizing map;
%             date: date of study;
%             training: [rough fine], a matrix setting training time;

%version: 1.00
%author: Ce Gao
%release date: 2011-10-05 
%reference: Monti, S., P. Tamayo, et al. (2003). Machine Learning 52(1): 91-118.

%% construct output struct
out =  struct(...  
    'data_in','',...
    'data','',...
    'num_sample','',...
    'num_gene','',...
    'mat','',...
    'CI','',...
    'ini','');

%% sample size
samplingTime = 21; %Global (changed)
[out.num_sample,time_point] = size(data_in);
out.num_gene = time_point/samplingTime;
% ------------------------------------------------------------------------------

%% filter: get out the low expression value (noise)
filter = 1;%1 means filter has been applied, 0 not applied.
while filter
    out.data_in = data_in; % give back original data
    out.data = data_in;
    filter = logical((data_in>-0.4) .* (data_in<0.4));
    out.data(filter) = 0;
end
% ------------------------------------------------------------------------------
%% CI matrix construction
mat_ini = zeros(out.num_sample,out.num_sample);
out.CI = struct(...
    'CI',mat_ini,...
    'connectivity',mat_ini,...
    'indicator',mat_ini,...
    'parameters','');
out.CI.parameters = struct(...
    'data','', ...
    'filter','',...
    'perturbation','',...
    'sG', '',...
    'num_sample','', ...
    'num_bootstrp','',...
    'num_resample','',...
    'nonreplication','',...
    'mapsize','',...
    'date','',...
    'training','');
out.CI.parameters.filter = filter; 
