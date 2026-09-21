%script to calculate the flux on Brown Glacier

data=chkload('brownmod.dat');
xm=[data(:,1);4550];
zm=[data(:,2);76];
hm=[data(:,3);0];
wm=[data(:,4);0];
bm=zm-hm;
vb=[22.2650
   17.1550
   27.7400
   29.2000
   29.9300
   34.6750
   45.6250
   57.6700
   63.8750
   56.5750];

% various parameters

g=9.81;
rho=900;
A=.1;
enhm=[1;1;1;1;1;1.2;1.9;4.8;8;8;8];
dx=300;

% interpolating "data" to grid

x=0:dx:xm(length(xm));
x=x';
z=interp1(xm,zm,x,'spline');
W=interp1(xm,wm,x,'spline');
b=interp1(xm,bm,x,'spline');
enh=interp1(xm,enhm,x,'spline');
h=z-b;
sh=W/2./sqrt(h);
n=length(x);
sh(n)=sh(n-1);
I=max(find(h>0));

Lm=[ones(3,1); 2*ones(2,1); 3*ones(n-5,1)];


% calculate local slope
   
alpha=atan(([z(1);z(1);z(1:(n-2))]-[z(3:n);z(n);z(n)])./ ...
   ([x(3:n);x(n);x(n)]-[x(1);x(1);x(1:(n-2))]));
%alpha=gauss(alpha,4);
         
% calculate local shear stress
      
w=sh.*sqrt(h);
f=zeros(n,1);
f(1:I)=(1-exp(-.4446*w(1:I)./h(1:I)));
f((I+1):n)=f(I)*ones((n-I),1);
uloc=A/2*enh.*(rho*g*f.*h.*sin(alpha)*1e-5).^3.*h;

% calculate averaged shear stress
      
Lp=[3*ones(I-5,1); 2*ones(2,1); ones(n-I+3,1)];
lm=Lm.*h; 
lp=Lp.*h;
v=zeros(n,1);
for i=1:I
   int=sum(exp(-abs(x(1:i)-x(i))/lm(i)).*log(uloc(1:i)));
  	s1=sum(exp(-abs(x(1:i)-x(i))/lm(i)));
   int=int+sum(exp(-abs(x(i+1:n)-x(i))/lp(i)).*log(uloc(i+1:n)));
   s2=sum(exp(-abs(x(i+1:n)-x(i))/lp(i)));
  	v(i)=exp(int/(s1+s2));
end
   
% calculate ice flux
   
q=.933333*v.*sh.*sqrt(h.^3);				%4/3*.7*....

% calculate thickness change
   
dh=zeros(n,1);
dh(1:I)=diff([0;q(1:I)])./(2*dx*w(1:I));

% calculate errors

ddh=2*(.15*q./(2*w*dx)).^2;

% make a nice plot

figure(1)
clf
l1=line(x,z);
ax1=gca;
xlabel('Distance along flowline (m)');
ylabel('Elevation (m a.s.l.)');
set(ax1,'XColor','b','YColor','b');
l2=line(xm,zm,'Marker','+','LineStyle','none','Parent',ax1);
ax2=axes('Position',get(ax1,'Position'),'XAxisLocation','top','YAxisLocation','right', ...
   'Color','none','XColor','r','YColor','r');
xlabel('- Flux Divergence (m a^{-1})');
l3=line(dh.*cos(alpha),z,'Marker','+','Color','r','Parent',ax2);
l4=line([0 0],[0 1200],'Color','k','Parent',ax2);
l5=line(dh+ddh,z,'Color','y','Parent',ax2);
l6=line(dh-ddh,z,'Color','y','Parent',ax2);

% mass balance guess

zbal=0:100:1200;
bbal=.009*(zbal-600);
l7=line(bbal,zbal,'Color','k','LineStyle',':','Parent',ax2);