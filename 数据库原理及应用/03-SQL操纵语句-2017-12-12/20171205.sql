--1)	��ѯȫ��ѧ����ѧ�š�������Ҫ��ѧ�Ž����������С�
Select Sno,Sname From Student order by Sno Asc;

--2)	��ѯ���пγ���Ϣ��Ҫ���е�˳����Course���е�����һ����
Select * From Course;

--3)	��ѯSC��������ѧ����ѧ�ţ�����������е��ظ��С�
Select Distinct Sno From SC;

--4)	��ѯѡ����c03�ſγ��ҳɼ���70�����ϵ�ѧ��ѧ����ɼ���
Select Sno,Grade From SC Where Cno = 'C03' and Grade > 70;

--5)	��ѯc03�ſγ̳ɼ���70~80֮���ѧ��ѧ�š�
Select Sno From SC Where Cno = 'C03' and Grade between 70 and 80;

--6)	��ѯ�������ϵ�������Ź�ϵ��ѧ����ȫ����Ϣ��
Select * From Student Where Sdept = '�����ϵ' or Sdept = '�Ź�ϵ';

--7)	��ѯ�����к��С������ֵ�ѧ����Ϣ��
Select * From Student Where Sname like '%��%';

--8)	��ѯ�γ����в��������ݡ������Ŀγ���Ϣ��
Select * From Course Where Cname not like '%����%';

--9)	��ѯc03�ſγ̳ɼ�����10�ֺ��ѧ��ѧ�źͳɼ���Ҫ�������ʱ���⡣
Select Sno 'ѧ��',Grade+10 '�ɼ���10��' From SC Where Cno = 'c03';

--10)	��ѯ�Ź�ϵѧ��������������С���䡣
Select MAX(Sage) �������,MIN(Sage) ��С���� From Student Where Sdept = '�Ź�ϵ';

--11)	��ѯ�����γ̺ż���Ӧ��ѡ��������
Select Cno,COUNT(*) ѡ������ From SC group by Cno;

--12)	��ѯѡ����2�����Ͽγ̵�ѧ��ѧ�š�
Select Sno,COUNT(*) From SC group by Sno Having  COUNT(*) >2;

--13)	��ѯÿ��ѧ������ѡ�޿γ̵������
Select Student.Sno,Sname,Ssex,Sage,Sdept,Cno,Grade From Student,SC Where Student.Sno = SC.Sno;

--14)	��ѯѡ���˿γ�c04�ҳɼ���80�����ϵ�����ѧ����ѧ�ź�������
Select Student.Sno,Sname From Student,SC Where Student.Sno = SC.Sno and SC.Cno = 'C04' and SC.Grade > 80;

--15)	�����ַ�����ѯѡ���˿γ���Ϊ����������硱��ѧ��ѧ�ź�������
Select Sno,Sname From Student Where Sno in (Select Sno From SC Where Cno in (Select Cno From Course Where Cname = '���������'));
Select Student.Sno,Sname From Student,SC,Course Where Student.Sno = SC.Sno AND SC.Cno = Course.Cno AND Course.Cname = '���������';