function CI = gc_data_report(CI, varargin)
%Report the result and parameters in use, to data struct CI.
%Use "type gc_data_prep" for details.

%For explanation of paramters, refer to gc_data_prep;
%version: 1.00
%author: Ce Gao
%release date: 2011-10-05
%reference: Monti, S., P. Tamayo, et al. (2003). Machine Learning 52(1): 91-118.

% varargin
para = struct;
i=1;
while i<=length(varargin),
    argok = 1;
    if ischar(varargin{i}),
        switch varargin{i},
            % argument IDs
            case 'data',          i=i+1; para.data          = varargin{i};
            case 'num_sample',    i=i+1; para.num_sample    = varargin{i};
            case 'perturbation',  i=i+1; para.perturbation  = varargin{i};
            case 'sG',            i=i+1; para.sG            = varargin{i};
            case 'num_bootstrp',  i=i+1; para.num_bootstrp  = varargin{i};
            case 'num_resample',  i=i+1; para.num_resample  = varargin{i};
            case 'nonreplication',i=i+1; para.replication   = varargin{i};
            case 'mapsize',       i=i+1; para.mapsize       = varargin{i};
            case 'date',          i=i+1; para.date          = varargin{i};
            case 'training',      i=i+1; para.training      = varargin{i};
            otherwise
                argok=0;
        end
    else
        argok = 0;
    end
    if ~argok,
        disp(['(gc_report) Ignoring invalid argument #' num2str(i+1)]);
    end
    i = i+1;
end

CI.CI        = CI.connectivity./CI.indicator;
CI.parameters = para;
% 
% for m = 1:10
%     CI(m).CI        = CI(m).connectivity./CI(m).indicator;
%     CI(m).parameters = para;
% end
% 
