--按照学号查询
Select * From Student Where cNo like '%06%';

--按照院系专业
Select * From Student Where cDepartNo = '06' and cMajorNo = '080905';

--按照姓名查询
Select * From Student Where cMajorNo=(Select cMajorNo From Student Where vName='马圆媛')
and iGrade = (Select iGrade From Student Where vName='马圆媛');

--添加专业
Select * From Major;
Insert into Major values('080906','test');
Delete From Major Where cMajorNo = '080906' and vName = 'test';

--按照姓名学号查询成绩的存储过程
GO
Create Proc prcFindByNoName @No char(12),@Name varchar(30)
As
Select Student.cNo as 学号,Student.vName 姓名,Score.cCourseNo 课程号,Course.vCourseName 课程名,Score.nScore 分数 From Student,Score,Course
Where Student.cNo = Score.cNo and Course.cCourseNo = Score.cCourseNo
and Student.vName = @Name and Student.cNo = @No

GO
exec prcFindByNoName '201531060570','石华';

--按照学号查询成绩的存储过程
GO
Create Proc prcFindByNo @No char(12)
As
Select Student.cNo as 学号,Student.vName 姓名,Score.cCourseNo 课程号,Course.vCourseName 课程名,Score.nScore 分数 From Student,Score,Course
Where Student.cNo = Score.cNo and Course.cCourseNo = Score.cCourseNo
and Student.cNo = @No

GO
exec prcFindByNo '201531060570'

--按照姓名查询成绩的存储过程
GO
Create Proc prcFindByName @Name varchar(30)
As
Select Student.cNo as 学号,Student.vName 姓名,Score.cCourseNo 课程号,Course.vCourseName 课程名,Score.nScore 分数 From Student,Score,Course
Where Student.cNo = Score.cNo and Course.cCourseNo = Score.cCourseNo
and Student.vName = @Name

GO
exec prcFindByName '石华';