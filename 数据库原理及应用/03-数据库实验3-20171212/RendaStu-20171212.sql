--内连接
--1.1通过表的连接，将SC表中的Cno，替换为对应的课程名。
Select Sno,Cname,Grade 
From SC 
Inner Join Course On (SC.Cno = Course.Cno);

--1.2通过表的连接，将SC表中的Sno，替换为对应的姓名。
Select Sname,Cno,Grade 
From SC 
Inner Join Student On (SC.Sno = Student.Sno);

--1.3通过表的连接，显示学号，姓名，课程名，分数四列。
Select Student.Sno 学号,Student.Sname 姓名,Cname 课程名,Grade 分数
 From SC 
 Inner Join Course On (SC.Cno = Course.Cno) 
 Inner Join Student On (Sc.Sno = Student.Sno);
 
 
 --外连接
--2.1让SC表和Course表，左外连接。
Select * From SC 
Left Outer Join Course On (SC.Cno = Course.Cno);

--2.2让SC表和Course表，右外连接。
Select * From SC 
Right Outer Join Course On (SC.Cno = Course.Cno);

--2.3让SC表和Course表，全外连接。
Select * From SC 
Full Outer Join Course On (SC.Cno = Course.Cno);


--子查询
--3.1 查询course表中，有学生选课的课程信息。
Select * From Course 
Where Cno in 
(Select Distinct  Cno From SC);

--3.2 查询course表中，没有学生选课的课程信息。
Select * From Course 
Where Cno Not In 
(Select Distinct  Cno From SC);

--3.3查询与刘晨同一个院系的学生。
Select * From Student 
Where Sdept = 
(Select Sdept From Student Where Sname = '刘晨')
and Sname <> '刘晨';





--练习
--表达式
Select Sname,2017-Sage From Student;

