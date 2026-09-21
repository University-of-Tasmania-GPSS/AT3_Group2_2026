function index

% INDEX reduces the data in indexpoints.txt
%	This function is specific to the file indexpoints.txt that contains velocity 
%	data from the 2000 field season at Heard Island.

data=load('indexpoints.txt');
base=data(1,1:3)-[400000 4110000 0];
poles=data(2:58,:);
poles=reshape(poles',15,19);
poles=poles';
x1=poles(:,1)-400000; x2=poles(:,6)-400000; x3=poles(:,11)-400000;
y1=poles(:,2)-4110000; y2=poles(:,7)-4110000; y3=poles(:,12)-4110000;
z1=poles(:,3); z2=poles(:,8); z3=poles(:,13);
v1=poles(:,9); v2=poles(:,14);
err1=poles(:,10); err2=poles(:,15);

figure(1)
clf
plot(x2,y2,'rx')
axis('equal')
hold on
plot(base(1),base(2),'ro')
title('Brown Glacier velocities');
xlabel('Easting (40----)');
ylabel('Northing (411----)');

az1=atan((y2-y1)./(x2-x1));
vx1=v1.*cos(az1);
vy1=v1.*sin(az1);

scale=2500;
for i=1:19
   plot([x2(i),x2(i)+scale*vx1(i)],[y2(i),y2(i)+scale*vy1(i)],'LineWidth',1);
   circle(x2(i)+scale*vx1(i),y2(i)+scale*vy1(i),scale*err1(i));
end
plot([9000,9000+scale*.1],[6500,6500],'LineWidth',1);
text(9000,6600,'10 cm/d')

pause

az2=atan((y3-y2)./(x3-x2));
vx2=v2.*cos(az2);
vy2=v2.*sin(az2);

for i=1:19
   plot([x2(i),x2(i)+scale*vx2(i)],[y2(i),y2(i)+scale*vy2(i)],'g');
   circle(x2(i)+scale*vx2(i),y2(i)+scale*vy2(i),scale*err2(i),'g');
end

pause

xlong=[0; cumsum(sqrt((diff(x2(1:10))).^2+(diff(y2(1:10))).^2))];
figure(2)
clf
h=errorbar(xlong,v1(1:10),err1(1:10));
set(h,'LineWidth',1);
hold on
h=errorbar(xlong,v2(1:10),err2(1:10));
set(h,'Color','g','LineWidth',1,'Linestyle','--');
title('Longitudinal velocity profile');
xlabel('Distance (m)')
ylabel('Velocity (md^{-1})')
axis([0 4500 0 0.2]);

pause

% transverse profiles

% BG40 epoch 1
vtx0=[vx1(16:17); vx1(8); vx2(18:19)];
vty0=[vy1(16:17); vy1(8); vy2(18:19)];
vt0=sqrt(vtx0.^2+vty0.^2);
et0=[err1(16:17); err1(8); err1(18:19)];
xt0=[x2(16:17); x2(8); x2(18:19)];
yt0=[y2(16:17); y2(8); y2(18:19)];
xtr0=[0; cumsum(sqrt((diff(xt0)).^2+(diff(yt0)).^2))];
xtr0=xtr0(3)-xtr0;

% BG40 epoch 2
vtx1=[vx2(16:17); vx2(8); vx2(18:19)];
vty1=[vy2(16:17); vy2(8); vy2(18:19)];
vt1=sqrt(vtx1.^2+vty1.^2);
et1=[err2(16:17); err2(8); err2(18:19)];

% BOB epoch 2
vtx2=[vx2(11:13); vx2(7); vx2(14:15)];
vty2=[vy2(11:13); vy2(7); vy2(14:15)];
vt2=sqrt(vtx2.^2+vty2.^2);
et2=[err2(11:13); err2(7); err2(14:15)];
xt2=[x2(11:13); x2(7); x2(14:15)];
yt2=[y2(11:13); y2(7); y2(14:15)];
xtr2=[0; cumsum(sqrt((diff(xt2)).^2+(diff(yt2)).^2))];
xtr2=xtr2(4)-xtr2;

figure(3)
a0=errorbar(xtr0,vt0,et0);
set(a0,'Linestyle','--','LineWidth',1);
hold on
a=errorbar(xtr0,vt1,et1);
hold on
b=errorbar(xtr2,vt2,et2,et2,'r');
[lgnd,obj]=legend([a,b],'BG40','BG35');
set(obj(3),'color','r');
title('Transverse velocity profile')
xlabel('Distance (m)')
ylabel('Velocity (md^{-1})')
hold off