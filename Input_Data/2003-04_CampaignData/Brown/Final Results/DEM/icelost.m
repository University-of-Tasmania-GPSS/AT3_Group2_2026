function dV=icelost;

% ICELOST determines the amount of ice lost on Brown Glacier since 1947
%	dV = icelost interpolates a surface between the lagoon seaward shore, the moraine
%	crests, and the BG35 (bob) profile, and then calculates the difference to the 
%	present day (2000) surface. The figures show contours of the interpolated surface
%	and the differences.
%
%	Martin Truffer, March 2001

sample=7;

Emor1=load('Emor1.prof');
Emor2=load('Emor2.prof');
wmor=load('wmor.prof');
bob=load('bob.prof');
lagoon=load('lagoon2.prof');

x=[Emor1(:,1); Emor2(:,1); bob(1:310,1); flipdim(wmor(:,1),1); lagoon(1:237,1)];
y=[Emor1(:,2); Emor2(:,2); flipdim(bob(1:310,2),1); flipdim(wmor(:,2),1); lagoon(1:237,2)];
z=[Emor1(:,3); Emor2(:,3); flipdim(bob(1:310,3),1); flipdim(wmor(:,3),1); lagoon(1:237,3)];
z=z-40;

ind=1:sample:length(x);
xs=x(ind);
ys=y(ind);
zs=z(ind);

xi=linspace(min(x),max(x),200);
yi=linspace(min(y),max(y),200);

[X,Y]=meshgrid(xi,yi);
Z=griddata(xs,ys,zs,X,Y,'cubic');
figure(1)
hold off
cs=contour(X,Y,Z);
clabel(cs)
hold on

data=load('newdem.dat');
[n m]=size(data);
east=data(1,2:m);
north=data(2:n,1);
dem=data(2:n,2:m);

[I J]=find(isnan(Z)==1);
for i=1:length(I)
   plot(X(I(i),J(i)),Y(I(i),J(i)),'+')
end

Zold=griddata(X,Y,Z,east,north,'cubic');
[I J]=find(isnan(Zold)==1);
figure(2)
hold on
dx=50;
for i=1:length(I)
   Zold(I(i),J(i))=dem(I(i),J(i));
   plot(east(J(i)),north(I(i)),'+')
end
cs2=contour(east,north,Zold-dem);
clabel(cs2);

outl=load('oldglacier.dat');
plot(outl(:,1),outl(:,2),'r')
plot(x,y,'m')
axis([408100 411300 4117350 4119250])
hold off

figure(1)
plot(outl(:,1),outl(:,2),'r')
plot(x,y,'m')
axis([408100 411300 4117350 4119250])
hold off
dV=sum(sum(dem-Zold))*dx^2

