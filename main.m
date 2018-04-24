%%un-comment the code in specific sections to run

%% mandatory, addpath to call the functions in SOM toolboxs, and load the parameters from mat files.
addpath('../../../CC_2013_06_22/som/');
addpath('../../../CC_2013_06_22/');
clear;
load('data_after_local_PCA_conc_4.mat');
clc;
%%
data_combined = geneTELI;
folderName = 'figures/';
fileNameSuffix = 'PROTECT_urine';
[nSample, nVar] = size(data_combined);
%t1 = tic;
[sG, mapSize] = som_make(data_combined);
%Elapsedtime1 = toc(t1);
%pause;
%%
% CI = gc_CI_SOM(data_in, sG, num_bootstrp, num_resample, norep, mapsize, training, data_name)
%t2 = tic;
CI = gc_CI_SOM(data_combined, sG, 1000, nSample, 0, mapSize,[10 100], strcat('Data_',fileNameSuffix));
[ordered_ChemName] = gc_treat_som(CI,sampleName);
%Elapsedtime2 = toc(t2);

save (strcat(folderName,'Result_',fileNameSuffix,'.mat'),'CI','ordered_ChemName');
%save (strcat(folderName,'Result_',fileNameSuffix,'.mat'),'Elapsedtime1','Elapsedtime2','CI','ordered_ChemName');

handles=findall(0,'type','figure');
saveas (handles(2),strcat(folderName,'Dendogram_',fileNameSuffix),'pdf');
saveas (handles(1),strcat(folderName,'CC_fig_',fileNameSuffix),'pdf');
saveas (handles(2),strcat(folderName,'Dendogram_',fileNameSuffix),'tiff');
saveas (handles(1),strcat(folderName,'CC_fig_',fileNameSuffix),'tiff');
saveas (handles(2),strcat(folderName,'Dendogram_',fileNameSuffix),'fig');
saveas (handles(1),strcat(folderName,'CC_fig_',fileNameSuffix),'fig');
xlswrite(strcat(folderName,'Ordered_ChemName_',fileNameSuffix,'.xls'),ordered_ChemName);

%% change font size
set(gca,'FontSize',4)
h = colorbar('location','SouthOutside');
saveas(gca,'test_eps2c_4','eps2c');
set (h,'fontsize',10);
saveas (gca,'modified_figures/Dendrogram_5000_small','png');
saveas (gca,'modified_figures/CC_fig_1000_tt_6','png');
%%
xlswrite('150Treatment_PCA_ReducedData.csv',PCA_Data_Combined,chemName,'Sheet1','B1');

% ylhand = get(gca,'ylabel');
% set(ylhand,'string','Y','fontsize',8);`