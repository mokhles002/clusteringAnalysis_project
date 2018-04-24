function RI = ComputeRI(data_label,groundTruth)
%--------------------------------------------------------------------------
% Input: data_label:        [N*1] label vector 
%        groundTruth:       [N*m] label matrix where m is # of possible labels
% Output: RI:               a scaler, Rand index
%--------------------------------------------------------------------------

%% Get rid of chemicals without ground truth.
% *************************************************************************
IDX = any(groundTruth,2);
data_label = data_label(IDX,:);
groundTruth = groundTruth(IDX,:);
%--------------------------------------------------------------------------

%% Compute all combinations of chemicals.
% *************************************************************************
N = size(data_label, 1); % The number of chemicals
m = size(groundTruth,2); % The number of possible labels in ground truth
C = nchoosek(1:N,2);     % all combinations of N items taken 2 at a time
%--------------------------------------------------------------------------

%% Compute Rand index.
% *************************************************************************
agreements = 0;
for i = 1 : size(C,1)
    chemical_1 = C(i,1);
    chemical_2 = C(i,2);
    chemical_1_label = data_label( chemical_1, 1 );
    chemical_2_label = data_label( chemical_2, 1 );
    chemical_1_GT = groundTruth(chemical_1,:);
    chemical_2_GT = groundTruth(chemical_2,:);
    
    % To see whether chemical_1 & chemical_2 are estimated in one cluster
    if chemical_1_label == chemical_2_label
        a = 1;
    else
        a = 0;
    end
    
    % To see whether chemical_1 & chemical_2 should be in one cluster using ground truth
    b = 0;
    for j = 1 : m
        if chemical_1_GT(j) == 1 && chemical_2_GT(j) == 1
            b = 1;
           break;
        end
    end
    
    if a == b
        agreements = agreements + 1;
    end
end
RI = agreements / size(C,1);
%--------------------------------------------------------------------------