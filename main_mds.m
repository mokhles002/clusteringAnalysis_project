%% Conduct the MDS analysis on the data set
clear;
close all;
load data_mds;

%%
folderName = 'Results/MDS/';
fileNameSuffix = 'MDS_correlation';

data_combined = Induction;
t1 = tic;
D = pdist(data_combined,'correlation'); % correlation distance
%D = pdist(data_combined,'euclidean'); % euclidean distance

%%
[MDS_Data_combined, eigvals] = cmdscale(D); % MDS

Elapsedtime3= toc(t1);
[eigvals eigvals/max(abs(eigvals))];

%% Plot variances

varMDSFigure = figure;
DimensionEig = size(MDS_Data_combined,2);
eigvalsPercent = eigvals(1:DimensionEig)/(sum(eigvals(1:DimensionEig)))*100;
plot(1:DimensionEig,eigvalsPercent,'db',...
                    'Markersize',5,...
                    'MarkerFaceColor','b');

title ('Relative contribution of different dimension after MDS','fontsize',16);
%ylim([0 100]);
xlabel ('Dimension Number','fontsize',13);
ylabel ('% Relative Contribution','fontsize',13);

saveas(varMDSFigure, strcat(folderName,'Relative_contribution_',fileNameSuffix),'png');
saveas(varMDSFigure, strcat(folderName,'Relative_contribution_',fileNameSuffix),'epsc');
saveas(varMDSFigure, strcat(folderName,'Relative_contribution_',fileNameSuffix),'fig');

% plot cum sum
varMDScum = figure;
plot(1:DimensionEig,cumsum(eigvalsPercent),'db',...
                    'Markersize',5,'MarkerFaceColor','b');
ylim([0 100]);
title ('Cumulative Relative contribution of different dimension after MDS','fontsize',16);
xlabel ('Dimension Number','fontsize',13);
ylabel ('Cumulative Relative Contribution (%)','fontsize',13);

saveas(varMDScum, strcat(folderName,'CumRelative_contribution_',fileNameSuffix),'png');
saveas(varMDScum, strcat(folderName,'CumRelative_contribution_',fileNameSuffix),'epsc');
saveas(varMDScum, strcat(folderName,'CumRelative_contribution_',fileNameSuffix),'fig');
save( strcat(folderName,'MDS_test_result_',fileNameSuffix,'.mat'),'MDS_Data_combined','Elapsedtime3','eigvals','eigvalsPercent');

%% No need
h3 = figure;
scatter(MDS_Data_combined(:,1),MDS_Data_combined(:,2),60,colorCode,'o','filled');
ind = 1:3:36;
text(MDS_Data_combined(ind,1),MDS_Data_combined(ind,2),names(ind));
%% Plot 3D
scatter3(MDS_Data_combined(:,1),MDS_Data_combined(:,2),MDS_Data_combined(:,3),60,colorCode,'o','filled');

scatter3(MDS_Data_combined(1:30,1),MDS_Data_combined(1:30,2),MDS_Data_combined(1:30,3),120,names_color(1:30),'o','filled');
hold on;
scatter3(MDS_Data_combined([31,34],1),MDS_Data_combined([31,34],2),MDS_Data_combined([31,34],3),120,names_color([31,34]),'d','filled');
scatter3(MDS_Data_combined([32,35],1),MDS_Data_combined([32,35],2),MDS_Data_combined([32,35],3),120,names_color([32,35]),'^','filled');
scatter3(MDS_Data_combined([33,36],1),MDS_Data_combined([33,36],2),MDS_Data_combined([33,36],3),150,names_color([33,36]),'p','filled');
hold off;

ind = 3:6:120;
text(MDS_Data_combined(ind,1),MDS_Data_combined(ind,2),MDS_Data_combined(ind,3),chemName(ind));


%% to plot 3D with legend
figure;
for i = 1:numel(OnlyChem)
   hold on; 
    %scatter3(Y(6*i-5:6*i,1),Y(6*i-5:6*i,2),Y(6*i-5:6*i,3),60,C1(6*i-5:6*i,:),'o','filled');
    scatter3(MDS_Data_combined(6*i-5:6*i,1),MDS_Data_combined(6*i-5:6*i,2),MDS_Data_combined(6*i-5:6*i,3),...
            60,'o','filled');
end
legend(OnlyChem);    
%legend(OnlyChem, 'show');    

view(3);
grid on;
xlabel('Dimension 1');
ylabel('Dimension 2');
zlabel('Dimension 3');

xlim([-0.2, 1.2]);
zlim([-0.4, 0.2]);
set(legend,'Location','NorthEast');
set(legend,'fontSize',8);
saveas (gca, 'Combined_MDS_legend_correlation_Legend_color.tif');
saveas (gca, 'results\Combined_MDS_correlation_Legend_color.fig');