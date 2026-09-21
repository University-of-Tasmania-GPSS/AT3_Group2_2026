% script to adjust the Brown DEM to the GPS profiles

err=browndem('go');
x=err(:,1);
y=err(:,2);
z=err(:,3);

u=linspace(min(x),max(x),50);
v=linspace(min(y),max(y),50);
[XI,YI] = meshgrid(u,v);
ZI = griddata(x,y,z,XI,YI);

[n,m]=size(err);
errsq(1)=sqrt(sum(err(:,3).^2)/n);

figure(3)
cs=contour(XI,YI,ZI);
clabel(cs);
%plot3(x,y,z,'o'); hold off
title(['original data, E^2 = ' num2str(errsq(1))]);
pause

% 0th order

err0=err(:,3)-sum(err(:,3))/n;
errsq(2)=sqrt(sum(err0.^2)/n);
ZI = griddata(x,y,err0,XI,YI);
cs=contour(XI,YI,ZI);
clabel(cs);
%plot3(x,y,err0,'o'); hold off
title(['0th order, E^2 = ' num2str(errsq(2))])
pause

% 1st order

sumx=sum(x);
sumx2=sum(x.^2);
sumxy=sum(x.*y);
sumxz=sum(x.*z);
sumy=sum(y);
sumy2=sum(y.^2);
sumyz=sum(y.*z);
sumz=sum(z);
A=[sumx2 sumxy sumx; sumxy sumy2 sumy; sumx sumy 1];
b=[sumxz;sumyz;sumz];
col=A\b;
err1=z-col(1)*x-col(2)*y-col(3);
errsq(3)=sqrt(sum(err1.^2)/n);
ZI = griddata(x,y,err1,XI,YI);
cs=contour(XI,YI,ZI);
clabel(cs);
%plot3(x,y,err1,'o'); hold off
title(['1th order, E^2 = ' num2str(errsq(3))])
pause

% 2nd bloody order

sumx4=sum(x.^4);
sumx3y=sum(x.^3.*y);
sumx2y2=sum(x.^2.*y.^2);
sumx3=sum(x.^3);
sumx2y=sum(x.^2.*y);
sumx2z=sum(x.^2.*z);

sumxy3=sum(x.*y.^3);
sumxy2=sum(x.*y.^2);
sumxyz=sum(x.*y.*z);

sumy4=sum(y.^4);
sumy3=sum(y.^3);
sumy2z=sum(y.^2.*z);

A=[sumx4   sumx3y  sumx2y2 sumx3   sumx2y  sumx2;
   sumx3y  sumx2y2 sumxy3  sumx2y  sumxy2  sumxy;
   sumx2y2 sumxy3  sumy4   sumxy2  sumy3   sumy2;
   sumx3   sumx2y  sumxy2  sumx2   sumxy   sumx ;
   sumx2y  sumxy2  sumy3   sumxy   sumy2   sumy ;
   sumx2   sumxy   sumy2   sumx    sumy    1    ];
   
b=[sumx2z; sumxyz; sumy2z; sumxz; sumyz; sumz];
   
co=A\b;
   
err2=z-co(1)*x.^2-co(2)*x.*y-co(3)*y.^2-co(4).*x-co(5).*y-co(6);
errsq(4)=sqrt(sum(err2.^2)/n);

errsq