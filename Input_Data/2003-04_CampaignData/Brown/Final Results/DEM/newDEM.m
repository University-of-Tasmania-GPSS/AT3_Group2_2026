% create a 25m DEM out of the existing 50m DEM and our GPS profiles

% set parameters

h=1000;
hw=100;

% loading the DEM

data=load('brownarea.dat');
[n m]=size(data);
east=data(1,2:m);
north=data(2:n,1);
dem=data(2:n,2:m);
n=n-1;
m=m-1;

% correcting the DEM by a quadratic approximation to the GPS data (see adjustDEM)

%co=[2.5539e-006 -9.6115e-006 9.2694e-007 37.4868 -3.7129 -9.5163e-008];
%dem=dem-co(1)*ones(n,1)*east.^2+co(2)*(ones(n,1)*east).*(north*ones(1,m))- ...
%   co(3)*north.^2*ones(1,m)-co(4)*ones(n,1)*east-co(5)*north*ones(1,m)-co(6)*ones(n,m);
col=[-.0063551 6.3592e-004 -4.3150e-004];
dem=dem-col(1)*ones(n,1)*east-col(2)*north*ones(1,m)-col(3);

% load profiles

data=load('allprof.dat');
x=data(:,1);
y=data(:,2);
z=data(:,3);
pn=length(z);

% creating the DEM

xn=east(1):50:east(m);
yn=north(1):50:north(n);

mm=length(xn);
nn=length(yn);
elev=zeros(nn,mm);

for i=1:nn
   for j=1:mm
      
      % determine distance to original DEM points
      
      dist=sqrt(ones(n,1)*(east-xn(j)).^2+(north-yn(i)).^2*ones(1,m));
      [ni mj]=find(dist<h);
      f=length(ni);
      znew=0;
      for k=1:f
         w(k)=exp(-(dist(ni(k),mj(k))/hw)^2)/30;
         znew=znew+w(k)*dem(ni(k),mj(k));
      end
      
      % determine distance to GPS points
      
      distGPS=sqrt((x-xn(j)).^2+(y-yn(i)).^2);
      nGPS=find(distGPS<h);
      wGPS=exp(-(distGPS(nGPS)/hw).^2)*2;
      znew=znew+sum(wGPS.*z(nGPS));
      
      elev(i,j)=znew/(sum(w)+sum(wGPS));
   end
end

data=[0 xn; yn' elev];
save 'newdem.dat' data -ascii
