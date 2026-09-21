function res(file,p)

% RES reduces radio echo sounding data
%	RES(file,step) reduces the data stored in file.dat, which is set up as follows:
%	xt1  yt1 zt1  xr1 yr1 zr1  t11  t12  t13
%	xt2  yt2 zt2  xr2 yr2 zr2  t21  t22  t23
%	 :   :    :   :    :    :  :    :    :
%	x,y,z are coordinates (xt is transmitter and xr receiver, or vice versa), and 
%	t is the two-way travel time. If only one return is measured zeros should be 
%	substituted for t2 and t3. A straight line is fitted to (x,y) and the return 
%	ellipses are plotted. The function saves file.res, a file containing the center
%	points projected onto a straight line, elevation, and major and minor semi-axis 
%	for each return.
%	The first two lines can optionally contain the position of the glacier margin
%	followed by zeros.
%	p is an optional parameter. If set to 1, it will pause after drawing each return.
%
%	see also DRWELIP, FITLINE
%
%	Martin Truffer, Sep 2000


c=300;
v=168;			% velocity of light in ice (m/us)
clrs=['y','m','c','r','g','b','k'];

if nargin==2
   if p~=1
      p=0;
   end
else
   p=0;
end

fn=length(file);
if file(fn-3)~='.'
   file=[file '.dat'];
end
fn=length(file);

[fid,message] = fopen(file, 'r');
if fid == -1
   error([file ': ' message]);
end
status=fclose(fid);

fdir=which(file);
fnd=length(fdir);
fdir=fdir(1:fnd-fn);
data=load(file);

[n m]=size(data);
if m~=9
   if n==9
      data=data';
   else
      error(['Incorrect data file, see "help RES" for setup of ' file]);
   end
end

% fitting a straight line to the antenna positions

xt=data(:,1);
yt=data(:,2);
xr=data(:,4);
yr=data(:,5);
x=[xt;xr];
y=[yt;yr];
[m,in,xf,yf]=fitline(x,y);
xft=xf(1:n);
yft=yf(1:n);
xfr=xf(n+1:2*n);
yfr=yf(n+1:2*n);
figure(1)
clf
plot(x,y,'rx');
hold on
plot(xf,yf);
plot(xf,yf,'c+');
axis('equal')
hold off
xx=sqrt((xf-xf(1)).^2+(yf-yf(1)).^2);   %  distance along profile
xxt=xx(1:n);
xxr=xx(n+1:2*n);

zt=data(:,3);
zr=data(:,6);
t=data(:,7:9);

% find how many returns were recorded

ind=zeros(1,n);
for i=1:n
   if isempty(max(find(t(i,:))))
      ind(i)=0;
   else
      ind(i)=max(find(t(i,:)));
   end
end

a=zeros(n,3);				% major half-axis for each return
b=zeros(n,3);				% minor half-axis for each return
figure(2)
clf
fn=length(file);
title([upper(file(1:fn-4)) ' profile']);
xlabel('Length along profile (m)');
ylabel('Elevation (m)');
hold on
axis('equal')

% Display the glacier margins

if ind(1)==0
   plot(xxt(1),zt(1),'kd');
end
if ind(2)==0
   plot(xxt(2),zt(2),'kd');
end

% Draw the returns

for i=1:n
   x1=xxt(i);
   y1=zt(i);
   x2=xxr(i);
   y2=zr(i);
   clr=mod(i,7);
   for j=1:ind(i)      
      d=sqrt((x2-x1)^2+(y2-y1)^2);
      tt=t(i,j)+d/c;		% two-way travel time corrected for the airwave
      a(i,j)=0.5*tt*v;
      b(i,j)=0.5*sqrt((tt*v)^2-d^2);
      drwelip(x1,y1,x2,y2,a(i,j),b(i,j),clrs(clr+1));
   end
   if p
      pause
   end
end
axis('equal')

% save file

xc=(xxr+xxt)/2;
zc=(zr+zt)/2;
dataout=[xc zc a b];
fn=length(file);
file=[file(1:fn-4) '.res'];
cdir=pwd;
cd(fdir);
eval(['save ' file ' dataout -ascii']);
cd(cdir);

pause

% display the bottom if a file ...bottom.dat exists

file=[file(1:fn-4) 'bottom.dat'];
bottom=chkload(file);
if ~isempty(bottom)
   plot(bottom(:,1),bottom(:,2),'k','LineWidth',2)
end
