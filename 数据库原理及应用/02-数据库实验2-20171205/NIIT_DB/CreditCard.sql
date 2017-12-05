--2003-09-07 23:06 周永更正


--创建数据库
set nocount    on
USE master

if exists (select * from sysdatabases where name='CreditCard')
begin
  raiserror('Dropping existing CreditCard database ....',0,1)
  DROP database CreditCard
end
GO


raiserror('Creating CreditCard database....',0,1)
CREATE DATABASE CreditCard
GO

--创建结构
--2003-09-07 
use CreditCard
print 'current database is CreditCard'
go

print 'CardDetails'
create table CardDetails
(cCardNumber char(16) not null,
cPersonalIdentificationNumber char(6) not null)

--添加数据
insert CardDetails values('4108422514026425','659764')
insert CardDetails values('4368605856355585','659742')
insert CardDetails values('4644222033517404','618256')
insert CardDetails values('4303302731787012','642517')
insert CardDetails values('4351317038543307','621863')
insert CardDetails values('4476626724844609','669803')
insert CardDetails values('5163456353185148','671895')
insert CardDetails values('5163456353185149','628597')
insert CardDetails values('5456087240507488','621347')
insert CardDetails values('5412065266722259','669803')
insert CardDetails values('5474780667575057','671046')
insert CardDetails values('5516500430085238','665219')
insert CardDetails values('5537673085244502','622197')

--打印成功信息
raiserror('◆Database CreditCard is now ready for use◆ Author:Mr.Zhou ver:2003-09-07',0,1)