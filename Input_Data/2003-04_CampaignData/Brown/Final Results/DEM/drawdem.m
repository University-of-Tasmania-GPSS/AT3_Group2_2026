function drawdem(ci,specs)

% DRAWDEM displays the Brown Glacier part of the Heard Island DEM
%	drawdem(ci,specs) draws a DEM derived from Radarsat images (as obtained from the AAD)
%	and corrected using kinematic GPS profiles. ci is the contour interval and specs is
%	a string specifying drawing options that can be combined:
%		'o'		draw the original (uncorrected) DEM
%		'b'		draw glacier borders
%		'f'		draw the 1947 glacier borders
%		'p'		draw profiles
%		'd'		draw the difference between GPS profiles and DEM in separate figure
%		's'		draw a surface (mesh) plot (contour plot is standard)
%
%	Martin Truffer, March 2001

orig=0;
b=0;
f=0;
p=0;
d=0;
s=0;

if nargin==2
   if ismember('o',specs)
      orig=1;
   end
   if ismember('b',specs)
      b=1;
   end
   if ismember('f',specs)
      f=1;
   end
   if ismember('p',specs)
      p=1;
   end
   if ismember('d',specs)
      d=1;
   end
   if ismember('s',specs)
      s=1;
   end
end

if orig
   data=load('brownarea.dat');
else
   data=load('newdem.dat');
end

[n m]=size(data);
east=data(1,2:m)-4e5;
north=data(2:n,1)-4.1e6;
z=data(2:n,2:m);

% setting figure properties

f1=figure(1);
set(f1,'Position',[ 1 30 1280 925 ]);
clf

if d
   f2=figure(2);
   set(f2,'Position',[ 602 746 678 206 ]);
end

% draw the map

figure(1)
hold on
v=0:ci:1500;
v100=100:100:1500;
if s
   mesh(east,north,z);
	set(gca,'CameraPosition',[44158.688973386 31629.64227491 12795.4792295911]);
   [cs,g]=contour3(east,north,z,v);
	[cs100,h]=contour3(east,north,z,v100);
else
   [cs,g]=contour(east,north,z,v);
	[cs100,h]=contour(east,north,z,v100);
end

xlabel('Easting (4----- m)');
ylabel('Northing (41----- m)');
axis('equal')
set(h,'LineWidth',1.5);
set(g,'LineWidth',0.5);
clabel(cs100,h,'FontAngle','italic');

% plot the points

if or(p,d)
	points=chkload('brownpoints.dat');
	ept=points(:,1)-4e5;
	npt=points(:,2)-4.1e6;
   zpt=points(:,3)-40;
   if s
      plot3(ept,npt,zpt,'ro','MarkerFaceColor','r','MarkerSize',3,'EraseMode','none');
   else
      plot(ept,npt,'ro','MarkerFaceColor','r','MarkerSize',3,'EraseMode','none');
   end
end

% plot the glacier outline

if b
   outl=chkload('outline.dat');
   xout=outl(:,1)-4e5;
   yout=outl(:,2)-4.1e6;
   figure(1)
   if s
      zout=interp2(east,north,z,xout,yout);
      plot3(xout,yout,zout,'k','EraseMode','none','LineWidth',1.5);
   else
      plot(xout,yout,'k','LineWidth',1.5);
   end
end

if f
   outl=chkload('oldglacier.dat');
   xout=outl(:,1)-4e5;
   yout=outl(:,2)-4.1e6;
   figure(1)
   if s
      zout=interp2(east,north,z,xout,yout);
      plot3(xout,yout,zout,'EraseMode','none','LineWidth',1.5);
   else
      plot(xout,yout,'LineWidth',1.5);
   end
end

% calculate the elevation difference to the DEM

if d
   zint=interp2(east,north,z,ept,npt);
	figure(2);
	plot(zint-zpt);
	ylabel('DEM minus GPS (m)');
   pause
end

% plot the profiles

if or(p,d)
   direc=dir('c:\Documents and Settings\All Users\Desktop\Browns\Final Results\DEM\*.prof');
   [l m]=size(direc);
   err=[];
   for i=1:l
   	fname{i}=getfield(direc(i),'name');
	   prof=load(char(fname(i)));
   	profe=prof(:,1)-4e5;
	   profn=prof(:,2)-4.1e6;
   	profz=prof(:,3)-40;
	   figure(1)
      if s
         plot3(profe,profn,profz,'y','LineWidth',1.5,'EraseMode','none');
      else
         plot(profe,profn,'y','EraseMode','none');
      end
      dz=interp2(east,north,z,profe,profn)-profz;
      if d
         figure(2)
		   plot(dz)
		   pos=axis;
		   ypos=pos(3)+.9*(pos(4)-pos(3));
		   text(10,ypos,fname{i})
		   ylabel('DEM minus GPS (m)')
	      pause
      end
      figure(1)
      if s
         plot3(profe,profn,profz,'r','LineWidth',1.5,'EraseMode','none');
      else
         plot(profe,profn,'r','EraseMode','none');
      end
      err=[err;dz];
   end
   merr=sum(abs(err))/length(err);
   disp(['Mean difference between GPS profiles and DEM: ' num2str(merr) ' m']);
end

% draw a scale bar
if ~s
   plot([10500 11500], [20600 20600], 'k', 'LineWidth', 3);
	plot([11000 11490], [20605 20605], 'w', 'LineWidth', 1.5);
	text(10470,20500,'0');
	text(10920,20500,'0.5');
   text(11470,20500,'1  km');
end

hold off