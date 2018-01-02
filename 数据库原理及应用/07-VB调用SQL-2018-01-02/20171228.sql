/*
��������ʯ�ʹ�ѧѧ�����ݿ�
�ر�˵����������Ϣ�У�ѧ�ź���������ʵ�ģ�������й��
��ѧ�ź�����֮�⣬���翼�Է������ֻ��ŵȣ�����������ġ�
SQL�ű����� ����  v201712
*/
Use Master
Go

if exists(select * from sysdatabases where name='SwpuStu')
begin
  print 'ɾ��ԭ�����ݿ�...'
  drop database SwpuStu
end

print '1.�������ݿ�'
Create Database SwpuStu
Go

Use SwpuStu
Go

print '2.������ṹ'
--Ժϵ��
Create Table Depart
(
 cDepartNo char(2) NOT NULL Constraint PK_Depart_No Primary Key, --Ժϵ��ţ����ؼ���
 vName varchar(30) NOT NULL  --Ժϵ���ƣ����15������
)
Go


--רҵ��
Create Table Major
(
 cMajorNo char(7) NOT NULL Constraint PK_Major_No Primary Key, --Ժϵ��ţ����ؼ��֣�������6λ������רҵ��Ҫ7λ
 vName varchar(30) NOT NULL  --רҵ���ƣ����15������
)
Go

/*
ѧ����Student��10������
ѧ�ţ��������Ա𣬳������ڣ����壬������ò��
Ժϵ��ţ�רҵ��ţ��꼶�����Һţ���ϵ�绰
*/
Create Table Student
(
 cNo char(12) NOT NULL Constraint PK_Stu_No Primary Key, --ѧ�ţ�12λ�����ؼ���
 vName varchar(30) NOT NULL, --�����������15������
 cSex char(2) NULL, --�Ա�һ������
 dBirth datetime, --��������
 vNation varchar(20) NULL, --���壬�������10������
 cPolicitalStatus char(8) NULL, --������ò��������Ա��������Ա��Ⱥ��
 cDepartNo char(2) NOT NULL Constraint FK_Depart_Student_No Foreign Key References Depart(cDepartNo), --Ժϵ��ţ��̶�������λ
 cMajorNo char(7) NOT NULL Constraint FK_Major_Student_No Foreign Key References Major(cMajorNo),  --רҵ��ţ���Ҫ����������һ��
 iGrade int NOT NULL, --�꼶�������ֶΣ�����ѧ�ŵ������λ
 cDormNo char(6) NULL, --���Һţ���ʽ�磺19-203
 cPhone char(11) NULL  --�ֻ�����
)
Go

/*
�γ������Ϣ
Course���γ̺ţ��γ�����ѧ�֣�ѧʱ
*/
Create Table Course
(
 cCourseNo char(10) NOT NULL Constraint PK_Course_No Primary Key,--�γ̺�
 vCourseName varchar(30) NOT NULL, --�γ���
 iCredit int NOT NULL, --ѧ��
 iHours int NOT NULL --ѧʱ
)
Go

/*
ѧ���ķ���
Score��ѧ�ţ��γ̺ţ�������ѧ�ڣ�¼��ɼ�ʱ��
*/
Create Table Score
(
  cNo char(12) Not NULL Constraint FK_Student_Score_No Foreign Key References Student(cNo), --ѧ��
  cCourseNo char(10) NOT NULL Constraint FK_Course_Score_No  Foreign Key References Course(cCourseNo), --�γ̺�
  nScore numeric(4,1) NULL, --�ܳ�����λ����λ������һλС��
  tSemester tinyint NULL, --ѧʱ�ڵڼ�ѧ��ȡ�õĳɼ���ֻ���1��8֮�������
  dDate datetime NULL --��ʦΪ�ÿγ�¼��ɼ���ʱ��
)
Go


