% shiftDEM, script to find an optimal shift to the Brown DEM

data=load('allprof.dat');
x=data(:,1);
y=data(:,2);
z=data(:,3);
pn=length(z);

% loading the DEM

data=load('brownarea.dat');
[n m]=size(data);
east=data(1,2:m)-44;
north=data(2:n,1)-75;
dem=data(2:n,2:m);

for i=1:21
   eastnew=east-10+(i-1);
   ex(i)=sqrt(sum((interp2(eastnew,north,dem,x,y)-z).^2)/pn);
end

figure(2)
plot(ex)

pause

[da I]=min(ex);
eastn=east-10+(I-1);

for i=1:21
   northnew=north-10+(i-1);
   ex(i)=sqrt(sum((interp2(eastn,northnew,dem,x,y)-z).^2)/pn);
end

plot(ex)
pause

[da J]=min(ex);
northn=north-10+(J-1);