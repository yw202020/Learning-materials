--����ѧ�Ų�ѯ
Select * From Student Where cNo like '%06%';

--����Ժϵרҵ
Select * From Student Where cDepartNo = '06' and cMajorNo = '080905';

--����������ѯ
Select * From Student Where cMajorNo=(Select cMajorNo From Student Where vName='��Բ��')
and iGrade = (Select iGrade From Student Where vName='��Բ��');

--���רҵ
Select * From Major;
Insert into Major values('080906','test');
Delete From Major Where cMajorNo = '080906' and vName = 'test';

--��������ѧ�Ų�ѯ�ɼ��Ĵ洢����
GO
Create Proc prcFindByNoName @No char(12),@Name varchar(30)
As
Select Student.cNo as ѧ��,Student.vName ����,Score.cCourseNo �γ̺�,Course.vCourseName �γ���,Score.nScore ���� From Student,Score,Course
Where Student.cNo = Score.cNo and Course.cCourseNo = Score.cCourseNo
and Student.vName = @Name and Student.cNo = @No

GO
exec prcFindByNoName '201531060570','ʯ��';

--����ѧ�Ų�ѯ�ɼ��Ĵ洢����
GO
Create Proc prcFindByNo @No char(12)
As
Select Student.cNo as ѧ��,Student.vName ����,Score.cCourseNo �γ̺�,Course.vCourseName �γ���,Score.nScore ���� From Student,Score,Course
Where Student.cNo = Score.cNo and Course.cCourseNo = Score.cCourseNo
and Student.cNo = @No

GO
exec prcFindByNo '201531060570'

--����������ѯ�ɼ��Ĵ洢����
GO
Create Proc prcFindByName @Name varchar(30)
As
Select Student.cNo as ѧ��,Student.vName ����,Score.cCourseNo �γ̺�,Course.vCourseName �γ���,Score.nScore ���� From Student,Score,Course
Where Student.cNo = Score.cNo and Course.cCourseNo = Score.cCourseNo
and Student.vName = @Name

GO
exec prcFindByName 'ʯ��';