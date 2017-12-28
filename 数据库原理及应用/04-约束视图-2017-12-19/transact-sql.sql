--作者:石华
--日期:2017-12-19 17:13

--(1)	使用Transact-SQL语句创建STUDENT数据库。
USE master
--如果存在STUDENT数据库则删除
if exists (select * from sysdatabases where name='STUDENT')
begin
	DROP database STUDENT
end
GO
Create Database STUDENT;
Go
Use STUDENT
Go
--(2)	使用Transact-SQL语句创建STUDENT数据库包含的所有表。
Create Table Course(
	Cno varchar(10) NOT NULL,
	Cname varchar(20) NOT NULL,
	Credit int NOT NULL,
	Semster int NOT NULL,
	Period int NOT NULL
);
Create Table Student(
	Sno varchar(7) NOT NULL,
	Sname varchar(10) NOT NULL,
	Ssex varchar(2) NOT NULL,
	Sage int NOT NULL,
	Sdept varchar(20) NOT NULL
);
Create Table SC(
	Sno varchar(7) NOT NULL,
	Cno varchar(10) NOT NULL,
	Grade int NOT NULL
);
Go
--Course表约束
Alter Table Course Add Constraint CK_Credit Check(Credit>0);
Alter Table Course Add Constraint CK_Semster Check(Semster>0);
Alter Table Course Add Constraint CK_Period Check(Period>0);
--Student表约束
Alter Table Student Add Constraint CK_Ssex Check(Ssex in ('男','女'));
Alter Table Student Add Constraint CK_Sage Check(Sage Between 15 and 45);
Alter Table Student Add Constraint DF_Sdept Default '计算机系' For Sdept;
--SC表约束
Alter Table Sc Add Constraint CK_Grade Check(Grade Between 0 and 100);
Go

--(3)	使用Transact-SQL语句创建STUDENT数据库包含表的主键、外键约束条件。
--Course表主键约束
Alter Table Course Add Constraint PK_Course Primary Key (Cno);
--Student表主键约束
Alter Table Student Add Constraint PK_Student Primary Key (Sno);
--SC表主键约束
Alter Table SC Add Constraint PK_SC Primary Key (Cno,Sno);
--SC表外键约束
Alter Table SC Add Constraint FK_SC_Course Foreign Key (Cno) References Course(Cno);
Alter Table SC Add Constraint FK_SC_Student Foreign Key (Sno) References Student(Sno);
Go


--(4)	使用Transact-SQL语句在STUDENT数据库里创建视图（注意：在以下各个小题中，后续题目可以利用前面题目创建的视图）。
--①	信息系学生的视图FIRSTVIEW；
Create View FIRSTVIEW
As
Select * From Student Where Sdept = '信息系';
Go
--②	建立学分为4学分的课程视图SECONDVIEW；
Create View SECONDVIEW
As
Select * From Course Where Credit=4;
--③	删除上述所建立的其中一个视图SECONDVIEW。
Go
Drop View SECONDVIEW;


--(5)	使用Transact-SQL语句对表添加、修改、删除数据。
--①	插入数据
--在Course表中插入一行数据（“c07”，“应用统计”，3，4，54）；
Insert into Course Values('c07','应用统计',3,4,54);
Go
--②	修改数据
--将Student表中所有学生的年龄都改为20；
Update Student Set Sage='20';
Go
--③	删除数据
--删除成绩信息表中学号为0750122的信息。
Delete From SC Where Sno = '0750122';