--������������С������У�������
--where�������ڵ���2��
select *  from Student 

select cno,vname,csex,cmajorno 
from Student 
where RIGHT(cno,2)='06'  and  cMajorNo='080905'
order by cNo desc


--����ѯ
--���磺ѧ����ѧ�ţ��������γ������γ̺ţ�����
select Student.cNo , Student.vName, Course.cCourseNo,Course.  vCourseName ,nScore 
from Score,Course ,Student 
where Score.cCourseNo =Course.cCourseNo  and Score.cNo =Student.cNo 


--Ƕ�ײ�ѯ��exists
--���磺��ѧ��ѡ�޵Ŀγ̱�ţ����ƺ�ѧ��
select * from Course 
where cCourseNo in (select distinct cCourseNo  from Score )

select * from Course 
where exists (select * from Score  where Course.cCourseNo =Score.cCourseNo )


--���ݲ��룬ֻ�������ֶεĸ�ֵ
Insert into Major values ('080907'  ,'������')
Insert into Student(cNo, vName,cSex ,cDepartNo,cMajorNo ,iGrade  ) 
 values('201531067777' ,'����', '��' ,'06','080905',2015)

--�������Լ��������ɾ��
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