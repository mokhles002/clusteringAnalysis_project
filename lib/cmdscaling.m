function cmdscaling(CI,name)
A = CI.CI;
num_sample = CI.parameters.num_sample;
A(isnan(A)) = 0;
A = A + triu(A)'+eye(num_sample);
Dist = 1-A;
Y = cmdscale(Dist);

sca3d(Y,name,1,'bo');
hold on;
sca3d(Y,name,2:5,'r*');
sca3d(Y,name,6:10,'y*');
sca3d(Y,name,11:14,'^');
hold off;

function sca3d(Y,name,ind,marker)
x = Y(ind,1);
y = Y(ind,2);
z = Y(ind,3);

scatter3(x,y,z,marker);
text(x,y,z,name(ind));

