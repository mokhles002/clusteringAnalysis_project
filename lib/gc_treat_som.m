%function [H, T, perm]= gc_treat_som(CI,name) % modified by SMR to get some output
function [labels, fid1, fid2]= gc_treat_som(CI,name) % modified by SMR to get some output
% edited by: Sheikh Mokhlesur Rahman
% Date of modify: 08-01-2013
%% retrive consensus matrix
A = CI.CI;
num_sample = CI.parameters.num_sample;
A(isnan(A)) = 0;
A = A + triu(A)'+eye(num_sample);

%% get distance matrix
B = 1-A;
Dist = [];
for m = 1:(num_sample-1)
    Dist = cat(2,Dist,B(m,(m+1):num_sample));
end
%% dendrogram with linkage
Tree = linkage(Dist,'average');
%fid1 = figure(1);
fid1 = figure('units','inches','paperunits','inches','position',[ 0 0 8 7],...
        'paperposition',[0 0 8 7],'papersize',[8 7]);
[H,~,perm] = dendrogram(Tree,0,'labels',strrep(name,'_','-'),'orientation','left','ColorThreshold','default');
set(H,'LineWidth',1.5);
set(gca,'FontSize',9)
xlabel('Distance (1-CI)','fontsize',14);

Order = flipud(perm');  %SMR modification for flip-flopping cc figure, so that it is similar to dendrogram.
C = zeros(num_sample,num_sample);
for m = 1:num_sample
    for n = 1:num_sample
        C(m,n) = A(Order(m),Order(n));
    end
end

fid2 = figure('units','inches','paperunits','inches','position',[ 0 0 8 7],...
        'paperposition',[0 0 8 7],'papersize',[8 7]);
imagesc(C,[0,1]);
colormap(jet);
labels = name(Order);
set(gca,'YTick',1:num_sample);
set(gca,'YTickLabel',strrep(labels,'_','-'));
set(gca,'XTick',[]);

%% modification by SMR
set(gca,'FontSize',9);
h = colorbar('location','EastOutside');
set (h,'fontsize',12);
h.Label.String = 'Consensus Index (CI)';
h.Label.FontSize = 14;
end
