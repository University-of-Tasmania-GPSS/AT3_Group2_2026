z=load('dem.dat');
[n m]=size(z);
eastll=382275;
northll=4104775;
dx=50;

east=(1:m)*dx+eastll;
north=(1:n)*dx+northll;
z=flipdim(z,1);

figure(1)
mesh(east,north,z)
hold on
plot3(411215.7,4117926.3,28.1,'or')
axis('equal')

go=1;

while go
   l=input('Do you want to crop the dem?','s');
   if ~or(l=='y', l=='Y')
      go=0;
   else
      xl=input('Lower Easting-coord  (6 digit coord) ');
	   xu=input('Upper Easting-coord                  ');
   	yl=input('Lower Northing-coord (7 digit coord) ');
      yu=input('Upper Northing-coord                 ');
      [da, xlind]=min(abs(east-xl));
      [da, xuind]=min(abs(east-xu));
      [da, ylind]=min(abs(north-yl));
      [da, yuind]=min(abs(north-yu));
      xnew=east(xlind:xuind);
      ynew=north(ylind:yuind);
      znew=z(ylind:yuind,xlind:xuind);
      clear east north z
      east=xnew;
      north=ynew;
      z=znew;
      figure(1)
      hold off
      mesh(east,north,z);
      hold on
      plot3(411215.7,4117926.3,28.1,'or')
      axis('equal')
   end
end
