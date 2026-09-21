function circle(xc,yc,r,c);

% CIRCLE draws a circle
%	circle(xc,yc,r,c) draws a circle with center (xc,yc) and radius r in the current 
%	figure. c is an optional argument specifying color.
%
%	Martin Truffer, Dec 2000

if nargin==3
   c='b';
end
current=ishold;
hold on
x=linspace(xc-r,xc+r,10);
yp=yc+sqrt(r^2-(x-xc).^2);
ym=yc-sqrt(r^2-(x-xc).^2);
warning off
plot(x,yp,c)
plot(x,ym,c)
warning on
if ~current
   hold off
end

