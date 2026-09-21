function err=browndem(go,old)

% BROWNDEM displays the Brown Glacier part of the Heard Island DEM
%	err=browndem(go,new) plots the DEM stored in brownarea.dat and all the points in 
%	brownpoints.dat and the profiles in brownprof.dat. It returns an array
%	showing DEM minus GPS values.
%	If go='go' the program does not pause between profiles. If new='new' it loads
%	newdem.dat, otherwise it loads brownarea.dat
%
%	M. Truffer, February 2001

p=1;
if or(nargin==1,nargin==2)
   if go=='go'
      p=0;
   end
end

ol=1;
if nargin==2
   if old=='new'
      ol=0;
   end
end

if ol
   data=load('brownarea.dat');
else
   data=load('newdem.dat');
end

[n m]=size(data);
east=data(1,2:m);
north=data(2:n,1);				% values calculated in shiftDEM
z=data(2:n,2:m);

% setting figure properties

f1=figure(1);
set(f1,'Position',[ 1 30 1280 925 ]);
clf
f2=figure(2);
set(f2,'Position',[ 602 746 678 206 ]);
figure(1)
v=0:20:1500;
cs=contour(east,north,z,v);
xlabel('Easting');
ylabel('Northing');
axis('equal')
hold on
v100=0:100:1500;
[cs100,h]=contour(east,north,z,v100);
set(h,'LineWidth',1.5);
clabel(cs100,h);

% plot the points

points=chkload('brownpoints.dat');
ept=points(:,1);
npt=points(:,2);
zpt=points(:,3)-40;
%	plot3(ept,npt,zpt,'ro','MarkerFaceColor','r','EraseMode','none');
plot(ept,npt,'ro','MarkerFaceColor','r','EraseMode','none');
%	set(gca,'CameraPosition',[ 444158.688973386 4131629.64227491 12795.4792295911 ]);

% calculate the elevation difference to the DEM

zint=interp2(east,north,z,ept,npt);
figure(2);
plot(zint-zpt);
ylabel('DEM minus GPS (m)');
if p==1
   pause
end

% plot the profiles

d=dir('c:\Documents and Settings\All Users\Desktop\Browns\Final Results\DEM\*.prof');
[l m]=size(d);
err=[];
allprof=[];
for i=1:l
   fname{i}=getfield(d(i),'name');
   prof=load(char(fname(i)));
   profe=prof(:,1);
   profn=prof(:,2);
   profz=prof(:,3)-40;
   figure(1)
   hold on
   %   plot3(profe,profn,profz,'m','LineWidth',2,'EraseMode','none');
   plot(profe,profn,'y','LineWidth',2,'EraseMode','none');
   dz=interp2(east,north,z,profe,profn)-profz;
   figure(2)
   plot(dz)
   pos=axis;
   ypos=pos(3)+.9*(pos(4)-pos(3));
   text(10,ypos,fname{i})
   ylabel('DEM minus GPS (m)')
   if p
      pause
   end
   figure(1)
   %   plot3(profe,profn,profz,'y','LineWidth',2,'EraseMode','none');
   plot(profe,profn,'m','LineWidth',2,'EraseMode','none');
   err=[err;profe,profn,dz];
   allprof=[allprof;profe,profn,profz];
end

hold off