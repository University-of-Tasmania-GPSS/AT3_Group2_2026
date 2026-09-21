function drwelip(x1,y1,x2,y2,a,b,clr);

% DRWELIP draws the negative branch of a tilted elipse
%	drwelip(x1,y1,x2,y2,a,b,clr) draws an ellipse with focii (x1,y1) and (x2,y2) and 
%	major and minor half-axis a and b. clr is an optional character specifying the 
%	color of the plot.
%
%	Martin Truffer, Sep 2000

theta=atan((y2-y1)/(x2-x1));
R=[cos(theta), sin(theta); -sin(theta), cos(theta)];
xc=[(x1+x2)/2;(y1+y2)/2];
xcp=R*xc;
step=a/50;
xp(1,:)=xcp(1)-a+step:step:xcp(1)+a-step;
xp(2,:)=xcp(2)-b*sqrt(1-((xp(1,:)-xcp(1))/a).^2);
[m,n]=size(xp);
x=zeros(2,n);
Rt=[cos(theta), -sin(theta); sin(theta), cos(theta)];
for i=1:n
   x(:,i)=Rt*xp(:,i);
end

plot(x(1,:),x(2,:),clr)
plot(xc(1), xc(2), [clr '+'])