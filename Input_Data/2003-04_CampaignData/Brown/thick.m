function res=thick(h,v,A,alpha,w)

rho=900;
g=9.81;
lam=.7422;

res=v-.5*A*(rho*g*sin(alpha)/1e5)^3*h^4*(1-exp(-lam*w/(2*h)))^3;