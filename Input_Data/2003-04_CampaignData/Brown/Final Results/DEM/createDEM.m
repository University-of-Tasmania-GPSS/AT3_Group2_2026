% script to correct the Brown DEM
% the values used for rate (sampling rate=10) and in linspace (300) were found through
% trial and error
%
% Martin Truffer, March 2001

rate=10;
cddem;
err=browndem('go','old');
ind=1:rate:6647;
x=err(ind,1);
y=err(ind,2);
z=err(ind,3);
clear err

erradd=[408000 4116000 0; 411000 4116500 0; 410000 4116500 0; ...
      409000 4116500 0; 406000 4119000 0; 409000 4119000 0;   ...
      407000 4119000 0; 408000 4119300 0; 405100 4116500 0; 406000 4115600 0];
x=[x;erradd(:,1)];
y=[y;erradd(:,2)];
z=[z;erradd(:,3)];

xs=linspace(min(x),max(x),300);
ys=linspace(min(y),max(y),300);

[X Y]=meshgrid(xs,ys);
Z=griddata(x,y,z,X,Y,'cubic');

[yi, J]=sort(Y(:,1));
xi=X(1,:);
for i=1:length(yi)
   ZI(i,:)=Z(J(i),:);
end
clear X
clear Y
clear Z

data=load('brownarea.dat');
[n m]=size(data);
east=data(1,2:m);
north=data(2:n,1);
dem=data(2:n,2:m);

dz=griddata(xi,yi,ZI,east,north,'cubic');
[I J]=find(isnan(dz)==1);
for i=1:length(I)
   dz(I(i),J(i))=0;
end
figure(1)
clf
contour(east,north,dz,-10:10:60)
pause
newdem=dem-dz;
data=[0 east;north newdem];
save 'newdem.dat' data -ascii
err=browndem('no','new');
merr=sqrt(sum(err(:,3).^2)/length(err(:,3)));
disp(['Sampling rate          ' num2str(rate)]);
disp(['mean error (DEM - GPS) ' num2str(merr)]);