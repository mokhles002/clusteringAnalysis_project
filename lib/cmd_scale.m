%%
D = CI.CI;
num_sample = CI.parameters.num_sample;
D(isnan(D)) = 0;
D = D + triu(D)'+eye(num_sample);

%%
Y = cmdscale(D);
xCord = Y(:,1);
yCord = Y(:,2);

%%
scatter(xCord,yCord);
text(xCord,yCord,name);