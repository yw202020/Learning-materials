--������
--1.1ͨ��������ӣ���SC���е�Cno���滻Ϊ��Ӧ�Ŀγ�����
Select Sno,Cname,Grade 
From SC 
Inner Join Course On (SC.Cno = Course.Cno);

--1.2ͨ��������ӣ���SC���е�Sno���滻Ϊ��Ӧ��������
Select Sname,Cno,Grade 
From SC 
Inner Join Student On (SC.Sno = Student.Sno);

--1.3ͨ��������ӣ���ʾѧ�ţ��������γ������������С�
Select Student.Sno ѧ��,Student.Sname ����,Cname �γ���,Grade ����
 From SC 
 Inner Join Course On (SC.Cno = Course.Cno) 
 Inner Join Student On (Sc.Sno = Student.Sno);
 
 
 --������
--2.1��SC���Course���������ӡ�
Select * From SC 
Left Outer Join Course On (SC.Cno = Course.Cno);

--2.2��SC���Course���������ӡ�
Select * From SC 
Right Outer Join Course On (SC.Cno = Course.Cno);

--2.3��SC���Course��ȫ�����ӡ�
Select * From SC 
Full Outer Join Course On (SC.Cno = Course.Cno);


--�Ӳ�ѯ
--3.1 ��ѯcourse���У���ѧ��ѡ�εĿγ���Ϣ��
Select * From Course 
Where Cno in 
(Select Distinct  Cno From SC);

--3.2 ��ѯcourse���У�û��ѧ��ѡ�εĿγ���Ϣ��
Select * From Course 
Where Cno Not In 
(Select Distinct  Cno From SC);

--3.3��ѯ������ͬһ��Ժϵ��ѧ����
Select * From Student 
Where Sdept = 
(Select Sdept From Student Where Sname = '����')
and Sname <> '����';





--��ϰ
--���ʽ
Select Sname,2017-Sage From Student;

