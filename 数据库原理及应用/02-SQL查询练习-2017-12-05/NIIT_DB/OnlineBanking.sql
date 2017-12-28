--2003-09-07 22:56 周永更正


--创建数据库
set nocount    on
USE master

if exists (select * from sysdatabases where name='OnlineBanking')
begin
  raiserror('Dropping existing OnlineBanking database ....',0,1)
  DROP database OnlineBanking
end
GO


raiserror('Creating OnlineBanking database....',0,1)
CREATE DATABASE OnlineBanking
GO

--创建结构
--2003-09-07 12:24
use OnlineBanking

print 'current database is OnlineBanking'

print 'Users'
Create table Users(
vLoginId varchar(10) constraint pkLogin Primary Key,
vEmployeeID varchar(10) not null,
vPassword Varchar(16),
cRole char(10))

print 'AccountType'
Create table AccountType(
cAccountType char(5) constraint pkAccount Primary Key,
vDescription varchar(15),
mMinimumBalance money,
fRate float)

print 'Customer'
Create table Customer(
cAccountNumber  char(10) constraint pkcustomer Primary key,
vFirstName varchar(20) not null,
vLastName varchar(20) not null,
vOfficeAddress varchar(50),
vHomeAddress varchar(50),
dDateOfBirth datetime,
cAccountType char(5) Foreign key references AccountType(cAccountType),
cGender char(1),
vEmail varchar(40),
cOfficePhone char(15),
cHomePhone char(15),
mBalance money,
cAccessCode char(10),
dDateOpened datetime,
vDigitalSign varchar(120),
vCustomerPicture  varchar(120),
cATMCardNumber char(16),
dExpiryDate datetime
)

print 'CheckBookDetails'
Create table CheckBookDetails(
cCheckBookNumber char(10) constraint pkCheckBookNumber Primary Key,
cAccountNumber char(10) Foreign key references Customer(cAccountNumber),
dDateIssued datetime,
cStartNumber char(10))

print 'StopPayment'
Create table StopPayment(
cCheckNumber char(10) constraint pkCheckNo Primary Key,
cAccountNumber  char(10) Foreign key references Customer(cAccountNumber),
vInstructions varchar(100))

print 'CustomerQuery'
Create table CustomerQuery(
vQueryID varchar(10)  constraint pkCustQuery Primary Key,
cAccountNumber char(10) Foreign key references Customer(cAccountNumber),
vQuery varchar(100) not null,
cStatus char(5),
dDateReceived datetime)

print 'Trans'
create table Trans(
iTransactionId  integer identity,
dTransactionDate datetime,
cTransactionType char(15),
cTransactionMode char(15),
cFromAccountNumber char(10)Foreign key references Customer(cAccountNumber),
cToAccountNumber char(10)Foreign key references Customer(cAccountNumber),
cCheckNumber char(10),
mAmount money,
cStatus char(5))

go

create trigger trgInsertCustomer on Customer
for insert 
as
begin

declare @cServerName char(20)
declare @cPicsPath char(30)

select @cServerName=@@servername
select @cPicsPath='\\'+@@servername+'\Images\'

update Customer
set Customer.vCustomerPicture=inserted.vCustomerPicture
from Customer,inserted
where inserted.cAccountNumber=Customer.cAccountNumber

update Customer
set Customer.vDigitalSign=inserted.vDigitalSign
from Customer,inserted
where inserted.cAccountNumber=Customer.cAccountNumber

end
go

create trigger trgUpdateCustomer on Customer
for update
as

declare @cServerName char(20)
declare @cPicsPath char(30)

select @cServerName=@@servername
select @cPicsPath='\\'+@@servername+'\Images\'
if update(vCustomerPicture)
begin
update Customer
set vCustomerPicture=rtrim(ltrim(@cPicsPath))+rtrim(ltrim(inserted.vCustomerPicture))
from Customer,inserted
where inserted.cAccountNumber=Customer.cAccountNumber
end
if update(vdigitalsign)
begin
update Customer
set Customer.vDigitalSign=rtrim(ltrim(@cPicsPath))+rtrim(ltrim(inserted.vDigitalSign))
from Customer,inserted
where inserted.cAccountNumber=Customer.cAccountNumber
end

go



CREATE TRIGGER trgTransIns  ON Trans 
FOR INSERT
AS update trans 
set dTransactionDate=getdate()
from trans,inserted
where trans.itransactionid = inserted.itransactionid
go

