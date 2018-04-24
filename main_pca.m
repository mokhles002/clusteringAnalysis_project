%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Author: Sheikh Mokhlesur Rahman
%   Conducts PCA of the wca data
%   Date created: 7-22-2013
%   Date modified: TBD
%   PCA Run principal component analysis on the dataset X
%   [U, S, X] = pca(X) computes eigenvectors of the covariance matrix of X
%   Returns the eigenvectors U, the eigenvalues (on diagonal) in S
%

% Useful values
clear;
clc;
load('datasetCombined_for_CC_movAvg.mat');

folderName = './Results/PCA/';
fileNameSuffix = 'PCA';

t=tic;
DataValue = Induction;
[m, n] = size(DataValue);
DataMean = mean (DataValue);
DataAdjusted=bsxfun(@minus,DataValue,DataMean); % Adjust data so that mean is zero
%% PCA with eigen value formula
% coVarMat = cov(DataAdjusted); % calculate the covariances
% [eigenVectors, eigenValues] = eig(coVarMat); % calculate the eigenvectors (direction) and eigenvalues (variances)

%% PCA using PCA formula

[coeff,PCA_Data_Combined,latent,tsquared,explained] = pca(DataValue);

Elapsedtime3 = toc (t);
%{
    coeff: stores the eigenvectors; with component directions
    score: projected data to the principle component direction
    latent: eigen values, which indicates the variances
    explained: % of variance covered in each dimension
%}

t=tic;
[m, n] = size(DataValue);
Threshold = 70/n;
ind = find (100-cumsum(explained)>= Threshold);
Cutoff_PCA_Data_Combined = PCA_Data_Combined(:,ind);
Elapsedtime4 = toc (t);
%{
xlim ([-8, 8]);
ylim([-8, 8]);

title ('Adjusted PCA data');
legend('Adjusted Data', 'Principal Component 1','Principal Component 2','Location','Best');
title ('Adjusted Data with Principal Component','fontsize',18);
xlabel ('Original Dimension 1','fontsize',15);
ylabel ('Original Dimension 2','fontsize',15);
%}

%% Drawing figure of variances
varFigure = figure;
DimensionEig = size(latent,1);
plot(1:DimensionEig,explained,'o-b','LineWidth',2,...
                    'Markersize',4,'MarkerFaceColor','b');

title ('Variances explained by the reduced dimension after PCA','fontsize',16);
xlabel ('Dimension Number','fontsize',13);
ylabel ('% Variance explained','fontsize',13);

saveas(varFigure, strcat(folderName,fileNameSuffix,'Variance_explained'),'png');
saveas(varFigure, strcat(folderName,fileNameSuffix,'Variance_explained'),'epsc');
saveas(varFigure, strcat(folderName,fileNameSuffix,'Variance_explained'),'fig');

% plot cumulative var explained
cumvarFigure = figure;
plot(1:DimensionEig,cumsum(explained),'ob','LineWidth',2,...
                    'Markersize',4,'MarkerFaceColor','b');

title ('Cumulative Variances explained by the reduced dimension after PCA','fontsize',16);
xlabel ('Dimension Number','fontsize',13);
ylabel ('Cumulative Variance explained (%)','fontsize',13);
ylim([0,100]);
saveas(cumvarFigure, strcat(folderName,fileNameSuffix,'CumulativeVariance_explained'),'png');
saveas(cumvarFigure, strcat(folderName,fileNameSuffix,'CumulativeVariance_explained'),'epsc');
saveas(cumvarFigure,strcat(folderName,fileNameSuffix,'CumulativeVariance_explained'),'fig');
save(strcat(folderName,fileNameSuffix,'PCA_test_result.mat'),'PCA_Data_Combined','Cutoff_PCA_Data_Combined','Elapsedtime3','Elapsedtime4','explained');
