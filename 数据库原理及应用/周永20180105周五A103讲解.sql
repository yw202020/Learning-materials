Use SwpuStu
Go

--1、查询学生表有多少行记录。
Select COUNT(1) from student

--2、查询是共青团员的女学生。
select cNo,vName,cSex,cPolicitalStatus
from Student
where cPolicitalStatus='共青团员'
 and cSex='女'

--3、查询出生日期不为空的学生信息。
select * from Student 
where dBirth is not null

--4、查询政治面貌和出生日期都不为空的学生。
select * from Student 
where cPolicitalStatus is not null
and  dBirth is not null

--5、查询姓名中第二个汉字和第三个汉字相同的学生。
select  *  from Student 
where SUBSTRING(vname,2,1)=SUBSTRING(vname,3,1)

--6、查询与201531060645同一天生日的所有人。
select * from  Student 
where dBirth = 
(select  dBirth  from Student  
where  cNo='201531060645')

--7、检索显示学生表的所有行和列，但是要求院系和专业，不能显示编号，要用对应汉字。提示：多表连接操作。
Select cNo, Student.vName, cSex,dBirth,
vNation,cPolicitalStatus,Depart.vName,
Major.vName as "vMajorName",iGrade,cDormNo,cPhone 
from Student,Depart,Major 
where  Student.cDepartNo=Depart.cDepartNo and Student.cMajorNo =  Major.cMajorNo
go


--8、使用第7步的语句，创建一个vwStu的视图。
create view vwStu
as
Select cNo, Student.vName as "StuName", cSex,dBirth,
vNation,cPolicitalStatus,Depart.vName As "DepartName",
Major.vName as "vMajorName",iGrade,cDormNo,cPhone 
from Student,Depart,Major 
where  Student.cDepartNo=Depart.cDepartNo and Student.cMajorNo =  Major.cMajorNo
go 


--9、创建一个存储过程，根据用户传递的一个学号，返回该学生的基本信息。
--要求使用vwStu视图。
create proc prcFindByNo2 @no char(12)
as
select * from vwStu
where cNo=@no
Go

exec prcFindByNo2 '1205010102'


--10、查询姓名大于等于四个汉字的学生信息。
Select  *  from Student 
where LEN(vname)>=4


--11、根据院系编号、专业编号，进行数据分组，
--统计每一个专业的学生人数。
select cDepartNo,cMajorNo,COUNT(1)
from Student
group by cDepartNo,cMajorNo

--12、根据11步，自己指定一个数据，即专业人数必须大于某个值的数据才显示。
select cDepartNo,cMajorNo,COUNT(1)
from Student
group by cDepartNo,cMajorNo
having COUNT(1)>200

--13、用select * from score了解分数表的信息。
select * from score

--14、用一个查询得到学号，姓名，课程号，分数四项。
select Student.cNo ,vName,cCourseNo,nScore
from Score,Student 
where Score.cNo=Student.cNo 

--15、查询不及格的学生，显示学号，姓名，分数，按照分数的降序显示。
select Student.cNo ,vName,nScore
from Score,Student 
where Score.cNo=Student.cNo 
and nScore<60
order by nScore desc


--16、修改score表的结构，增加主关键字。
Alter table Score
add Constraint Pk_Score_zuhe
Primary key (cNo,cCourseNo)

--17、往学生表增加一行记录，每一个数据都提供，自己给定一些值。
select top 3 * from Student 
Select * from major
Insert into Student values('201731065555',
'张三','男','2000-1-1','汉族','共产党员',
'06','080901',2017,'22-111','15945678901')


--18、往学生表增加一行记录，只提供学号，姓名，性别，出生日期，院系，专业，年级。
Insert into  Student(cNo ,cDepartNo,cMajorNo,iGrade,vName ,cSex )
values ('201731026666','06','080905',2017,'王一多','男')

--19、修改201531060645的政治面貌为“共产党员”。
update Student 
set cPolicitalStatus='共产党员'
where cNo='201531060645'

--20、删除student表中，学号最后两位为06的学生。如果不能删除，应该怎么办。
delete from Score
where RIGHT(cNo,2)='06'

delete from Student 
where RIGHT(cNo,2)='06'

21、对学生表中，年级为2015级的男生，寝室号为空的，检索出前6个学生，设置其寝室号为19-101.
select top 6 *  from student 
where iGrade =2015 and cSex ='男' 
and cDormNo is NULL

update Student 
set cDormNo='19-101'
where cNo in
(select top 6 Cno  from student 
where iGrade =2015 and cSex ='男' 
and cDormNo is NULL)