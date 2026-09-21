function [X,Y,Z]=lagoon

% LAGOON reduces bathymetry data
%	[X,Y,Z]=lagoon interpolates the data in bathy.txt (lagoon depths) and shore.txt
%	(shore line) and returns interpolated data.
%
%	Martin Truffer, March 2001

data=load('bathy.txt');
x=data(:,1);
y=data(:,2);
z=-data(:,3);
shore=load('shore.txt');
xs=shore(:,1);
ys=shore(:,2);
zs=zeros(size(xs));
n=length(x);
%	add some zeros along eastern shore
xe=[4.105; 4.107; 4.108]*1e5;
ye=[4118410; 4118415; 4118430];
ze=[0;0;0];

x=[x;xs;xe];
y=[y;ys;ye];
z=[z;zs;ze];
figure(1)
clf
xlin=linspace(min(x),max(x),50);
ylin=linspace(min(y),max(y),50);
[X,Y] = meshgrid(xlin,ylin);
Z = griddata(x,y,z,X,Y,'cubic');

%surf(X,Y,Z)
%hold on
%plot3(x,y,z,'go')
%h = findobj(gca,'Type','line')
%set(h,'MarkerFaceColor','g')
%contour3(X,Y,Z,[-50,-40,-30,-20,-10,0])
%h = findobj('Type','patch');
%set(h,'LineWidth',4)

cl=-50:10:-10;
cs=contour(X,Y,Z,cl);
clabel(cs);
axis('equal')
hold on
plot(x(1:n),y(1:n),'go','MarkerFaceColor','g');
plot(xs,ys,'.')