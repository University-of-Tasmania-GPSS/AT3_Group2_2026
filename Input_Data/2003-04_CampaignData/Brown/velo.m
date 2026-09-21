data=load('velo.txt');
base=data(1,1:3);
poles=data(2:20,:);
x=(poles(:,2)-base(2))*60*1875*cos(base(1)/180*pi);
y=-(poles(:,1)-base(1))*60*1875;
figure(1)
clf
plot(x,y,'rx')
axis('equal')
hold on
plot(0,0,'ro')
title('Brown Glacier velocities');
xlabel('Easting');
ylabel('Northing');

v1=poles(:,6);
az1=poles(:,8)*pi/180;
vx1=v1.*sin(az1);
vy1=v1.*cos(az1);
err1=poles(:,9);
scale=2000;
for i=1:14
   plot([x(i),x(i)+scale*vx1(i)],[y(i),y(i)+scale*vy1(i)]);
   circle(x(i)+scale*vx1(i),y(i)+scale*vy1(i),scale*err1(i));
end
plot([-2000,-2000+scale*.1],[-2000,-2000]);
text(-2000,-2300,'10 cm/d')

pause

v2=poles(:,12);
az2=poles(:,14)*pi/180;
vx2=v2.*sin(az2);
vy2=v2.*cos(az2);
err2=poles(:,15);
for i=1:19
   plot([x(i),x(i)+scale*vx2(i)],[y(i),y(i)+scale*vy2(i)],'g');
   circle(x(i)+scale*vx2(i),y(i)+scale*vy2(i),scale*err2(i),'g');
end

pause

vlong=sqrt(vx2(1:10).^2+vy2(1:10).^2);
xlong=[0; cumsum(sqrt((diff(x(1:10))).^2+(diff(y(1:10))).^2))];
figure(2)
clf
plot(xlong,vlong);
title('Longitudinal velocity profile');
xlabel('Distance (m)')
ylabel('Velocity (md^{-1})')

pause

vtx1=[vx2(11:12); vx2(8); vx2(13:14)];
vty1=[vy2(11:12); vy2(8); vy2(13:14)];
vt1=sqrt(vtx1.^2+vty1.^2);
xt1=[x(11:12); x(8); x(13:14)];
yt1=[y(11:12); y(8); y(13:14)];
xtr1=[0; cumsum(sqrt((diff(xt1)).^2+(diff(yt1)).^2))];

vtx2=[vx2(15:17); vx2(7); vx2(18:19)];
vty2=[vy2(15:17); vy2(7); vy2(18:19)];
vt2=sqrt(vtx2.^2+vty2.^2);
xt2=[x(15:17); x(7); x(18:19)];
yt2=[y(15:17); y(7); y(18:19)];
xtr2=[0; cumsum(sqrt((diff(xt2)).^2+(diff(yt2)).^2))];

figure(3)
plot(xtr1,vt1,xtr2,vt2)
hold on
legend('BG40', 'BG35')
title('Transverse velocity profile')
xlabel('Distance (m)')
ylabel('Velocity (md^{-1})')
hold off