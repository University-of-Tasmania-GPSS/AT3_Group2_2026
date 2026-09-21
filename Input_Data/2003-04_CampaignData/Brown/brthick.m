function h=brthick;

%script to calculate ice thickness from velocity data

data=chkload('brown.dat');
x=[data(:,1)];
z=[data(:,2)];
h=[data(:,3)];
w=[data(:,4)];
b=z-h;
n=length(x);
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
enh=[1;1;1;1;1;1;1;2;5;6];

% various parameters

g=9.81;
rho=900;
A=.1;

% calculate local slope
   
alpha=atan(([z(1);z(1);z(1:(n-2))]-[z(3:n);z(n);z(n)])./ ...
   ([x(3:n);x(n);x(n)]-[x(1);x(1);x(1:(n-2))]));
%alpha=gauss(alpha,4);
         
% calculate ice thickness

for i=1:n
   h(i)=fzero('thick',100,[],vb(i),A*enh(i),alpha(i),w(i));
end

tic
toc