--添加数据
use OnlineBanking
go

insert into AccountType values('SA','SavingsAccount',1,0.8)
insert into AccountType values('CA','CheckingAccount',200,2.9)
insert into AccountType values('CD','CertofDeposit',5000,5.7)

insert Customer values('C0006','Charles','Brown',null,'16223,Radiance Court,Kansas City ,Kansas','10/12/1947','SA','M','charlesb@speedmail.com' ,'(785)877-2344', '(785)877-2363', 50000, '23336', '05/03/1998','6sign.jpg','6photo.bmp','4102820121606859',null)
insert Customer values('C0007','Christopher','Davis',null,'7765 La Cienega St,Las Vegas,Nevada','10/14/1956','SA','M','Christopherd@hotmail.com','(702)263-0704','(702)263-0724', 53200, '277980', '05/12/1998','7sign.jpg','7photo.bmp','4060444256058248',null)
insert Customer values('C0008','Cynthia','Miller',null,'5614 Raffle Court,Las Vegas,Nevada','06/15/1970','SA','F','Cynthiam@yahoo.com'    ,'(702)678-3458','(702)234-8764 ', 64000,  '355673', '05/16/1998','8sign.jpg','8photo.bmp','4024622762528540',null)
insert Customer values('C0009','Daniel','Wilson',null,'Fleet Street,New York City,New York','8/18/1959','SA','M','danielw@mailtag.com' ,'(212)585-7796 ','(212)856-3756', 23500,  '40561','05/19/1998','9sign.jpg','9photo.bmp','4444260746268008',null)
insert Customer values('C0010','David','Moore',null,'8808 Joviality Drive,San Ramon,California','3/12/1965','SA','M','davidm@angelfire.com' ,'(619)456-9032', '(619)656-1044',45000,'5000','05/19/1998','10sign.jpg','10photo.bmp','4102104675035611',null)

insert into StopPayment values('745235 ','C0009','Stop the payment on this cheque')
insert into StopPayment values('233567 ','C0006','Stop encashment')
insert into StopPayment values('456321 ','C0007','Stop Payment')
insert into StopPayment values('565332 ','C0008','Stop encashment')
insert into StopPayment values('978544 ','C0007','Stop Payment')


insert into Trans(dTransactionDate,cTransactionType,cTransactionMode,cFromAccountNumber,cToAccountNumber,cCheckNumber,mAmount,cStatus) values ('6/28/1998','Deposit','Cash',null,'C0007',null,2500,'C')
insert into Trans(dTransactionDate,cTransactionType,cTransactionMode,cFromAccountNumber,cToAccountNumber,cCheckNumber,mAmount,cStatus) values('6/29/1998','Deposit','Check',null,'C0008','543254',4000,'P')
insert into Trans(dTransactionDate,cTransactionType,cTransactionMode,cFromAccountNumber,cToAccountNumber,cCheckNumber,mAmount,cStatus) values('6/30/1998','Tranfer',null,'C0006','C0008',null,18000,'C')
insert into Trans(dTransactionDate,cTransactionType,cTransactionMode,cFromAccountNumber,cToAccountNumber,cCheckNumber,mAmount,cStatus) values('7/1/1998','Withdrawl','Cash','C0009',null,'764545',3200,'C')
insert into Trans(dTransactionDate,cTransactionType,cTransactionMode,cFromAccountNumber,cToAccountNumber,cCheckNumber,mAmount,cStatus) values('7/2/1998','Withdrawl','DD','C0007',null,null,1500,'C')



insert into CheckBookDetails values('1001','C0006','5/6/1998','230001')
insert into CheckBookDetails values('1026','C0007','5/13/1998','422001')
insert into CheckBookDetails values('1045','C0009','5/18/1998','246001')


insert into Users values('CarolT','E1121','kingkong','Teller')
insert into Users values('MikeJ','E2112','Antartica','Manager')
insert into Users values('RupertR','E4334','Veronica','AsstMgr')

insert into CustomerQuery values('Q0201','C0007','What is the minimum balance for a checking account?','R','7/4/1999')
insert into CustomerQuery values('Q0202','C0009','My login is deactivated. Kindly Activate','P','7/30/1999')




--打印成功信息
raiserror('◆Database OnlineBanking is now ready for use◆ Author:Mr.Zhou ver:2003-09-07',0,1)