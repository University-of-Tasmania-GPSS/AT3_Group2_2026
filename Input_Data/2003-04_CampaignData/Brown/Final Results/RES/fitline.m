function [a,b,xf,yf]=fitline(x,y)

% FITLINE fits a straight line to data point
%	[a,b,xf,yf] = fitline(x,y) fits a line to (x,y) and returns the best fit slope a and 
%	y-intercept b. The line is fitted in a least distance sense, i.e. it is the 
%	distance to the line that is minimized, and not the difference in y-coordinates.
%  (xf,yf) are optional and are the points on the best fit line closest to data points.
%
%	Martin Truffer, Sep 2000


if length(x)~=length(y)
   error('x and y need to be of equal length');
end
[n,m]=size(x);
if n==1
   x=x';
end
[n,m]=size(y);
if n==1
   y=y';
end
n=length(x);

if diff(y)==zeros(n-1,1)
   a=0;
   b=y(1);
   if nargout==4
      xf=x;
      yf=y;
   end
else
   mx=mean(x);
	my=mean(y);
	mx2=mean(x.^2);
	my2=mean(y.^2);
	mxy=mean(x.*y);

	B=(mx2-my2-mx^2+my^2)/(mxy-mx*my);
	a1=-B/2+sqrt((B/2)^2+1);
	a2=-B/2-sqrt((B/2)^2+1);
	b1=my-a1*mx;
	b2=my-a2*mx;

	d1=sum((-a1^2*x+a1*y-a1*b1*ones(n,1)).^2+(a1*x-y+b1*ones(n,1)).^2)/(1+a1^2)^2;
	d2=sum((-a2^2*x+a2*y-a2*b2*ones(n,1)).^2+(a2*x-y+b2*ones(n,1)).^2)/(1+a2^2)^2;

	if d1>d2
   	a=a2;
	   b=b2;
	else
   	a=a1;
	   b=b1;
	end

	if nargout==4
   	xf=(x+a*y-a*b*ones(n,1))/(1+a^2);
	   yf=(a*x+a^2*y+b*ones(n,1))/(1+a^2);
   end
end