print '3.��������'
--�����ǲ�������
Insert into Depart Values('01','ʯ������Ȼ������ѧԺ');
Insert into Depart Values('02','�����ѧ�뼼��ѧԺ');
Insert into Depart Values('03','���繤��ѧԺ');
Insert into Depart Values('04','��ѧ����ѧԺ');
Insert into Depart Values('05','���Ͽ�ѧ�빤��ѧԺ');
Insert into Depart Values('06','�������ѧѧԺ');
Insert into Depart Values('07','������ϢѧԺ');
Insert into Depart Values('08','��ľ�����뽨��ѧԺ');
Insert into Depart Values('09','��ѧԺ');
Insert into Depart Values('10','���ù���ѧԺ/MBA�������ķ�ѧԺ');
Insert into Depart Values('11','���˼����ѧԺ');
Insert into Depart Values('12','�����ѧԺ');
Insert into Depart Values('13','����ѧԺ����������ίԱ�ᣩ');
Insert into Depart Values('14','����ѧԺ');

Insert into Major Values('080901','�������ѧ�뼼��');
Insert into Major Values('080902','�������');
Insert into Major Values('080903','���繤��');
Insert into Major Values('080905','����������');
Insert into Major Values('120102','��Ϣ��������Ϣϵͳ');

Insert into Course values ('9812202040','��Ƭ����SoC',4,64);
Insert into Course values ('9812204040','��������Ϣ��֪����',4,64);
Insert into Course values ('5607602035','���ݿ�ԭ��Ӧ��',4,64);


Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010101','��Բ��','Ů ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010102','������','Ů ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010103','����','Ů ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010104','��ӯ','Ů ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010105','�����','Ů ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010106','������','Ů ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010108','�ߺ�','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010111','��','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010113','��۱�','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010116','������','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010117','Ф���','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010118','��ޱ��','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010119','�Ź�','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010122','�Ի�','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010126','̷ΰ','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010127','��ɭ','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010128','���','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010130','��С��','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010201','������','Ů ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010202','���','Ů ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010203','���Ө','Ů ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010204','������','Ů ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010205','��ѩ��','Ů ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010206','��־Զ','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010207','���H','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010208','���','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010209','���','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010210','������','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010212','���','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010214','����','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010215','Ҷ��','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010216','³��Զ','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010218','���','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010219','����','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010221','�̿���','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010222','����','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010224','����','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010225','�ؼ�','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010226','����','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010227','�޺���','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010228','����ʢ','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010230','������','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010301','����','Ů ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010302','����','Ů ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010303','����','Ů ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010304','���i','Ů ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010306','κ��','Ů ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010307','����','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010309','��־��','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010310','¬��','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010311','����','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010312','����','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010314','ĸ��','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010315','������','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010316','Ԭ��','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010317','�����','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010318','Ф��','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010319','�ܿ���','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010322','ղ��','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010323','���л�','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010324','���ϴ�','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010326','�˺ƾ�','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010328','�佨��','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010329','�Ű�','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010401','������','Ů ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010403','����','Ů ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010404','����','Ů ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010405','��ӱӱ','Ů ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010406','�Ÿ���','Ů ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010407','����˳','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010409','��Ӣ��','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010410','�Է�','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010415','��˳��','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010416','�ƺ�Ȼ','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010417','������','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010419','������','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010420','̷ǿ','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010424','�ܽ�','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010425','����','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010426','ף��','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010428','���ƽ�','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010429','���Ȼ','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010430','����','�� ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020102','�����','Ů ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020103','̷��','Ů ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020104','��ٻٻ','Ů ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020106','�̺���','Ů ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020107','��ɯ','Ů ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020108','������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020109','����ƽ','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020111','�¸���','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020113','����','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020114','��ݶ��','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020115','�����','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020116','��˼�','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020117','��ε','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020118','������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020119','���ͽ�','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020120','������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020123','���Ŀ�','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020124','�¿���','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020125','�����','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020126','������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020127','�׿�','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020128','����ɭ','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020130','���','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020132','��','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020135','���ǽ�','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020136','����','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020201','��Ƽ','Ů ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020202','��Ӣ','Ů ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020205','������','Ů ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020206','����','Ů ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020208','�����','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020209','�ż���','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020211','������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020212','������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020214','�����','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020215','����','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020216','��־ǿ','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020217','ŷ������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020219','������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020220','�ų�','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020221','κ��','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020222','���ΰ','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020225','������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020226','Τ����','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020228','������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020232','�ƺ�','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020233','������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020234','������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020235','����ѧ','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020236','���','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020237','����ƽ','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020238','������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020301','����ӱ','Ů ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020302','������','Ů ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020303','����','Ů ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020304','����Ө','Ů ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020307','������','Ů ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020310','����ة','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020311','��׳','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020314','����','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020315','����','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020316','�Ա���','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020318','������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020319','����','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020320','�º���','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020321','���Ʒ�','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020322','��','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020323','�澸Ԫ','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020325','�Խ�','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020326','�ƲŸ�','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020327','��ӱ','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020329','����','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020330','�����','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020331','��Ф','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020332','������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020333','������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020334','�ܴ���','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020336','����','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020337','��Ԫ��','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020401','������','Ů ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020402','������','Ů ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020403','����','Ů ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020404','������','Ů ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020405','���','Ů ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020406','����','Ů ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020407','������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020408','֣���','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020410','�ų�','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020413','��ΰ','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020414','������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020415','ŷ������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020418','������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020419','������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020421','���¾�','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020422','����','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020424','��Ǭ','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020425','����','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020427','������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020428','��ȫ��','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020429','�׺���','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020430','����','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020434','������','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020438','��','�� ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030101','������','Ů ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030102','�延','Ů ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030103','Ǯ��','Ů ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030104','����','Ů ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030105','ϯ����','Ů ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030106','���ㆴ','Ů ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030107','������','Ů ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030108','������','Ů ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030111','����','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030112','����','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030113','�ⶫ��','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030114','����','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030116','������','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030117','����','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030118','��ά��','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030119','��ͩ','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030121','�˱��','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030122','��ҳ�','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030123','��һƽ','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030124','����','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030125','�˾�','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030126','�鶨��','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030127','����','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030130','֣����','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030131','���','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030132','������','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030133','�Ŀ���','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030134','���³�','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030135','������','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030136','�޿���','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030137','��μ��','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030138','����','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030139','�ų�','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030141','�캣��','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030142','�Ά�','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030201','������','Ů ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030202','��ҫ�','Ů ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030203','������','Ů ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030204','���','Ů ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030205','л��','Ů ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030206','��ά','Ů ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030207','����ƽ','Ů ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030208','����','Ů ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030209','����','Ů ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030210','ʯ����','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030211','������','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030212','���Ĳ�','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030213','������','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030216','����','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030218','�޿�','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030219','������','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030220','������','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030221','����','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030222','����','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030223','�°ظ�','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030225','��־','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030227','�ʺ�ΰ','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030229','��С��','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030231','�����','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030235','����','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030236','�³�','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030238','���','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030241','�����','�� ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040101','�ŷ���','Ů ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040103','κ���','Ů ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040104','������','Ů ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040106','��޼�','Ů ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040107','���','Ů ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040108','ŷ��','Ů ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040109','������','Ů ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040110','����','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040112','ʯ����','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040115','��׿','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040117','�ƴ���','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040118','�Ѻ׷�','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040119','����ϣ','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040121','����','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040122','�ֿ�','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040123','�����','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040124','�ƻ�','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040125','������','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040126','�³�','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040127','�Ų�','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040128','���','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040201','����','Ů ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040202','���Զ','Ů ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040203','������','Ů ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040204','������','Ů ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040205','����','Ů ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040207','��׿��','Ů ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040208','����Ȼ','Ů ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040209','����','Ů ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040210','���','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040212','������','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040213','���','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040214','�޸�ʯ��','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040216','�ŷ�','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040217','����','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040218','�ν�','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040219','�����','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040220','����','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040221','��Խ','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040222','�¿�','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040223','����','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040224','�����','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040226','���','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040227','����','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040228','Ȩ�Ժ�','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040229','������','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040230','л����','�� ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030102','�߳�','Ů ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030103','������','Ů ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030105','������','Ů ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030106','����֥','Ů ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030111','��С��','Ů ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030112','������','Ů ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030113','�����','Ů ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030114','��ͯ','Ů ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030116','����','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030117','����','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030118','Ҷ�ٷ�','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030119','�����','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030120','Ƚ���','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030121','���','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030122','��һ��','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030125','�����x','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030126','Ҷ����','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030128','��ʤ��','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030129','�뿭','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030130','����΢','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030201','��أ','Ů ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030202','����','Ů ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030203','л��','Ů ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030205','����ʱ','Ů ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030206','�ַ���','Ů ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030207','������','Ů ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030208','����','Ů ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030209','���Ľ�','Ů ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030210','�������','Ů ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030211','����','Ů ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030212','�쳩','Ů ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030213','���˽�','Ů ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030214','��h��','Ů ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030215','����','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030216','������','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030217','��Ẹ�','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030218','��ѧǫ','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030219','������','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030220','���ɿ�','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030221','����','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030222','����','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030223','�м�����','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030224','���ĸ�','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030225','������','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030227','�곿','�� ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030229','Ƚ��ΰ','�� ','06','120102',2012);

Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040148','����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040110','κѩ÷','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040108','��Ƽ','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040109','������','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040105','��ʫ��','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201309020112','������','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040132','������','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040144','����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040111','κ��','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040101','�����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040145','¬��','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040130','����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040133','���ֲ�','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040131','�ߴ�','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040146','���','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040138','������','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040119','����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040122','��Ǳ','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040104','��Խ','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040117','������','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040121','����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040103','����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040127','����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040150','�ܷ���','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040151','³��','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040136','�¿���','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040143','����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040141','����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040137','������','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040102','���ս�','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040149','������','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040125','����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040123','����ط','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040140','�����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040135','����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040116','������','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040114','����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040113','��˼˴','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040126','������','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040124','������','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040115','���','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040147','���и�','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040118','��Ǭ','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040129','��һ','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040152','������','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('1205040111','������','��','����','������Ա','06','080905',2013);


Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060235','��ԲԲ','Ů','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060236','�����','Ů','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060238','��Ө','Ů','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060240','����Ƽ','Ů','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060241','���Ө','Ů','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060242','��ӭ��','Ů','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060244','�¼���','Ů','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060245','·����','Ů','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060246','������','Ů','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060247','������','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060260','�ս�','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060261','����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060263','������','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060264','��˧','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060265','��ΰ','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060266','����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060267','��','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060269','�첩','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060271','���ǿ','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060273','����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060275','Ф�˾�','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060277','���','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060280','л���','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060281','��','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060282','����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060284','�','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060285','�ϻ��','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060286','����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060288','������','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060290','���S','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060291','���','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060292','���ĳ�','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060293','ë���','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060294','Ф����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060296','����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060298','�Ժ̲�','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060299','������','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431130151','��־��','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060237','�Ժ�÷','Ů','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060248','��ٻ','Ů','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060249','������','Ů','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060250','��ܰ��','Ů','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060251','������','Ů','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060252','κͮ','Ů','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060253','��ӱ','Ů','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060254','Ф����','Ů','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060255','��ޱ','Ů','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060256','�ܼ���','Ů','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060257','����ͩ','Ů','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060259','��ѩ','Ů','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060262','��֮��','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060300','κ��','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060301','����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060302','������','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060303','��׿��','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060304','�ַ���','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060306','л��','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060307','�����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060309','����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060310','��ά','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060311','�ƺ���','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060312','�Ʒ�','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060313','������','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060315','�ĺ�Ȼ','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060316','������','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060317','��̩','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060318','�¿���','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060319','˧˫ƽ','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060321','������','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060325','�����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060327','���','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060328','����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060329','�����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060330','�����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060331','�ֻ�','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060332','������','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060333','�����','��','����','������Ա','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060334','������','��','����','������Ա','06','080905',2013);


Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060544','��˼ά','Ů','1997-01-01','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060545','����Ƽ','Ů','1997-01-02','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060546','����','Ů','1997-01-03','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060547','κ�ں�','Ů','1997-01-04','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060548','֣��','Ů','1997-01-05','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060549','������','Ů','1997-01-06','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060550','����','Ů','1997-01-07','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060551','����ƽ','Ů','1997-01-08','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060552','������','Ů','1997-01-09','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060553','���','��','1997-01-10','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060554','�����','��','1997-01-11','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060555','�ϴ�Ԣ','��','1997-01-12','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060556','�����','��','1997-01-13','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060557','Ƚ���','��','1997-01-14','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060559','����ǿ','��','1997-01-15','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060560','����','��','1997-01-16','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060561','������','��','1997-01-17','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060562','��ά��','��','1997-01-18','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060563','������','��','1997-01-19','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060564','��ҫ��','��','1997-01-20','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060565','Ѧ��','��','1997-01-21','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060566','�����','��','1997-01-22','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060567','�Ŵ�','��','1997-01-23','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060568','���ַ�','��','1997-01-24','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060569','Ƥ����','��','1997-01-25','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060570','ʯ��','��','1997-01-26','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060571','�״���','��','1997-01-27','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060572','����','��','1997-01-28','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060573','���Ѳ�','��','1997-01-29','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060574','л����','��','1997-01-30','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060575','������','Ů','1997-01-31','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060576','����','Ů','1997-02-01','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060577','����ƽ','Ů','1997-02-02','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060578','��ŵӱ','Ů','1997-02-03','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060579','������','Ů','1997-02-04','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060580','������','Ů','1997-02-05','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060581','��ѩ��','Ů','1997-02-06','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060582','��ѩ÷','Ů','1997-02-07','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060583','��С��','Ů','1997-02-08','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060584','Ф����','��','1997-02-09','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060585','�²���','��','1997-02-10','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060586','ף��','��','1997-02-11','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060587','��Ȩ','��','1997-02-12','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060588','������','��','1997-02-13','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060589','���κ�','��','1997-02-14','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060590','�����','��','1997-02-15','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060591','����','��','1997-02-16','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060592','������','��','1997-02-17','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060593','����','��','1997-02-18','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060594','����','��','1997-02-19','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060595','����ǿ','��','1997-02-20','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060596','��ΰ��','��','1997-02-21','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060597','���','��','1997-02-22','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060598','��־��','��','1997-02-23','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060599','������','��','1997-02-24','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060600','Ҧѩ��','��','1997-02-25','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060601','����','��','1997-02-26','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060602','������','��','1997-02-27','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060603','¬����','��','1997-01-01','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060604','������','��','1997-01-02','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060605','�ả','��','1997-01-03','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('1105010105','�','Ů','1997-01-04','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060606 ','����','Ů','1997-01-05','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060607 ','����','Ů','1997-01-06','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060608 ','��ܲ��','Ů','1997-01-07','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060609 ','�����','Ů','1997-01-08','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060610 ','����','Ů','1997-01-09','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060611 ','�쾲','Ů','1997-01-10','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060612 ','����','Ů','1997-01-11','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060613 ','��˼��','Ů','1997-01-12','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060614 ','������','Ů','1997-01-13','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060615 ','��С��','��','1997-01-14','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060616 ','��Ƽ','��','1997-01-15','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060617 ','��ΰ','��','1997-01-16','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060618 ','��С��','��','1997-01-17','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060619 ','��ʥ��','��','1997-01-18','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060620 ','�ƹ�ʥ','��','1997-01-19','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060621 ','��׿��','��','1997-01-20','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060622 ','���','��','1997-01-21','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060623 ','֣ΰ','��','1997-01-22','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060624 ','���p��','��','1997-01-23','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060625 ','������','��','1997-01-24','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060626 ','�Ž���','��','1997-01-25','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060627 ','����','��','1997-01-26','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060628 ','����','��','1997-01-27','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060629 ','���ʽ�','��','1997-01-01','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060630 ','����','��','1997-01-02','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060631 ','������','��','1997-01-03','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060632 ','�����','��','1997-01-04','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060633 ','���ɰ�','��','1997-01-05','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060634 ','�ܳ�','��','1997-01-06','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060635 ','������','��','1997-01-07','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060636 ','����Ȼ','��','1997-01-08','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060637 ','֣����','Ů','1997-01-09','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060638 ','����','Ů','1997-01-10','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060639 ','������','Ů','1997-01-11','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060640 ','������','Ů','1997-01-12','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060641 ','��ѩ','Ů','1997-01-13','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060642 ','��ܲ�','Ů','1997-01-14','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060643 ','����','Ů','1997-01-15','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060644 ','л����','Ů','1997-01-16','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060645 ','������','Ů','1997-01-17','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060646 ','��һ��','��','1997-01-18','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060647 ','��ǰ��','��','1997-01-19','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060648 ','��','��','1997-01-20','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060649 ','������','��','1997-01-21','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060650 ','������','��','1997-01-22','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060651 ','�¿���','��','1997-01-23','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060652 ','����','��','1997-01-24','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060653 ','�˿�','��','1997-01-25','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060654 ','��־��','��','1997-01-26','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060655 ','�����','��','1997-01-27','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060656 ','��Ȼ','��','1997-01-28','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060657 ','������','��','1997-01-29','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060658 ','�Ӽһ�','��','1997-01-30','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060659 ','ëΰة','��','1997-01-31','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060660 ','����','��','1997-02-01','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060661 ','�⺣��','��','1997-02-02','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060662 ','����','��','1997-02-03','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060663 ','̷��','��','1997-02-04','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060664 ','���','��','1997-02-05','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060665 ','������','��','1997-02-06','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060666 ','������','��','1997-02-07','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060667 ','��ɭ','��','1997-02-08','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060668 ','������','��','1997-02-09','����','������Ա','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060669 ','�����','��','1997-02-10','����','������Ա','06','080905',2015);

