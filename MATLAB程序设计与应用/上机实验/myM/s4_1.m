n=input('请输入n：');
%循环结构求pi
s=0;
for i=1:n
    s=s+1/i/i;
end
pi=sqrt(6*s);
disp('循环求pi：');
disp(pi)

%向量结构求pi
t=1./(1:n).^2;
s=sum(t);
pi=sqrt(6*s);
disp('向量求pi：');
disp(pi)