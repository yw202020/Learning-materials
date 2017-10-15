from numpy import * #
import matplotlib.pyplot as plt
#房屋数据
X_old=[1100,1400,1425,1550,1600,1700,1700,1875,2350,2450]
Y_old=[199000,245000,319000,240000,312000,279000,310000,308000,405000,324000]
X=[0,0.22,0.24,0.33,0.37,0.44,0.44,0.57,0.93,1.0]
Y=[0,0.22,0.58,0.20,0.55,0.39,0.54,0.53,1.00,0.61]
#学习率
r=0.01 
#损失函数误差
eps =0.0001
#误差平方和
SSE=100;
#最大迭代次数
max_iters = 100
iter_count=0
#随机初始化a,b 
a=0.45 ;b=0.75
while( SSE > eps and iter_count < max_iters):
    SSE=0;SSE_a=0;SSE_b=0
    for i in range (0,10):
      YP = a+b*X[i]
      SSE=SSE+0.5*(Y[i]-YP)*(Y[i]-YP)
      SSE_a=SSE_a-(Y[i]-YP)#a的梯度
      SSE_b=SSE_b-(Y[i]-YP)*X[i]#b的梯度
    print (a,b,SSE)  
    a = a-r * SSE_a 
    b= b-r * SSE_b
    iter_count += 1
  



plt.scatter(X,Y,c = 'r',marker = 'o')  
#画直线
x0y0=[X[0],X[9]]  
x2y2=[a+b*X[0],a+b*X[9]]  
plt.plot(x0y0,x2y2)
plt.show()
 