Insert into Score Values('201531060545','9812202040',57.0 ,6,'2017-6-30');
Insert into Score Values('201531060546','9812202040',60.3 ,6,'2017-6-30');
Insert into Score Values('201531060547','9812202040',54.4 ,6,'2017-6-30');
Insert into Score Values('201531060548','9812202040',54.0 ,6,'2017-6-30');
Insert into Score Values('201531060549','9812202040',99.0 ,6,'2017-6-30');
Insert into Score Values('201531060550','9812202040',82.9 ,6,'2017-6-30');
Insert into Score Values('201531060551','9812202040',61.4 ,6,'2017-6-30');
Insert into Score Values('201531060552','9812202040',86.3 ,6,'2017-6-30');
Insert into Score Values('201531060553','9812202040',58.0 ,6,'2017-6-30');
Insert into Score Values('201531060554','9812202040',98.0 ,6,'2017-6-30');
Insert into Score Values('201531060555','9812202040',70.9 ,6,'2017-6-30');
Insert into Score Values('201531060556','9812202040',58.6 ,6,'2017-6-30');
Insert into Score Values('201531060557','9812202040',51.3 ,6,'2017-6-30');
Insert into Score Values('201531060559','9812202040',83.1 ,6,'2017-6-30');
Insert into Score Values('201531060560','9812202040',92.2 ,6,'2017-6-30');
Insert into Score Values('201531060561','9812202040',89.8 ,6,'2017-6-30');
Insert into Score Values('201531060562','9812202040',64.2 ,6,'2017-6-30');
Insert into Score Values('201531060563','9812202040',70.6 ,6,'2017-6-30');
Insert into Score Values('201531060564','9812202040',95.3 ,6,'2017-6-30');
Insert into Score Values('201531060565','9812202040',83.4 ,6,'2017-6-30');
Insert into Score Values('201531060566','9812202040',91.0 ,6,'2017-6-30');
Insert into Score Values('201531060567','9812202040',67.2 ,6,'2017-6-30');
Insert into Score Values('201531060568','9812202040',92.2 ,6,'2017-6-30');
Insert into Score Values('201531060569','9812202040',82.8 ,6,'2017-6-30');
Insert into Score Values('201531060570','9812202040',61.7 ,6,'2017-6-30');
Insert into Score Values('201531060571','9812202040',99.8 ,6,'2017-6-30');
Insert into Score Values('201531060572','9812202040',64.7 ,6,'2017-6-30');
Insert into Score Values('201531060573','9812202040',71.6 ,6,'2017-6-30');
Insert into Score Values('201531060574','9812202040',63.1 ,6,'2017-6-30');
Insert into Score Values('201531060575','9812202040',50.8 ,6,'2017-6-30');
Insert into Score Values('201531060576','9812202040',63.1 ,6,'2017-6-30');
Insert into Score Values('201531060577','9812202040',88.8 ,6,'2017-6-30');
Insert into Score Values('201531060578','9812202040',91.3 ,6,'2017-6-30');
Insert into Score Values('201531060579','9812202040',64.5 ,6,'2017-6-30');
Insert into Score Values('201531060580','9812202040',55.6 ,6,'2017-6-30');
Insert into Score Values('201531060581','9812202040',77.3 ,6,'2017-6-30');
Insert into Score Values('201531060582','9812202040',89.3 ,6,'2017-6-30');
Insert into Score Values('201531060583','9812202040',95.5 ,6,'2017-6-30');
Insert into Score Values('201531060584','9812202040',73.4 ,6,'2017-6-30');
Insert into Score Values('201531060585','9812202040',79.8 ,6,'2017-6-30');
Insert into Score Values('201531060586','9812202040',62.6 ,6,'2017-6-30');
Insert into Score Values('201531060587','9812202040',63.7 ,6,'2017-6-30');
Insert into Score Values('201531060588','9812202040',93.7 ,6,'2017-6-30');
Insert into Score Values('201531060589','9812202040',63.3 ,6,'2017-6-30');
Insert into Score Values('201531060590','9812202040',70.7 ,6,'2017-6-30');
Insert into Score Values('201531060591','9812202040',87.1 ,6,'2017-6-30');
Insert into Score Values('201531060592','9812202040',87.5 ,6,'2017-6-30');
Insert into Score Values('201531060593','9812202040',58.5 ,6,'2017-6-30');
Insert into Score Values('201531060594','9812202040',52.3 ,6,'2017-6-30');
Insert into Score Values('201531060595','9812202040',64.5 ,6,'2017-6-30');
Insert into Score Values('201531060596','9812202040',92.1 ,6,'2017-6-30');
Insert into Score Values('201531060597','9812202040',79.2 ,6,'2017-6-30');
Insert into Score Values('201531060598','9812202040',52.3 ,6,'2017-6-30');
Insert into Score Values('201531060599','9812202040',70.3 ,6,'2017-6-30');
Insert into Score Values('201531060600','9812202040',80.3 ,6,'2017-6-30');
Insert into Score Values('201531060601','9812202040',51.3 ,6,'2017-6-30');
Insert into Score Values('201531060602','9812202040',51.5 ,6,'2017-6-30');
Insert into Score Values('201531060603','9812202040',75.2 ,6,'2017-6-30');
Insert into Score Values('201531060604','9812202040',56.5 ,6,'2017-6-30');
Insert into Score Values('201531060605','9812202040',62.9 ,6,'2017-6-30');
Insert into Score Values('1105010105','9812202040',73.6 ,6,'2017-6-30');
Insert into Score Values('201531060606 ','9812202040',50.7 ,6,'2017-6-30');
Insert into Score Values('201531060607 ','9812202040',68.7 ,6,'2017-6-30');
Insert into Score Values('201531060608 ','9812202040',89.7 ,6,'2017-6-30');
Insert into Score Values('201531060609 ','9812202040',89.2 ,6,'2017-6-30');
Insert into Score Values('201531060610 ','9812202040',52.5 ,6,'2017-6-30');
Insert into Score Values('201531060611 ','9812202040',60.9 ,6,'2017-6-30');
Insert into Score Values('201531060612 ','9812202040',52.5 ,6,'2017-6-30');
Insert into Score Values('201531060613 ','9812202040',95.0 ,6,'2017-6-30');
Insert into Score Values('201531060614 ','9812202040',94.9 ,6,'2017-6-30');
Insert into Score Values('201531060615 ','9812202040',85.7 ,6,'2017-6-30');
Insert into Score Values('201531060616 ','9812202040',89.2 ,6,'2017-6-30');
Insert into Score Values('201531060617 ','9812202040',98.1 ,6,'2017-6-30');
Insert into Score Values('201531060618 ','9812202040',85.5 ,6,'2017-6-30');
Insert into Score Values('201531060619 ','9812202040',73.8 ,6,'2017-6-30');
Insert into Score Values('201531060620 ','9812202040',70.3 ,6,'2017-6-30');
Insert into Score Values('201531060621 ','9812202040',75.2 ,6,'2017-6-30');
Insert into Score Values('201531060622 ','9812202040',90.2 ,6,'2017-6-30');
Insert into Score Values('201531060623 ','9812202040',80.2 ,6,'2017-6-30');
Insert into Score Values('201531060624 ','9812202040',61.0 ,6,'2017-6-30');
Insert into Score Values('201531060625 ','9812202040',67.1 ,6,'2017-6-30');
Insert into Score Values('201531060626 ','9812202040',68.2 ,6,'2017-6-30');
Insert into Score Values('201531060627 ','9812202040',70.5 ,6,'2017-6-30');
Insert into Score Values('201531060628 ','9812202040',77.5 ,6,'2017-6-30');
Insert into Score Values('201531060629 ','9812202040',72.9 ,6,'2017-6-30');
Insert into Score Values('201531060630 ','9812202040',65.6 ,6,'2017-6-30');
Insert into Score Values('201531060631 ','9812202040',69.8 ,6,'2017-6-30');
Insert into Score Values('201531060632 ','9812202040',84.3 ,6,'2017-6-30');
Insert into Score Values('201531060633 ','9812202040',79.7 ,6,'2017-6-30');
Insert into Score Values('201531060634 ','9812202040',95.3 ,6,'2017-6-30');
Insert into Score Values('201531060635 ','9812202040',65.3 ,6,'2017-6-30');
Insert into Score Values('201531060636 ','9812202040',66.7 ,6,'2017-6-30');
Insert into Score Values('201531060637 ','9812202040',55.8 ,6,'2017-6-30');
Insert into Score Values('201531060638 ','9812202040',82.8 ,6,'2017-6-30');
Insert into Score Values('201531060639 ','9812202040',97.5 ,6,'2017-6-30');
Insert into Score Values('201531060640 ','9812202040',80.4 ,6,'2017-6-30');
Insert into Score Values('201531060641 ','9812202040',67.5 ,6,'2017-6-30');
Insert into Score Values('201531060642 ','9812202040',51.1 ,6,'2017-6-30');
Insert into Score Values('201531060643 ','9812202040',92.6 ,6,'2017-6-30');
Insert into Score Values('201531060644 ','9812202040',55.3 ,6,'2017-6-30');
Insert into Score Values('201531060645 ','9812202040',83.7 ,6,'2017-6-30');
Insert into Score Values('201531060646 ','9812202040',63.9 ,6,'2017-6-30');
Insert into Score Values('201531060647 ','9812202040',97.5 ,6,'2017-6-30');
Insert into Score Values('201531060648 ','9812202040',65.5 ,6,'2017-6-30');
Insert into Score Values('201531060649 ','9812202040',82.4 ,6,'2017-6-30');
Insert into Score Values('201531060650 ','9812202040',70.3 ,6,'2017-6-30');
Insert into Score Values('201531060651 ','9812202040',96.3 ,6,'2017-6-30');
Insert into Score Values('201531060652 ','9812202040',83.8 ,6,'2017-6-30');
Insert into Score Values('201531060653 ','9812202040',73.6 ,6,'2017-6-30');
Insert into Score Values('201531060654 ','9812202040',77.2 ,6,'2017-6-30');
Insert into Score Values('201531060655 ','9812202040',69.7 ,6,'2017-6-30');
Insert into Score Values('201531060656 ','9812202040',87.1 ,6,'2017-6-30');
Insert into Score Values('201531060657 ','9812202040',85.2 ,6,'2017-6-30');
Insert into Score Values('201531060658 ','9812202040',80.8 ,6,'2017-6-30');
Insert into Score Values('201531060659 ','9812202040',72.5 ,6,'2017-6-30');
Insert into Score Values('201531060660 ','9812202040',62.8 ,6,'2017-6-30');
Insert into Score Values('201531060661 ','9812202040',65.4 ,6,'2017-6-30');
Insert into Score Values('201531060662 ','9812202040',86.3 ,6,'2017-6-30');
Insert into Score Values('201531060663 ','9812202040',98.8 ,6,'2017-6-30');
Insert into Score Values('201531060664 ','9812202040',65.3 ,6,'2017-6-30');
Insert into Score Values('201531060665 ','9812202040',84.5 ,6,'2017-6-30');
Insert into Score Values('201531060666 ','9812202040',57.7 ,6,'2017-6-30');
Insert into Score Values('201531060667 ','9812202040',53.6 ,6,'2017-6-30');
Insert into Score Values('201531060668 ','9812202040',69.4 ,6,'2017-6-30');
Insert into Score Values('201531060669 ','9812202040',88.7 ,6,'2017-6-30');

print  CONVERT(varchar(100), GETDATE(), 121)+' �ɹ��������ݿ�'
print '���ݽ��޽�ѧʹ�ã���ע�Ᵽ��'

select *  from student

