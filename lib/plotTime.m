
h1 = figure;
set(h1, 'PaperUnits','inches', 'PaperSize',[2.9 3.5], 'PaperPosition',[0 0 2.9 3.5],... 
     'units', 'inches','Position',[0 0 2.9 3.5]);
h = bar(timeTotal/60, 0.6);
colormap([0 0.9 0.4; 1 0 1;]);
set(gca, 'xtick',1:1:nMethod,'xticklabel',methodName,'xticklabelrotation',60,...
    'fontname', 'Arial', 'fontsize', 9.5, 'tickdir','out');
xlim([0.5 nMethod+0.5]); ylim ([0 150]);
ylabel({'Computation Time'; '(min)'}, 'fontname', 'Arial','fontsize', 11);
xlabel('Dataset Property & Clustering Criteria',...
    'units','inches','fontname', 'Arial','fontsize', 10.5);

print(h1, '-dtiff', '-r300','computationTime_forPaper_bar4.tiff');
print(h1, '-dpdf', '-r300','computationTime_forPaper_bar4.pdf');
