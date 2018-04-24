[num, txt] = xlsread('For SETAC_SaltLAke.xlsx','Sheet1','A1:G145');
chemName = txt(2:end,1);
methodName = txt(1,2:end);
clusterID = num;
nCluster = size(methodName,2);

AdjRandInd = zeros(nCluster, nCluster);
RandInd = zeros(nCluster, nCluster);
MutualInfo = zeros(nCluster, nCluster);
HubertInd = zeros(nCluster, nCluster);
        
for p = 1:nCluster
    for q = 1:nCluster
        [ARI,RI,MI,HI] = RandIndex(clusterID(:,p),clusterID(:,q));
        AdjRandInd(p,q) = ARI;
        RandInd(p,q) = RI;
        MutualInfo(p,q) = MI;
        HubertInd(p,q) = HI;
    end
end
save ('For_SETAC_SaltLAke.mat');
h1 = figure;
y = [RandInd(1,1:end); AdjRandInd(1,1:end)];
bar(y,.5);
bar(RandInd(1,1:end),.5);
hold on
bar(AdjRandInd(1,1:end),.5);
set(gca, 'XTick', 1:9, 'XTickLabel', methodName,'fontsize',8,'XTickLabelRotation',45);
%xlabel ('Clustering Methods','fontsize',12); 
ylabel ('Rand Index','fontsize',12);
%saveas(h1,'figures/RandIndex.png')

%% rotate xtick label
set(gca,'XTick',1:9,'XTickLabel','')
hx = get(gca,'XLabel');  % Handle to xlabel 

set(hx,'Units','data'); 

pos = get(hx,'Position'); 

y = pos(2); 

% Place the new labels 

for i = 1:9 

    t(i) = text(i,y,methodName(:,i)); 

end 

set(t,'Rotation',45,'HorizontalAlignment','right')  

%% compute rand index following Lei's code

RI = zeros(1,8);
        
for p = 1:8
        data_label = ClusterID (:,p);
        RI_t = ComputeRI(data_label,groundTruth);
        RI(1,p) = RI_t;
end

% Results are not significant though.

%% for mid Concentration with ground truth

% ********************* Import "Ground Truth" data ************************
[groundTruth,GT_tags]=xlsread('C:\Users\smrahman\Dropbox\Mokhles\New_Research_Direction\Jennifar\Compute the Rand Index\Compute the Rand Index\groundTruth.xls','sheet1'); % 'groundTruth.xls' for 'data.csv'
% ********************* Import cluster assignment ************************************

[num, txt] = xlsread('ClusterComparison_midConcentration.xlsx','Sheet1','A1:i24');
chemName = txt(2:end,1);
methodName = txt(1,2:end);
clusterID = num;
nCluster = size(methodName,2);
save('midConcentration_clusterTab.mat','chemName','clusterID','methodName','nCluster');

Indices = zeros(nCluster, 4);


for p = 1:nCluster
       [ARI,RI,MI,HI] = RandIndex(clusterID(:,p),clusterID(:,3));
        Indices(p,1) = ARI;
        Indices(p,2) = RI;
        Indices(p,3) = MI;
        Indices(p,4) = HI;
end


% Compute Rand Index between our clustering result and ground truth
RI = zeros(1,nCluster);
        
for p = 1:nCluster
        data_label = clusterID (:,p);
        RI_t = ComputeRI(data_label,groundTruth_justChems);
        RI(1,p) = RI_t;
end

xlswrite('clusterIndex_midConc.xlsx',Indices);


for p = 1:8
       [ARI,RI,MI,HI] = RandIndex(ClusterID(:,p),GTID(:,2));
        Indices2(p,1) = ARI;
        Indices2(p,2) = RI;
        Indices2(p,3) = MI;
        Indices2(p,4) = HI;
end
figure;
plot(Indices2(:,2))


