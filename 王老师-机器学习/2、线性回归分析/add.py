from numpy import * #
import matplotlib.pyplot as plt

X=[4,8,9,8,7,12,6,10,6,9]
Y=[9,20,22,15,17,23,18,25,10,20]


Xavg=0
Yavg=0

for x in X:
    Xavg = Xavg + x
Xavg=Xavg/10

for y in Y:
    Yavg = Yavg + y
Yavg=Yavg/10

Lxy=0
Lxx=0
for i in range(0,10):
  Lxy=Lxy+(X[i]-Xavg)*(Y[i]-Yavg)
  Lxx=Lxx+(X[i]-Xavg)*(X[i]-Xavg)

b=Lxy/Lxx
a=Yavg-b*Xavg
print (a,b)

plt.scatter(X,Y,c = 'r',marker = 'o')  

x1=[X[0],a+b*Y[0]]  
y1=[X[9],a+b*Y[9]]  
plt.plot(x1,y1)
plt.show()
 