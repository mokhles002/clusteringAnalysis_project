addpath('./som'); %#ok<MCAP>
R = normrnd(1,0.5,36,300);
data_all = normrnd(0,0.5,36,900);
data_all(1:12,1:300) = data_all(1:12,1:300) + R(1:12,:);
data_all(13:24,301:600) = data_all(13:24,301:600) + R(13:24,:);
data_all(25:36,601:900) = data_all(25:36,601:900) + R(25:36,:);

B = repmat(1:3,1,12);
C = sort(B);
class_label = num2cell(C');
for i = 1:length(class_label)
    class_label{i} = num2str(class_label{i});
end


sD = som_data_struct(data_all);
sG = som_make(sD);

CI = gc_CI_SOM(data_all, sG, 1000, 34, 1, [6 5], [10 100], 'class_label');
gc_treat_som(CI,class_label);