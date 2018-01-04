--单表检索部分行、部分列，并排序
--where条件大于等于2个
select *  from Student 

select cno,vname,csex,cmajorno 
from Student 
where RIGHT(cno,2)='06'  and  cMajorNo='080905'
order by cNo desc


--多表查询
--例如：学生的学号，姓名，课程名，课程号，分数
select Student.cNo , Student.vName, Course.cCourseNo,Course.  vCourseName ,nScore 
from Score,Course ,Student 
where Score.cCourseNo =Course.cCourseNo  and Score.cNo =Student.cNo 


--嵌套查询与exists
--例如：有学生选修的课程编号，名称和学分
select * from Course 
where cCourseNo in (select distinct cCourseNo  from Score )

select * from Course 
where exists (select * from Score  where Course.cCourseNo =Score.cCourseNo )


--数据插入，只给部分字段的赋值
Insert into Major values ('080907'  ,'大数据')
Insert into Student(cNo, vName,cSex ,cDepartNo,cMajorNo ,iGrade  ) 
 values('201531067777' ,'张三', '男' ,'06','080905',2015)

--主键外键约束，级联删除
create table Score2
(
 cNo char(12) Not NULL,
 cCourseNo char(10) Not NULL,
 iScore int
)
go

Alter Table Score2
add Constraint PK_Soore2_zuhe
Primary Key (cNo, cCourseNo)
Go


Alter Table Score2
add Constraint FK_Stu_score2_no
foreign key (cNo) references Student(Cno)
ON delete CASCADE
go