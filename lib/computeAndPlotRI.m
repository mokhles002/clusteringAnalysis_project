load clusterValidationInputData_April2016.mat
id = 1:8;
nMethod = numel(id); 
AdjRandInd = zeros(nMethod,1);
RandInd = zeros(nMethod,1);
MutualInfo = zeros(nMethod,1);
HubertInd = zeros(nMethod,1);
        
for p = 1:nMethod
    q = id(p);
    [ARI,RI,MI,HI] = RandIndex(clusterID(:,1),clusterID(:,q));
    AdjRandInd(p) = ARI;
    RandInd(p) = RI;
    MutualInfo(p) = MI;
    HubertInd(p) = HI;
end
methodName = methodName(id);
save clusterValidationResult_July2016.mat AdjRandInd RandInd MutualInfo HubertInd methodName;

%% plot
h1 = figure;
%set(h1, 'PaperUnits','inches', 'PaperSize',[7 5.5], 'PaperPosition',[0 0 7 5.5]);
set(h1, 'PaperUnits','inches', 'PaperSize',[5.25 4.5], 'PaperPosition',[0 0 5.25 4.5],...
    'units', 'inches','Position',[0 0 5.25 4.5]);
bar([RandInd AdjRandInd]);
colormap([0 0.9 0.4; 1 0 1;]); % colormap(cool);
set(gca, 'xtick',1:1:nMethod,'xticklabel',methodName,'xticklabelrotation',60,...
    'fontname', 'Arial', 'fontsize', 11.5, 'tickdir','out','ytick',0:0.2:1);
xlim([0.5 nMethod+0.5]);
hl = legend({'Rand Index', 'Adjusted Rand Index'}, 'fontname', 'Arial',...
            'fontsize', 10, 'box', 'off');
set(hl,'Position',get(hl,'Position')+[0.01 0.02 0 0]);

ylabel('Index Value', 'fontname', 'Arial','fontsize', 13);
xlabel('Dataset Property & Clustering Criteria', 'fontname', 'Arial','fontsize', 13);

print(h1, '-dtiff', '-r300','IndexValues_July_2016_forPaper6.tiff');
print(h1, '-dpdf', '-r300','IndexValues_July_2016_forPaper6.pdf');

%% NMI
id = 1:8;
nMethod = numel(id); 
NormMutualInfo = zeros(nMethod,1);
for p = 1:nMethod
    q = id(p);
    ind = nmi(clusterID(:,1),clusterID(:,q));
    NormMutualInfo(p) = ind;
end

%% plot with NMI
h1 = figure;
set(h1, 'PaperUnits','inches', 'PaperSize',[7 6], 'PaperPosition',[0 0 7 6]);
h = bar([RandInd AdjRandInd NormMutualInfo]);
colormap(cool)
set(gca, 'xtick',1:1:nMethod,'xticklabel',methodName,'xticklabelrotation',60,...
    'fontname', 'Arial', 'fontsize', 14, 'tickdir','out');
xlim([0.5 nMethod+0.5]);
legend({'Rand Index', 'Adjusted Rand Index', 'Normalized Mutual Information'}, 'fontname', 'Arial',...
            'location', 'northeast','fontsize', 12, 'box', 'off');
ylabel('Index Value', 'fontname', 'Arial','fontsize', 16);
xlabel('Dataset Property & Clustering Criteria', 'fontname', 'Arial','fontsize', 16);
print(h1, '-dtiff', '-r300','IndexValues_July_2016_withNMI.tiff');
print(h1, '-dpdf', '-r300','IndexValues_July_2016_withNMI.pdf');

%% plot EC50 and TELI for discussion
for ind = 1:4;
    h1 = figure;
    set(h1, 'PaperUnits','inches', 'PaperSize',[8 5.5], 'PaperPosition',[0 0 8 5.5]);
    if ind == 2
        vls = endPoints(:,ind);
    else
        vls = log(endPoints(:,ind));
    end
for id = 1:8
    subplot(2,4,id);
    [grpAve,grp, counts] = grpstats(vls,clusterID(:,id),...
                    {'mean','gname','numel'});
    boxplot(vls,clusterID(:,id));
    hold on;
    %scatter(1:numel(grp),grpAve,25,'bv');
    text(1:numel(grp),grpAve,num2str(counts),'fontname','arial','fontsize',7);
    title(methodName(id),'fontname','arial','fontsize',10);
end
print(h1, '-dtiff', '-r300',strcat('groupEndPointComparison/', endPointLabel{ind},'_2.tiff'));
clear h1; close all;
end


