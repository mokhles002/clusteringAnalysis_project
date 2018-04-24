function [data, varName, sampleName] = dataParse_clustering_excel()
% function to import the data for the PCA analysis
%% Initial dailog box to set reminder for file selection
% this section is added to provide the users cue to select file.
% Since on MAC the dialog box title does not show
d = dialog('units','normalized','Position',[0.4 0.4 .2 .14],'Name','');
uicontrol('Parent',d,...
    'units','normalized','Position',[0.2 0.3 .6 .4],...
    'Style','text',...
    'String',{'Select the input data file', '(xls or xlsx format)'},...
    'fontname','Arial', 'fontsize', 16);
pause(0.5);
%%
% Get input file names and path through user input
[fileName, pathName, ~] = uigetfile(fullfile(pwd,'*.xls;*.xlsx'), ...
    'Select xls or xlsx File', 'MultiSelect', 'off');
% close the dialog box
close (d);

path = [pathName, fileName];
tempData = importdata(path); % import data
data = tempData.data;
sampleName = tempData.textdata(2:end,1);
varName = tempData.textdata(1,2:end);
sampleName = strrep(sampleName,'_','-'); 
varName = strrep(varName,'_','-'); 
end
