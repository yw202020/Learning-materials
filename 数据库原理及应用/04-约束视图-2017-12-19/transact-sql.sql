--����:ʯ��
--����:2017-12-19 17:13

--(1)	ʹ��Transact-SQL��䴴��STUDENT���ݿ⡣
USE master
--�������STUDENT���ݿ���ɾ��
if exists (select * from sysdatabases where name='STUDENT')
begin
	DROP database STUDENT
end
GO
Create Database STUDENT;
Go
Use STUDENT
Go
--(2)	ʹ��Transact-SQL��䴴��STUDENT���ݿ���������б�
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
--Course��Լ��
Alter Table Course Add Constraint CK_Credit Check(Credit>0);
Alter Table Course Add Constraint CK_Semster Check(Semster>0);
Alter Table Course Add Constraint CK_Period Check(Period>0);
--Student��Լ��
Alter Table Student Add Constraint CK_Ssex Check(Ssex in ('��','Ů'));
Alter Table Student Add Constraint CK_Sage Check(Sage Between 15 and 45);
Alter Table Student Add Constraint DF_Sdept Default '�����ϵ' For Sdept;
--SC��Լ��
Alter Table Sc Add Constraint CK_Grade Check(Grade Between 0 and 100);
Go

--(3)	ʹ��Transact-SQL��䴴��STUDENT���ݿ����������������Լ��������
--Course������Լ��
Alter Table Course Add Constraint PK_Course Primary Key (Cno);
--Student������Լ��
Alter Table Student Add Constraint PK_Student Primary Key (Sno);
--SC������Լ��
Alter Table SC Add Constraint PK_SC Primary Key (Cno,Sno);
--SC�����Լ��
Alter Table SC Add Constraint FK_SC_Course Foreign Key (Cno) References Course(Cno);
Alter Table SC Add Constraint FK_SC_Student Foreign Key (Sno) References Student(Sno);
Go


--(4)	ʹ��Transact-SQL�����STUDENT���ݿ��ﴴ����ͼ��ע�⣺�����¸���С���У�������Ŀ��������ǰ����Ŀ��������ͼ����
--��	��Ϣϵѧ������ͼFIRSTVIEW��
Create View FIRSTVIEW
As
Select * From Student Where Sdept = '��Ϣϵ';
Go
--��	����ѧ��Ϊ4ѧ�ֵĿγ���ͼSECONDVIEW��
Create View SECONDVIEW
As
Select * From Course Where Credit=4;
--��	ɾ������������������һ����ͼSECONDVIEW��
Go
Drop View SECONDVIEW;


--(5)	ʹ��Transact-SQL���Ա���ӡ��޸ġ�ɾ�����ݡ�
--��	��������
--��Course���в���һ�����ݣ���c07������Ӧ��ͳ�ơ���3��4��54����
Insert into Course Values('c07','Ӧ��ͳ��',3,4,54);
Go
--��	�޸�����
--��Student��������ѧ�������䶼��Ϊ20��
Update Student Set Sage='20';
Go
--��	ɾ������
--ɾ���ɼ���Ϣ����ѧ��Ϊ0750122����Ϣ��
Delete From SC Where Sno = '0750122';