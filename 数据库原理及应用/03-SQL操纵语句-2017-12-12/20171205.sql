--1)	查询全体学生的学号、姓名，要求按学号进行升序排列。
Select Sno,Sname From Student order by Sno Asc;

--2)	查询所有课程信息，要求列的顺序与Course表中的列序一样。
Select * From Course;

--3)	查询SC表中所有学生的学号，消除结果集中的重复行。
Select Distinct Sno From SC;

--4)	查询选修了c03号课程且成绩在70分以上的学生学号与成绩。
Select Sno,Grade From SC Where Cno = 'C03' and Grade > 70;

--5)	查询c03号课程成绩在70~80之间的学生学号。
Select Sno From SC Where Cno = 'C03' and Grade between 70 and 80;

--6)	查询“计算机系”、“信管系”学生的全部信息。
Select * From Student Where Sdept = '计算机系' or Sdept = '信管系';

--7)	查询名字中含有“王”字的学生信息。
Select * From Student Where Sname like '%王%';

--8)	查询课程名中不含“数据”字样的课程信息。
Select * From Course Where Cname not like '%数据%';

--9)	查询c03号课程成绩加上10分后的学生学号和成绩，要求给出临时标题。
Select Sno '学号',Grade+10 '成绩加10分' From SC Where Cno = 'c03';

--10)	查询信管系学生的最大年龄和最小年龄。
Select MAX(Sage) 最大年龄,MIN(Sage) 最小年龄 From Student Where Sdept = '信管系';

--11)	查询各个课程号及相应的选课人数。
Select Cno,COUNT(*) 选课人数 From SC group by Cno;

--12)	查询选修了2门以上课程的学生学号。
Select Sno,COUNT(*) From SC group by Sno Having  COUNT(*) >2;

--13)	查询每个学生及其选修课程的情况。
Select Student.Sno,Sname,Ssex,Sage,Sdept,Cno,Grade From Student,SC Where Student.Sno = SC.Sno;

--14)	查询选修了课程c04且成绩在80分以上的所有学生的学号和姓名。
Select Student.Sno,Sname From Student,SC Where Student.Sno = SC.Sno and SC.Cno = 'C04' and SC.Grade > 80;

--15)	用两种方法查询选修了课程名为“计算机网络”的学生学号和姓名。
Select Sno,Sname From Student Where Sno in (Select Sno From SC Where Cno in (Select Cno From Course Where Cname = '计算机网络'));
Select Student.Sno,Sname From Student,SC,Course Where Student.Sno = SC.Sno AND SC.Cno = Course.Cno AND Course.Cname = '计算机网络';