x=-5:0.1:5;
y=((x+sqrt(pi))./(exp(1)*exp(1))).*(x<=0) + (0.5*log(x+sqrt(1+x.*x))).*(x>0);
plot(x,y,':rp')