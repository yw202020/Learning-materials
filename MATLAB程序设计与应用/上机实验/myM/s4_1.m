n=input('������n��');
%ѭ���ṹ��pi
s=0;
for i=1:n
    s=s+1/i/i;
end
pi=sqrt(6*s);
disp('ѭ����pi��');
disp(pi)

%�����ṹ��pi
t=1./(1:n).^2;
s=sum(t);
pi=sqrt(6*s);
disp('������pi��');
disp(pi)