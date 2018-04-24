%Author: Sheikh Mokhlesur Rahman
%Date Created: 6/27/2013
fid = fopen('ChemicalName_Na.txt');
C = textscan(fid,'%s\t%s\t%s\t%s\t%s\t%s');

%chemName = zeros(12,6);
for m =1:6
chemName (:,m) = C{m};
end
chemName = reshape (chemName',numel(chemName),1);
save ('dataset2_for_CC_movAvg','Induction_Average_Log', 'geneNames', 'creationTime','chemName');

%% chemName single time

for  i = 1: numel(chemName)
OnlyChem {i} = chemName{i}(1:end-2);
end;
OnlyChem = reshape(OnlyChem,6,25);
OnlyChem = OnlyChem (1,:)';

%% color for MDS

colorCode = 1:20;
colorCode = repmat(colorCode, 6,1);
colorCode = reshape (colorCode,numel(colorCode),1);
