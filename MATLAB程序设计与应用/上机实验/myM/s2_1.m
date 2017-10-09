E=eye(3);
R=rand(3,2);
O=zeros(2,3);
S=diag([1,2]);
A=[E R
   O S];
A^2
B=[E R+R*S
   O S^2]
