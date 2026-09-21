data=load('termdec.txt');
x=(data(:,2)-73.67459832)*60*1875*cos(53.08073829/180*pi);
y=-(data(:,1)-53.08073829)*60*1875;
z=data(:,3);
x=[x;-1800;-2000;-2200;-2400;-2600];
y=[y;  500;  500;  500;  500;  500];
z=[z;  NaN;  NaN;  NaN;  NaN;  NaN];
figure(1)
clf
xlin=linspace(min(x),max(x),100);
ylin=linspace(min(y),max(y),100);
[X,Y] = meshgrid(xlin,ylin);
Z = griddata(x,y,z,X,Y,'cubic');
surf(X,Y,Z)
hold on
plot3(x,y,z,'LineWidth',1.5)
view(141.5,48)
contour3(X,Y,Z,[100,150,200,250,300,350,400,450,500,550,600,650])
h = findobj('Type','patch');
set(h,'LineWidth',4)