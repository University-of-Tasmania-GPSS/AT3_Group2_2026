%script to calculate the future off Brown Glacier

data=chkload('Brownfor.dat');
xm=[data(:,1)];
zm=[data(:,2)];
hm=[data(:,3)];
wm=[data(:,4)];
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
enhm=[1;1;1;1;1.2;1.3;2.5;5.5;7.5;8;8;8;8;8];
dx=20;
time=500;
dt=1/time;
ze=650;
G=.017;

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
I=min(find(h<=0));
sh((I+1):n)=sh(I)*ones(n-I,1);
h((I+1):n)=zeros(n-I,1);

Lm=[ones(3,1); 2*ones(2,1); 3*ones(n-5,1)];
go=1;
year=1;
clear vol

while go
   
   Lp=[3*ones(I-5,1); 2*ones(2,1); ones(n-I+3,1)];

	for t=1:time
   
		% calculate local slope
   
		alpha=atan(([z(1);z(1);z(1:(n-2))]-[z(3:n);z(n);z(n)])./ ...
   		([x(3:n);x(n);x(n)]-[x(1);x(1);x(1:(n-2))]));
		alpha=gauss(alpha,4);
         
      % calculate local shear stress
      
      I=max(find(h>0));
		w=sh.*sqrt(h);
		f=zeros(n,1);
		f(1:I)=(1-exp(-.4446*w(1:I)./h(1:I)));
		f((I+1):n)=f(I)*ones((n-I),1);
		Tbloc=rho*g*f.*h.*sin(alpha);
	
		% calculate averaged shear stress
      
		Lp=[3*ones(I-5,1); 2*ones(2,1); ones(n-I+3,1)];
		lm=Lm.*h; 
		lp=Lp.*h;
		Tb=zeros(n,1);
		for i=1:I
   		int=sum(exp(-abs(x(1:i)-x(i))/lm(i)).*Tbloc(1:i));
	  		s1=sum(exp(-abs(x(1:i)-x(i))/lm(i)));
	   	int=int+sum(exp(-abs(x(i+1:n)-x(i))/lp(i)).*Tbloc(i+1:n));
		   s2=sum(exp(-abs(x(i+1:n)-x(i))/lp(i)));
  			Tb(i)=int/(s1+s2);
		end
   
		% calculate ice flux
   
		v=A/2*enh.*(Tb/1e5).^3.*h;
		q=.933333*v.*sh.*sqrt(h.^3)*dt;				%4/3*.7*....

		% calculate thickness change
   
		dh=zeros(n,1);
		dh(1:I)=-diff([0;q(1:I)])./(2*dx*w(1:I));
		dh(I+1)=q(I)/(dx*10);
		h=h+dh(1:n);
      z=b+h; 
      
      % calculate accumulation/ablation
   
   	a=G*(z-ze)./cos(alpha)*dt;
	   znew=z+a;
   	ind=find(znew<b);
	   znew(ind)=b(ind);
   	z=znew;
	   h=z-b;

   end
   
   term(year)=I;
   vol(year)=4/3*sum(sh.*sqrt(h.^3)*dx);
   
   if year>2
      if abs((vol(year)-vol(year-1))/vol(year)) < 1e-8
         break
      end
   end
   
   disp(['Year ' num2str(year) ', terminus ', num2str(term(year))])
   
   year=year+1;
   
   % plot new glacier surface
   
%   if (yr/10-floor(yr/10))==0
      figure(1)
      plot(x,z,'r')
      hold on
      plot(x,b)
      title(['year ' num2str(year)]);
      plot([x(1) x(n)],[ze ze],'g')
      hold off
      pause(.1)
%   end

end

dong
