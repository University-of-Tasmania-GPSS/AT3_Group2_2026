function a=areasize(x,y);

% AREASIZE calculates the area in a polygon
%	a=areasize(x,y) calculates the area enclosed in a polygon described by the 
%	vectors x,y.
%
%	Martin Truffer, February 2001

if length(x)~=length(y)
   error('Vectors need to be of same length')
end

n=length(x);
if or(x(1)~=x(n),y(1)~=y(n))
   x(n+1)=x(1);
   y(n+1)=y(1);
end

x=x-x(1);
y=y-y(1);

a=abs(0.5*sum(x(1:(n-1)).*y(2:n)-x(2:n).*y(1:(n-1))));