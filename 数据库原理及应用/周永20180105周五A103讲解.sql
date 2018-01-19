Use SwpuStu
Go

--1����ѯѧ�����ж����м�¼��
Select COUNT(1) from student

--2����ѯ�ǹ�����Ա��Ůѧ����
select cNo,vName,cSex,cPolicitalStatus
from Student
where cPolicitalStatus='������Ա'
 and cSex='Ů'

--3����ѯ�������ڲ�Ϊ�յ�ѧ����Ϣ��
select * from Student 
where dBirth is not null

--4����ѯ������ò�ͳ������ڶ���Ϊ�յ�ѧ����
select * from Student 
where cPolicitalStatus is not null
and  dBirth is not null

--5����ѯ�����еڶ������ֺ͵�����������ͬ��ѧ����
select  *  from Student 
where SUBSTRING(vname,2,1)=SUBSTRING(vname,3,1)

--6����ѯ��201531060645ͬһ�����յ������ˡ�
select * from  Student 
where dBirth = 
(select  dBirth  from Student  
where  cNo='201531060645')

--7��������ʾѧ����������к��У�����Ҫ��Ժϵ��רҵ��������ʾ��ţ�Ҫ�ö�Ӧ���֡���ʾ��������Ӳ�����
Select cNo, Student.vName, cSex,dBirth,
vNation,cPolicitalStatus,Depart.vName,
Major.vName as "vMajorName",iGrade,cDormNo,cPhone 
from Student,Depart,Major 
where  Student.cDepartNo=Depart.cDepartNo and Student.cMajorNo =  Major.cMajorNo
go


--8��ʹ�õ�7������䣬����һ��vwStu����ͼ��
create view vwStu
as
Select cNo, Student.vName as "StuName", cSex,dBirth,
vNation,cPolicitalStatus,Depart.vName As "DepartName",
Major.vName as "vMajorName",iGrade,cDormNo,cPhone 
from Student,Depart,Major 
where  Student.cDepartNo=Depart.cDepartNo and Student.cMajorNo =  Major.cMajorNo
go 


--9������һ���洢���̣������û����ݵ�һ��ѧ�ţ����ظ�ѧ���Ļ�����Ϣ��
--Ҫ��ʹ��vwStu��ͼ��
create proc prcFindByNo2 @no char(12)
as
select * from vwStu
where cNo=@no
Go

exec prcFindByNo2 '1205010102'


--10����ѯ�������ڵ����ĸ����ֵ�ѧ����Ϣ��
Select  *  from Student 
where LEN(vname)>=4


--11������Ժϵ��š�רҵ��ţ��������ݷ��飬
--ͳ��ÿһ��רҵ��ѧ��������
select cDepartNo,cMajorNo,COUNT(1)
from Student
group by cDepartNo,cMajorNo

--12������11�����Լ�ָ��һ�����ݣ���רҵ�����������ĳ��ֵ�����ݲ���ʾ��
select cDepartNo,cMajorNo,COUNT(1)
from Student
group by cDepartNo,cMajorNo
having COUNT(1)>200

--13����select * from score�˽���������Ϣ��
select * from score

--14����һ����ѯ�õ�ѧ�ţ��������γ̺ţ��������
select Student.cNo ,vName,cCourseNo,nScore
from Score,Student 
where Score.cNo=Student.cNo 

--15����ѯ�������ѧ������ʾѧ�ţ����������������շ����Ľ�����ʾ��
select Student.cNo ,vName,nScore
from Score,Student 
where Score.cNo=Student.cNo 
and nScore<60
order by nScore desc


--16���޸�score��Ľṹ���������ؼ��֡�
Alter table Score
add Constraint Pk_Score_zuhe
Primary key (cNo,cCourseNo)

--17����ѧ��������һ�м�¼��ÿһ�����ݶ��ṩ���Լ�����һЩֵ��
select top 3 * from Student 
Select * from major
Insert into Student values('201731065555',
'����','��','2000-1-1','����','������Ա',
'06','080901',2017,'22-111','15945678901')


--18����ѧ��������һ�м�¼��ֻ�ṩѧ�ţ��������Ա𣬳������ڣ�Ժϵ��רҵ���꼶��
Insert into  Student(cNo ,cDepartNo,cMajorNo,iGrade,vName ,cSex )
values ('201731026666','06','080905',2017,'��һ��','��')

--19���޸�201531060645��������òΪ��������Ա����
update Student 
set cPolicitalStatus='������Ա'
where cNo='201531060645'

--20��ɾ��student���У�ѧ�������λΪ06��ѧ�����������ɾ����Ӧ����ô�졣
delete from Score
where RIGHT(cNo,2)='06'

delete from Student 
where RIGHT(cNo,2)='06'

21����ѧ�����У��꼶Ϊ2015�������������Һ�Ϊ�յģ�������ǰ6��ѧ�������������Һ�Ϊ19-101.
select top 6 *  from student 
where iGrade =2015 and cSex ='��' 
and cDormNo is NULL

update Student 
set cDormNo='19-101'
where cNo in
(select top 6 Cno  from student 
where iGrade =2015 and cSex ='��' 
and cDormNo is NULL)