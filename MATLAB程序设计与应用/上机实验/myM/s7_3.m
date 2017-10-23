x=linspace(0,0.002,1000);
t=linspace(0,0.002,1000);
[x,t]=meshgrid(x,t);
z=10*exp(-0.01*x).*sin(2000*pi.*t-0.2*x+pi);
axes('view',[-37.5,30]); 
hr=surface(x,t,z,'FaceColor','w','EdgeColor','flat','LineStyle','-');
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');
title('title')
set(hr,'LineWidth',0.1)
text(0,0,10,'text')

