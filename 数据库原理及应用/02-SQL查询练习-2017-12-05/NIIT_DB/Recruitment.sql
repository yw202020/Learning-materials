/*  →→→→→→→→→→→→→→→→★老实做人★周到办事★→→→→→→→→
用途:创建NIIT教学所用Recruitment数据库
作者:● 周永 ● Justhelp@163.com
日期:2002--11--07 10:00PM
←←←←←←←←★五陵寒松★荣辱与共★←←←←←←←←←←←←←←←←  */

/*      Install Recruitment database             */

set nocount    on
USE master
declare @dttm varchar(55)
select  @dttm=convert(varchar,getdate(),113)
raiserror('Starting installation of Recruitment Database at %s ....',1,1,@dttm) with nowait
--set dateformat mdy
GO
--sp_addlogin user1,null,Recruitment
if exists (select * from sysdatabases where name='Recruitment')
begin
  raiserror('Dropping existing Recruitment database ....',0,1)
  DROP database Recruitment
end
GO

CHECKPOINT
go

raiserror('Creating Recruitment database....',0,1)
go

   create DATABASE Recruitment
GO

CHECKPOINT

GO

USE Recruitment

GO

if db_name() <> 'Recruitment'
   raiserror('Error in installRecruitment.SQL, "USE Recruitment" failed!  Killing the SPID now.'
            ,22,127) with log

GO

execute sp_dboption 'Recruitment','trunc. log on chkpt.' ,'true'
checkpoint





--★★★以上是创建数据库的代码■■■
--★★★以下是创建表及添加数据的代码■■■




USE Recruitment
go
/* -- Creating Objects for Recruitment */

raiserror('Now at the create table section ....',0,1)
Go

raiserror('Creating RecruitmentUsers....',0,1)
create table Recruitmentusers
(
	cUserName char(10),
	cPassword char(10)
)
raiserror('Creating  Department....',0,1)
create table Department
(
	cDepartmentCode	char(4) constraint dt_pk primary key,
	vDepartmentName	varchar(25) ,
	vDepartmentHead varchar(25),
	vLocation	varchar(20)
)
raiserror('Creating  Position....',0,1)
create table Position
(
	cPositionCode	char(4) constraint ptv_pk primary key,
	vDescription	varchar(35),
	iBudgetedStrength	int,
	siYear		smallint,
	iCurrentStrength int
)
go
------

raiserror('Creating  Country....',0,1)
create table Country
(
	cCountryCode	char(3) constraint c_pk primary key,
	cCountry		char(35) not null,
)
go

raiserror('Creating  Newspaper....',0,1)
create table Newspaper
(
	cNewspaperCode	char(4) constraint np_pk primary key,
	cNewspaperName	char(20) not null,
	vRegion 	varchar(20),
	vTypeOfNewspaper varchar(20),
	vContactPerson 	varchar(35),
	vHOAddress	varchar(35),
	cCity		char(20),
	cState		char(20),
	cZip		char(10) constraint nzp_ck check(cZip like('[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')),
	cCountryCode	char(3) references Country(cCountryCode),
	cFax		char(15)constraint npf_ck check(cFax like('([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')),
	cPhone 		char(15) constraint npp_ck check(cPhone like('([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')),
)
go 

raiserror('Creating  NewsAd....',0,1)
create table NewsAd
(
	cNewsAdNo	char(4) constraint nat_pk primary key,
	cNewspaperCode	char(4) references Newspaper(cNewspaperCode),
	dAdStartDate	datetime,
	dDeadline	datetime
)
go

raiserror('Creating  JobFair....',0,1)
create table JobFair
(
	cJobFairCode	char(4) constraint jft_pk primary key ,
	vLocation	varchar(35),
	vJobFairCompany	varchar(40),
	mFee		money,
	dFairDate	datetime
)
go


raiserror('Creating  ContractRecruiter....',0,1)
create table ContractRecruiter
(
	cContractRecruiterCode	char(4) constraint crtp_pk primary key,
	cName		char(35),
	vAddress	varchar(35),
	cCity		char(20),
	cState		char(15),
	cZip		char(10) constraint crzp_ck check(cZip like('[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')) ,

	cFax		char(15)constraint crf_ck check(cFax like('([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')),
	cPhone 		char(15) constraint crp_ck check(cPhone like('([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')),
	siPercentageCharge	smallint,
	mTotalPaid	money
)
go
raiserror('Creating  RecruitmentAgencies....',0,1)

create table RecruitmentAgencies
(
	cAgencyCode	char(4) constraint rat_pk primary key,
	cName		char(20),
	vAddress	varchar(35),
	cCity		char(15),
	cState 		char(15),
	cZip		char(10),
	cPhone 		char(15) constraint rap_ck check(cPhone like('([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')),
	cFax		char(15)constraint raf_ck check(cFax like('([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')),
	siPercentageCharge	smallint,
	mTotalPaid	money,
)
go 

raiserror('Creating  College....',0,1)
create table College
(
	cCollegeCode	char(4) constraint ct_pk primary key,
	cCollegeName	char(30) not null,
	vCollegeAddress varchar(35),
	cCity 		char(20),
	cState		char(20),
	cZip		char(10) constraint czp_ck check(cZip like('[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')),
	cPhone		char(15) constraint cph_ck check(cPhone like('([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'))
)

raiserror('Creating  CampusRecruitment....',0,1)
create table CampusRecruitment
(
	cCampusRecruitmentCode	char(4) constraint cr_pk primary key,
	cCollegeCode	char(4) references College(cCollegeCode),
	dRecruitmentStartDate	datetime,
	dRecruitmentEndDate 	datetime
)
go


raiserror('Creating  InternalJobPosting....',0,1)
create table InternalJobPosting
(
	cInternalJobPostingCode	char(4) constraint ijp_pk primary key,
	cPositionCode	char(4), /* references,  Position(cPositionCode), */
	siNoOfVacancies	smallint not null,
	vRegion		varchar(20),
	dNoticeReleaseDate 	datetime not null,
	dDeadline	datetime
)
go

raiserror('Creating  InternalCandidate....',0,1)
create table InternalCandidate
(
	cCandidateCode 	char(6) ,
	cEmployeeCode	char(6), 
	cInternalJobPostingCode	char(4) references InternalJobPosting(cInternalJobPostingCode),
	cPositionCodeAppliedFor	char(4) references Position(cPositionCode) ,
	dDateOfApplication	datetime,
	dTestDate	datetime,
	siTestScore	smallint,
	dInterviewDate	datetime,
	cInterviewer	char(25),
	vInterviewComments	varchar(256),
	cRating		char,
	cStatus		char,
	constraint ict_pk primary key(cCandidateCode,cEmployeeCode,cInternalJobPostingCode)
)
go

raiserror('Creating  Employees....',0,1)
create table Employee
(
	cEmployeeCode	char(6) constraint etv_pk primary key,
	vFirstName	varchar(20),
	vLastName	varchar(20),
	cCandidateCode	char(6),
	vAddress	varchar(35),
	cCity		char(20),
	cState		char(20),
	cZip		char(10) constraint ezp_ck check(cZip like('[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')),
	cCountryCode	char(3) references Country(cCountryCode),
	cPhone		char(15) constraint eph_ck check(cPhone like('([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')),
	vQualification	varchar(20),
	dBirthDate	datetime,
	cSex		char,
	cCurrentPosition	char(20),
	cDesignation	char(20),
	cEmailId	char(20),
	cDepartmentCode	char(4) references Department(cDepartmentCode),
	cRegion		char(20),
	imPhoto		image,
	dJoiningDate	datetime,
	dResignationDate	datetime,
	cSocialSecurityNo	char(15) unique,
	cSupervisorCode char(6)

)
go

raiserror('Creating  MonthlySalary....',0,1)
create table MonthlySalary
(
	cEmployeeCode	char(6)references Employee(cEmployeeCode),
	mMonthlySalary	money,
	dPayDate	datetime,
	mReferralBonus	money,
	constraint mst_pk primary key(cEmployeeCode,dPayDate)
)
go
raiserror('Creating  AnnualSalary....',0,1)
create table AnnualSalary
(
	cEmployeeCode	char(6) references Employee(cEmployeeCode),
	mAnnualSalary	money,
	siYear		smallint,
	constraint ast_pk primary key(cEmployeeCode,siYear)
)
go

raiserror('Creating  ExternalCandidate....',0,1)
create table ExternalCandidate
(
	cCandidateCode	char(6) constraint ectv_pk primary key,
	vFirstName	varchar(20),
	vLastName	varchar(20),
	vAddress	varchar(35),
	cCity		char(20),
	cState		char(15),
	cZip		char(10) constraint eczp_ck check(cZip like('[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')),
	cCountryCode	char(3) references Country(cCountryCode),
	cPhone		char(15) constraint ecp_ck check(cPhone like('([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')),
	cPositionCode	char(4) references Position(cPositionCode),
	dDateOfApplication	datetime,
	cEmployeeReferralNo	char(6),
	cNewsAdNo	char(4) references NewsAd(cNewsAdNo),
	cAgencyCode	char(4) references RecruitmentAgencies(cAgencyCode),
	cContractRecruiterCode	char(4) references ContractRecruiter(cContractRecruiterCode),
	cJobFairCode	char(4) references JobFair(cJobFairCode),
	cCampusRecruitmentCode	char(4) references  CampusRecruitment(cCampusRecruitmentCode),
	cExEmployeeCode		char(6),
	vQualification	varchar(20),
	siPrevWorkExperience	smallint,
	dBirthDate	datetime,
	cSex		char,
	cCollegeCode	char(4),
	mPrevAnnualSalary	money,
	imPhotograph	image,
	vEmailId	varchar(20),
	cStatus		char,
	dTestDate	datetime,
	siTestScore	smallint,
	dInterviewDate	datetime,
	cInterviewer	char(20),
	vInterviewComments	varchar(256),
	cRating		char
)
go

raiserror('Creating  EmployeeReferrals....',0,1)
create table EmployeeReferrals
(
	cEmployeeReferralNo	char(6) constraint ert_pk primary key,
	cEmployeeCode	char(6) references Employee(cEmployeeCode),
	cCandidateCode	char(6) references ExternalCandidate(cCandidateCode),
)
go

raiserror('Creating  Skill....',0,1)
create table Skill
(
	cSkillCode	char(4) constraint stv_pk primary key,
	vSkill		varchar(35)
)
go

raiserror('Creating  EmployeeSkill....',0,1)
create table EmployeeSkill
(
	cEmployeeCode	char(6) references Employee(cEmployeeCode),
	cSkillCode	char(4)references Skill(cSkillCode),
	constraint vest_pk primary key(cEmployeeCode,cSkillCode)
)
go

raiserror('Creating  Requisition....',0,1)
create table Requisition
(
	cRequisitionCode	char(6),
	cPositionCode   char(4)references position(cPositionCode),
	dDateofRequisition	datetime,
	dDeadline       datetime,
	cDepartmentCode	char(4),
	vRegion		varchar(20),
	siNoOfVacancy	smallint,
	constraint RTP_PK primary key(cRequisitionCode,cPositionCode)
)
go

raiserror('Creating  CandidateSkill....',0,1)
create table CandidateSkill
(
	cCandidateCode	char(6) references ExternalCandidate(cCandidateCode),
	cSkillCode	char(4) references Skill(cSkillCode),
	constraint sctv_pk primary key(cCandidateCode,cSkillCode)
)

raiserror('Creating  PositionSkill....',0,1)
create table PositionSkill
(
	cPositionCode	char(4) references Position(cPositionCode),
	cSkillCode	char(4) references Skill(cSkillCode),
	constraint pstv_pk primary key(cPositionCode,cSkillCode)
)

raiserror('Creating  Payment....',0,1)
create table Payment
(
	cSourceCode	char(6) ,
	mAmount		Money,
	cChequeNo	char(12),
	dDate		datetime,
	constraint tp_pks primary key(cSourceCode,cChequeNo,dDate)
)
go

raiserror('Inserting data in RecruitmentUsers table....',0,1)
insert into recruitmentusers values ('Sandra','Adams')
insert into recruitmentusers values ('William','Perez')
insert into recruitmentusers values ('David','Cooper')
go


raiserror('Inserting data in Department table....',0,1)
insert into department values('0001','Production','Samuel Moore','New York')
insert into department values('0002','Sales','Donald Fleming','Houston')
insert into department values('0003','Marketing','Sandra Hawkins','Addison')
insert into department values('0004','Human Resource','Bill Mayse','Abilene')
insert into department values('0005','Quality Assurance','Robin Dmello','Hampstead')
insert into department values('0007','Training','Will Smith','Columbus')
insert into department values('0008','Transportation','Dabb Mike','Columbus')
insert into department values('0009','Finance','Faber Michel','New Jersy')
insert into department values('0010','Inventory','Taber James','New Jersy')
go

raiserror('Inserting data in Position table....',0,1)
insert into position values('0001','Sales Manager',100,1997,82 )
insert into position values('0002','Maketing  Manager',100,1997,83 )
insert into position values('0003','Financial Analyst',50 ,1997,30 )
insert into position values('0004','Training Co-ord',20 ,1997,15 )
insert into position values('0005','Database Analyst',10 ,1997,8  )
insert into position values('0006','Staff Accountant',20 ,1997,18 )
insert into position values('0007','Audit Manager',20 ,1997,18 )
insert into position values('0008','Telephone Operator',20 ,1997,18 )
insert into position values('0009','Office Clerk',20 ,1997,18 )
insert into position values('0010','Legal Secretary',20 ,1997,18 )
insert into position values('0011','Administrative Assistant',20 ,1997,18 )
insert into position values('0012','Senior Receptionist',20 ,1997,18 )
insert into position values('0013','Consultant',20 ,1997,18 )
insert into position values('0014','Maintenance Technician',20 ,1997,18 )
insert into position values('0015','Receptionist',21,1997,18 )

go

raiserror('Inserting data in Country table....',0,1)
insert into Country values('001','United states of America')
insert into Country values('002','Albania')
insert into Country values('003','Andorra')
insert into Country values('004','Argentina')
insert into Country values('005','Austria')
insert into Country values('006','Bangladesh')
insert into Country values('007','Belgium')
insert into Country values('008','Bosnia & Herzegovina')
insert into Country values('009','Bulgaria')
insert into Country values('010','Czech Republic')
insert into Country values('011','Denmark')
insert into Country values('012','Yugoslavia ')
insert into country values('013','France')
insert into country values('014','Gibraltar')
insert into country values('015','Greece')
insert into country values('016','Georgia')
insert into country values('017','Croatia')
insert into country values('018','Estonia')
insert into country values('019','Iceland')
insert into country values('020','Italy')
insert into country values('021','Israel')
insert into country values('022','India')
insert into country values('023','Cyprus')
insert into country values('024','Russia')
insert into country values('025','Liechtenstein')
insert into country values('026','Great Britain')
insert into country values('027','Lithuania')
insert into country values('028','Luxembourg')
insert into country values('029','Yugoslavia')
insert into country values('030','Malta')
insert into country values('031','Moldova')
insert into country values('032','Monaco')
insert into country values('033','Netherlands')
insert into country values('034','Norway')
insert into country values('035','Poland')
insert into country values('036','Portugal')
insert into country values('037','Romania')
insert into country values('038','San Marino')
insert into country values('039','Slovak Republic')
insert into country values('040','Slovenia')
insert into country values('041','Finland')
insert into country values('042','Spain')
insert into country values('043','Switzerland')
insert into country values('044','Turkey')
insert into country values('045','Ukraine')
insert into country values('046','Hungary')
insert into country values('047','Germany')
insert into country values('048','Sweden')
insert into country values('049','Latvia')
insert into country values('050','India')
go
/* data for newspaper*/
raiserror('Inserting data in Newspaper table....',0,1)
insert into newspaper values('0001','Texas Times','Texas','General','Jackson Demello','4723 West Alabama','Houston','Texas','77015-4568','001','(713)451-6797','(713)451-6850')
insert into newspaper values('0002','Bussiness Journal','Norton','Bussiness','Pamela Desouza','900 N State St Norton','Norton','Kansas','76754-2219','001','(785)877-2344','(785)877-2363')
insert into newspaper values('0003','Daily News','Mentor','General','Jack Miller','4896 11th ST Hill Avenue','Mentor','Ohio','44060-5102','001','(440)257-2934','(440)257-2935')
insert into newspaper values('0004','Georgia Chronicle','Georgia','General','Abair Duane','4483 victory drive','Columbus','Georgia','31905-1189','001','(706)687-0686','(706)687-0688')
insert into newspaper values('0005','Nevada Update','Nevada','general','Jack Phil','7765 La Cienega St ','Las Vegas','Nevada','89123-1707','001','(702)263-0704','(702)263-0724')
insert into newspaper values('0006','Morning News','New Jersy','General','Renard Andrew','125 Shark River Rd ','Middle Town','New Jersy','07748-3325','001','(732)708-0249','(732)708-0235')
insert into newspaper values('0007','Nevada News','Nevada','General','Ray Dean','Cambridge St','Las Vegas','Nevada','89109-4072','001','(702)369-6592','(702)369-6408')
insert into newspaper values('0008','Kansas Today','Kansas','Genral','Robin Paul','1925 Shawnee Dr  ','Kansas City','Kansas','66106-3025','001','(913)362-9529','(913)362-9515')
insert into newspaper values('0009','Star Texas Times','Texas','Genral','Juan Smith','322 Highway 39','Ingram','Texas','63206-3025','001','(803)432-9512','(720)342-9235')
insert into newspaper values('0010','Los Angeles News','California','Genral','Frank Robertson','123 Pier Avenue','Santa Monica','California','90423-3025','001','(303)426-2212','(303)623-6345')
insert into newspaper values('0011','Sonoma Valley News','California','Genral','John Atkinson','120 S. Main St. Suit','Sebastopol','California','97678-3224','001','(707)234-5512','(707)864-9565')
go
/* data for newsad */
raiserror('Inserting data in NewsAd table....',0,1)
insert into newsad values('0001','0003','04/03/1999','04/12/1999')
insert into newsad values('0002','0002','03/15/1999','04/12/1999')
insert into newsad values('0003','0005','04/03/1999','04/22/1999')
insert into newsad values('0004','0005','04/05/1999','04/14/1999')
insert into newsad values('0005','0005','05/06/1999','05/15/1999')
insert into newsad values('0006','0001','05/07/1999','05/16/1999')
insert into newsad values('0007','0002','06/08/1999','06/17/1999')
insert into newsad values('0008','0003','06/01/1999','06/18/1999')
insert into newsad values('0009','0002','07/02/1999','07/13/1999')
insert into newsad values('0010','0003','07/03/1999','07/14/1999')
insert into newsad values('0011','0005','07/04/1999','07/15/1999')
insert into newsad values('0012','0001','07/05/1999','07/16/1999')
insert into newsad values('0013','0002','07/06/1999','07/17/1999')
insert into newsad values('0014','0001','07/07/1999','07/18/1999')
insert into newsad values('0015','0001','07/08/1999','07/13/1999')
go
/* data for  jobfair */
raiserror('Inserting data in JobFair table....',0,1)
insert into jobfair values('0001','Wright State Uni.Dayton, OH','National Def. Asso.', 18,'05/11/1999')
insert into jobfair values('0002','Tulsa Mar. South Hills 1902','CFG', 20,'05/30/1999')
insert into jobfair values('0003','211 Ninian Ave Alexandria','ADF', 10,'05/25/1999')
insert into jobfair values('0004','23 Pitt Rd Spring Field Ohio','DDC', 22,'05/22/1999')
insert into jobfair values('0005','36 Mcgrath Dr Dublin','PLC', 20,'05/21/1999')
go

raiserror('Inserting data in ContractRecruiter table....',0,1)
insert into contractrecruiter values('0001','Jack Paul','2250 Lakeside Ave.','Alexandria','Virginia','22310-1117','(703)922-2654','(703)922-2662',15,1200)
insert into contractrecruiter values('0002','Abbott Mike','3688 Mcgrath Dr','Dublin','Georgia','43016-4171','(614)761-7743','(614)761-7745',7,1500)
insert into contractrecruiter values('0003','Facundo Michel','1150 Prince St.','Alexandria','Virginia','22314-2947','(703)684-1696','(703)684-1680',9,800)
insert into contractrecruiter values('0004','Taber Kyle','1225 Effingham Ct','Columbus','Georgia','31909-3165','(706)565-9463','(706)565-9464',7,700)
insert into contractrecruiter values('0005','Joe Bryan','28 Pitt Rd','Spring Field','Ohio','07081-2634','(973)467-1682','(973)467-1682',9,900)
insert into contractrecruiter values('0006','George Craig','5202 Ninian Ave ','Alexandria','Virginia','22310-1117','(703)922-3466','(703)922-3467',9,1200)
go
/* data for recruitment agencies */ -- drop table recruitmentagencies 
raiserror('Inserting data in RecruitmentAgencies table....',0,1)
Insert into recruitmentagencies values('0001','ASTEC Inc        ','11715 Administration Dr Suite 230','Hampstead','New York','11550-3425','(516)433-1426','(516)433-1427',8, 1200)
Insert into recruitmentagencies values('0002','CDI Corporation West','9301 Oakdale Ave Suite 114 ','New Orleans','Louisinia','70131-1265','(504)422-5608','(504)422-5734', 9, 800)
Insert into recruitmentagencies values('0003','ETS Inc             ','5717 E Thomas Rd Suite 3 ','New Orleans','Louisinia','70115-2365','(504)323-4322','(504)323-4342', 9, 1100)
Insert into recruitmentagencies values('0004','FSK Associates Inc  ','PO Box 1078 ','Houston ','Texas','77015-4568','(713)451-2847','(713)451-2852', 6, 1200)
Insert into recruitmentagencies values('0006','Hall Kinion         ','19925 Stevens Creek Blvd  Suite 180','Houston','Texas','77016-3448','(713)642-7253','(713)642-7250', 8, 800)
Insert into recruitmentagencies values('0007','Manpower Technical  ','517 Fifth Ave ','Alexandria','Virginia','22302-1608','(703)214-4423','(703)214-4425', 6, 1200)
Insert into recruitmentagencies values('0009','Sysdyne Corporation ','1660 S Highway 100 Suite 424 ','Clevland','Ohio','44106-1523','(440)885-1980','(440)885-1978', 6, 800)
go
/* data for college */
raiserror('Inserting data in College table....',0,1)
Insert into college values('0001','Westend College                ','900N Main Ave','Hampstead','New York','11550-1648','(516)423-4591')
Insert into college values('0002','Cromwell College              ','4010 Gartner Ave.','Abilene','Texas','79605-4123','(915)692-6628')
Insert into college values('0003','Schneider College             ','2100 New Blvd','Los Angeles','California','70131-3184','(504)271-2187')
Insert into college values('0004','Trent College                 ','240N Grand Ave.','Abilene','Texas','79605-4415','(915)368-2561')
Insert into college values('0005','Wiley College                 ','711 Wiley College','Columbus','Ohio','43220-2821','(614)451-1005')
Insert into college values('0006','Benard College                ','3009 broad way','New York City','New York','10128-4018','(212)969-9826')
Insert into college values('0007','Deman College                 ','4380 Main Street','Hampstead ','New York','11550-4321','(516)532-3728')
Insert into college values('0008','Monterey College       ','30 Emmons park drive','Taft','California','93268-1648','(661)761-4591')
Insert into college values('0009','Evergreen College       ','2000 College Heights Blvd','Ridgecrest','California','93555-1648','(760)761-4591')
go

raiserror('Inserting data in CampusRecruitment table....',0,1)
Insert into campusrecruitment values('0001','0003','05/13/1999','05/28/1999')
Insert into campusrecruitment values('0002','0005','05/23/1999','06/07/1999')
Insert into campusrecruitment values('0003','0002','05/13/1999','05/28/1999')
go

raiserror('Inserting data in InternalJobPosting table....',0,1)
Insert into InternalJobPosting values('0001','0002',6,'New York','03/13/1999','04/12/1999')
Insert into InternalJobPosting values('0002','0004',9,'Texas','03/15/1999','04/12/1999')
Insert into InternalJobPosting values('0003','0001',7,'New York','04/02/1999','04/22/1999')
Insert into InternalJobPosting values('0004','0002',12,'Texas','03/13/1999','04/12/1999')
Insert into InternalJobPosting values('0005','0004',2,'New York','03/13/1998','04/12/1998')
Insert into InternalJobPosting values('0006','0002',4,'New York','03/13/1998','04/12/1998')
go 

raiserror('Inserting data in InternalCandidate table....',0,1)
Insert into InternalCandidate values('000001','000012','0001','0002','04/02/1999','04/06/1999',96,'04/09/1999',null,null,'5',null)
Insert into InternalCandidate values('000002','000002','0001','0002','04/02/1999','04/06/1999',67,'04/09/1999',null,null,'6',null)
Insert into InternalCandidate values('000003','000011','0003','0001','04/02/1999','04/06/1999',88,'04/09/1999',null,null,'9',null)
Insert into InternalCandidate values('000004','000002','0003','0001','04/02/1999','04/06/1999',83,'04/09/1999',null,null,'7',null)
Insert into InternalCandidate values('000005','000008','0001','0002','04/02/1999','04/06/1999',43,'04/09/1999',null,null,'3',null)
Insert into InternalCandidate values('000018','000003','0001','0002','02/02/1999','03/06/1999',null,'04/09/1999',null,null,'8',null)
go

 raiserror('Inserting data in ExternalCandidate table....',0,1)
 insert into externalcandidate values('000001','Angela','Smith','16223 Radiance Court','Kansas City    ','Kansas','66101-2945','001','(913)227-2344  ','0001','05/02/1997',null,'0001',null,null,null,null,null ,'Graduate',4   ,'2/12/1969','F','0001',  30000.00,null,'angelas@qmail.com','P','05/09/1997',80,'05/15/1997',null,null,8 )                                                                                 
 insert into externalcandidate values('000002','Barbara','Johnson','227 Beach Ave.','Alexandria     ','Virginia','22304-3700','001','(703)123-5673  ','0005','08/14/1997',null,null,'0001',null,null,null,null  ,'BBA',3 ,'1/15/1965','F','0003',  40000.00,null,'barba@speedmail.com','P','08/21/1997',82,'08/28/1997','000001','Good Communication skill',9)                                              
 insert into externalcandidate values('000003','Betty','Williams','1 Tread Road','Dublin         ','Georgia','43017-3004','001','(614)458-3299  ','0010','05/02/1998',null,null,'0001',null,null,null,null  ,'Graduate',2   ,'8/6/1971','F','0007',  30000.00,null,'bettyw@dpeedmil.cm','P','05/09/1998',70,'05/20/1998','000001','Good presentation skill',8 )                                                  
 insert into externalcandidate values('000004','Carol','Jones','765 Furling Rd Apt','Norton         ','Kansas','67654-1255','001','(785)678-4544  ','0012','05/02/1998',null,null,null,'0001',null,null,null  ,'Graduate',4 ,'06/10/1979  ','F','0005',      0.00,null,NULL,'P','05/09/1998',45,'05/24/1998','000001','Quick Learner',6 )                                                 
 insert into externalcandidate values('000005','Catherine','Roberts','5508 Aquiline Court','Norton         ','Kansas','67654-1255','001','(785)445-2256  ','0007','05/05/1998','000001',null,null,null,null,null,null  ,'BBA',5   ,'10/10/1962','F','0001',      0.00,null,NULL,'P','05/09/1998',74,'05/28/1998','000001','Good at planning',7 )                                      
 insert into externalcandidate values('000010','David','Moore','8808 Joviality Drive','Houston        ','Texas','77063-5564','001','(281)982-5577  ','0001','08/07/1998','000002',null,null,null,null,null,null  ,'Graduate',1   ,'11/23/1967','M','0003',  25000.00,null,'davidm@qmail.com','P','08/14/1998',92,'08/21/1998','000006','Takes lots of Initiative',9 )                                               
 insert into externalcandidate values('000011','Deborah','Taylor','2199- Fairfax Drive ','Seattle        ','Washington','98122-2514','001','(206)889-2235  ','0007','08/07/1998',null,null,null,null,'0001',null,null,'BBA',4   ,'10/14/1964','F','0004',  31000.00,null,'deboraht@qmail.com','P','08/14/1998',88,'08/21/1998','000006','Has worked as good team member',8 )                                          
 insert into externalcandidate values('000012','Donna','Anderson','7930 Orange St. ','Mentor         ','Ohio','44060-4514','001','(440)845-2323  ','0010','08/07/1999',null,'0003',null,null,null,null,null  ,'MBA',4,'7/18/1971','F','0012',      0.00,null,'Donnaa@speedmail.com','P','08/14/1998',83,'08/21/1998','0000011','Hard working',8 )                                            
 insert into externalcandidate values('000014','Elizabeth','Jackson','598 Apex Avenue #2','Dublin         ','Georgia','43017-3004','001','(614)545-9078  ','0013','09/07/1998',null,null,null,null,'0002',null,null  ,'Graduate',4   ,'10/12/1969','F','0002',  28000.00,null,'elizabethj@qmail.com','P','09/13/1998',65,'09/21/1998','000001','Good presentation skills',6 )                                       
 insert into externalcandidate values('000016','Helen','White','Fleet Street','New York City  ','New York','10024-7401','001','(212)585-7796  ','0015','12/10/1998',null,null,null,null,null,null,null  ,'Graduate',4   ,'2/1/1972  ','F','0001',  40000.00,null,'helenw@spedmail.com','P','12/15/1998',94,'12/20/1998','000006','Quick Learner',9 )                                                    
 insert into externalcandidate values('000018','Jennifer','Martin','9812  76th Street  ','Abilene        ','Texas','79603-2485','001','(915)569-7789  ','0015','12/16/1998',null,null,null,'0006',null,'0001',null  ,'BBA',4   ,'5/22/1966','F','0004',  26000.00,null,'jenniferm@qmail.com','P','12/20/1998',97,'12/23/1998','000006','Good at planning and good analytical skills',9 )                                         
 insert into externalcandidate values('000021','Joseph','Martinez','995 Rind Street ','San Diego      ','California','92122-2017','001','(619)456-9032  ','0014','01/16/1999',null,'0005',null,null,null,null,null  ,'Graduate',4   ,'4/13/1971','M','0005',      0.00,null,'josephm@qmail.com','P','01/22/1999',81,'01/26/1999','000006','Commited and Hard working',8 )                                              
 insert into externalcandidate values('000022','Joyce','Phillips','535 Darwin Avenue ','Columbus       ','Georgia','31904-7624','001','(706)789-6905  ','0001','01/16/1999',null,null,'0002',null,null,null,null  ,'BBA',4   ,'3/14/1966','M','0006',      0.00,null,'joycep@speedmail.com','P','01/22/1999',61,'01/26/1999','000001','Long term potential',6 )                                          
 insert into externalcandidate values('000026','Linda','Lewis','1524 Patagonia Lane ','Columbus       ','Georgia','31904-7624','001','(706)459-4563  ','0014','01/16/1999',null,'0005',null,null,null,null,null  ,'Graduate',4   ,'11/06/1969','F','0006',  31000.00,null,'lindal@qmail.com','P','01/22/1999',69,'01/26/1999','000006','Helpfull in nature',6 )                                               
 insert into externalcandidate values('000029','Maria','Hall','936 Midland Drive  ','Columbus       ','Georgia','31904-7624','001','(706)345-8764  ','0008','02/01/1999',null,null,null,'0004',null,null,null  ,'MBA',4,'10/21/1968','F','0006',  35000.00,null,'Mariah@speedmail.com','P','02/07/1999',57,'02/09/1999','000011','Customer oriented',8 )                                            
 insert into externalcandidate values('000033','Nancy','King','429 Ash Birch Lane  ','Middle Town    ','New Jersy','07748-3224','001','(732)563-2298  ','0006','02/10/1999',null,'0005',null,null,null,null,null  ,'Graduate',4,'5/6/1970','F','0011',  25000.00,null,'nancyk@qmail.com','P','03/07/1999',76,'03/06/1999','000001','Needs to improve in communication,but commited to the job',7 )                                                
 insert into externalcandidate values('000035','Paul','Lopez','13459 Campton Street','Spring Field   ','Ohio','07081-1442','001','(973)912-7905  ','0006','02/14/1999',null,null,null,'0002',null,null,null  ,'Graduate',4,'11/1/1968','M','0008',  28000.00,null,'paull@qmail.com','P','03/08/1999',96,'03/14/1999','000001','Hard working but needs to improve in communication skill',9 )                                                 
 insert into externalcandidate values('000038','Ruth','Green','459 Ridge Road ','Middle Town    ','New Jersy','07748-3224','001','(732)347-9082  ','0003','03/01/1999',null,null,null,null,'0001',null,null  ,'MBA',4   ,'12/02/1968','M','0006',  21000.00,null,'ruthg@speedmail.com','P','03/08/1999',88,'03/010/1999','000011','Helpfull in nature',8 )                                                  
 insert into externalcandidate values('000039','Sandra','Adams','12454 Boggy Blvd. ','Middle Town    ','New Jersy','07748-3224','001','(732)982-9503  ','0003','02/12/1999',null,null,'0002',null,null,null,null  ,'Graduate',4,'05/22/1969','F','0004',  32000.00,null,'Sandra@qmail.com','P','02/14/1999',55,'02/20/1999','000001','Long term potential',6 )                                                
 insert into externalcandidate values('000040','Sarah','Baker','2394 Emerald Street ','Middle Town    ','New Jersy','07748-3224','001','(732)439-2309  ','0002','02/12/1999',null,null,null,'0004',null,null,null  ,'BBA',4   ,'11/17/1971','F','0004',  28000.00,null,'sarahb@qmail.com','P','02/15/1999',67,'02/21/1999','000011','Needs to improve in communication skills',6 )                                               
 insert into externalcandidate values('000045','William','Perez','987 Tetragon Avenue ','Las Vegas      ','Nevada','89123-2514','001','(702)234-8764  ','0002','03/02/1999',null,'0004',null,null,null,null,null  ,'Graduate',4   ,'2/7/1969','M','0005',  26000.00,null,'williamp@qmail.com','P','03/30/1999',78,'04/14/1999','000006','Customer oriented',8 )                                           
 insert into externalcandidate values('000046','David','Cooper','5614 Raffle Court  ','Las Vegas      ','Nevada','89123-2514','001','(702)678-3458  ','0003','03/06/1999',null,'0004',null,null,null,null,null ,'MBA',4   ,'04/08/1966','M','0005',      0.00,null,'davidc@speedmail.com','P','03/30/1999',89,'04/07/1999','000006','Long term potential, commited and hardworking',9 )                                           
 insert into externalcandidate values('000047','Peter','Prescott','340 Miasma Drive','Mentor         ','Ohio','44060-4514','001','(440)890-4084  ','0015','03/10/1999',null,'0002',null,null,null,null,null  ,'Graduate',4,'08/07/1971','M','0006',  29000.00,null,NULL,'P','03/30/1999',55,NULL,null,null,5 )                                                
 insert into externalcandidate values('000049','Jane','Schaffer','521 State Street','Mentor         ','Ohio','44060-4514','001','(440)280-9999  ','0002','05/04/1999',null,null,null,'0003',null,null,null  ,'Graduate',4,'9/15/1971','F','0004',  32000.00,null,NULL,'P','05/16/1999',84,NULL,null,null,8 )                                                 

go

update externalcandidate
set dtestdate=ddateofapplication+7
go
update externalcandidate
set dinterviewdate=ddateofapplication+14
go

raiserror('Inserting data in Skill table....',0,1)
Insert into skill values('0001','Communication skill')
Insert into skill values('0002','Visual basic')
Insert into skill values('0003','Database Administration')
Insert into skill values('0005','Data Entry')
Insert into skill values('0006','Team leading')
Insert into skill values('0007','Power Builder')
Insert into skill values('0008','Record Keeping')
Insert into skill values('0009','Presentation Skill')
Insert into skill values('0010','Convincing')
Insert into skill values('0011','Learning')
Insert into skill values('0012','Planning')
Insert into skill values('0013','Project Management')
Insert into skill values('0014','Time Keeping')
Insert into skill values('0015','Analytical')
Insert into skill values('0016','MS-Ofice')
Insert into skill values('0017','Initiative')
Insert into skill values('0018','Self Motivation')
Insert into skill values('0019','Scheduling')
Insert into skill values('0020','Interpersonal Skill')
Insert into skill values('0021','Scheduling')
go
/* data for employee rtable */
 raiserror('Inserting data in Employee table....',0,1)
 Insert into employee values('000001','Angela','Smith','000001','16223 Radiance Court','Kansas City         ','Kansas','66101-2945','001','(913)227-2344  ','Graduate','02/12/1969','F','0001','Senior Manager','angelas@qmail.com','0002','Kansas City         ',null,'06/16/1997',null,'627-89-6952',null)
 Insert into employee values('000002','Betty','Williams','000003','1 Tread Road','Dublin              ','California','43017-3004','001','(614)458-3299  ','Graduate','08/06/1971','F','0010','Assistant  secretary','bettyw@dpeedmil.cm','0005','Dublin              ',null,'06/16/1998',null,'617-40-3628',null)              	                                                   
 Insert into employee values('000003','Carol','Jones','000004','765 Furling Rd Apt','Norton              ','Kansas','67654-1255','001','(785)678-4544  ','Graduate','06/10/1979','F','0012','Senior Receptionist','carolj@qmail.com','0003','Norton              ',null,'06/19/1998',null,'806-84-8173',null)             	                                                   
 Insert into employee values('000004','Catherine','Roberts','000005','5508 Aquiline Court','Norton              ','kansas','67654-1255','001','(785)445-2256  ','BBA','10/10/1962','F','0007','Junior manager','catheriner@qmail.com','0009','Norton              ',null,'06/29/1998',null,'763-26-5478',null)       	                                                   
 Insert into employee values('000005','David','Moore','000010','8808 Joviality 	Drive','Houston             ','Texas','77063-5564','001','(281)982-5577','Graduate','11/23/1967','M','0001','Junior manager','davidm@qmail.com','0002','Houston',null,'06/29/1998',null,'732-43-5067',null)           	                                                   
 Insert into employee values('000006','Elizabeth','Jackson','000014','598 Apex Avenue #2','Dublin              ','Georgia','43017-3004','001','(614)545-9078  ','Graduate','10/12/1969','F','0013','Assistant consultant','elizabethj@qmail.com','0007','Dublin              ',null,'07/21/1998',null,'356-05-5459',null)   	                                                   
 Insert into employee values('000007','Helen','White','000016','Fleet Street','New York City       ','New York','10024-7401','001','(212)585-7796  ','Graduate','02/01/1972','F','0015','Junior Receptionist','helenw@spedmail.com','0003','New York City       ',null,'08/29/1998',null,'326-69-3560',null)                	                                                   
 Insert into employee values('000008','Jennifer','Martin','000018','9812  76th Street','Dublin','California','49603-2485','001','(617)569-7789  ','BBA','05/22/1966','F','0015','Junior Receptionist','jenniferm@qmail.com','0004','Dublin             ',null,'08/30/1998',null,'343-26-6693',null)          	                                                   
 Insert into employee values('000009','Linda','Lewis','000026','1524 Patagonia Lane ','Columbus            ','Georgia','31904-7624','001','(706)459-4563  ','Graduate','11/06/1969','F','0014','Assistant Technician','lindal@qmail.com','0010','Columbus            ',null,'09/08/1998',null,'384-08-6778',null)           	                                                   
 Insert into employee values('000010','Maria','Hall','000029','936 Midland Drive  ','Columbus            ','Georgia','31904-7624','001','(706)345-8764  ','MBA','10/21/1968','F','0008','Junior operator','Mariah@speedmail.com','0003','Columbus            ',null,'09/08/1998',null,'783-06-7914',null)              	                                                   
 Insert into employee values('000011','Paul','Lopez','000035','13459 Campton Street','Spring Field        ','Ohio','07081-1442','001','(973)912-7905  ','Graduate','11/01/1968','M','0006','Assistant Manager','paull@qmail.com','0009','Spring Field        ',null,'09/21/1998',null,'990-35-4788',null)             	                                                   
 Insert into employee values('000012','Sandra','Adams','000039','12454 Boggy Blvd. ','Middle Town         ','New Jersy','07748-3224','001','(732)982-9503  ','Graduate','05/22/1969','F','0003','Senior Analyst','Sandra@qmail.com','0009','Middle Town         ',null,'09/26/1998',null,'499-03-5817',null)                                                               
 Insert into employee values('000013','William','Perez','000045','987 Tetragon Avenue ','Las Vegas           ','Nevada','89123-2514','001','(702)234-8764  ','Graduate','02/07/1969','M','0002','Junior Manager','williamp@qmail.com','0003','Las Vegas           ',null,'10/05/1998',null,'517-82-4993',null)       	                                                   
 Insert into employee values('000014','David','Cooper','000046','5614 Raffle Court  ','Las Vegas           ','Nevada','89123-2514','001','(702)678-3458  ','MBA','04/08/1966','M','0003','Junior analyst','davidc@speedmail.com','0009','Las Vegas           ',null,'10/05/1998',null,'499-03-5816',null)            	                                                   
 Insert into employee values('000015','Peter','Prescott','000047','340 Miasma Drive','Mentor              ','Ohio','44060-4514','001','(440)890-4084  ','Graduate','08/07/1971','M','0015','Junior Receptionist','peterp@qmail.com','0008','Mentor              ',null,'11/08/1998',null,'216-22-6414',null)            	                                                   
go
/* data for annual salary */
raiserror('Inserting data in AnnualSalary table....',0,1)
insert into annualsalary values('000001',46000 ,1997)
insert into annualsalary values('000001',48000 ,1998)
insert into annualsalary values('000002',36000 ,1998)
insert into annualsalary values('000003',30000 ,1998)
insert into annualsalary values('000004',48000 ,1998)
insert into annualsalary values('000005',48000 ,1998)
insert into annualsalary values('000006',48000 ,1998)
insert into annualsalary values('000007',24000 ,1998)
insert into annualsalary values('000008',24000 ,1998)
insert into annualsalary values('000009',30000 ,1998)
insert into annualsalary values('000010',24000 ,1998)
insert into annualsalary values('000011',24000 ,1998)
insert into annualsalary values('000012',36000 ,1998)
insert into annualsalary values('000013',48000 ,1998)
insert into annualsalary values('000014',36000 ,1998)
insert into annualsalary values('000015',24000 ,1998)
--
insert into annualsalary values('000001',48000 ,1999)
insert into annualsalary values('000002',36000 ,1999)
insert into annualsalary values('000003',30000 ,1999)
insert into annualsalary values('000004',48000 ,1999)
insert into annualsalary values('000005',48000 ,1999)
insert into annualsalary values('000006',48000 ,1999)
insert into annualsalary values('000007',24000 ,1999)
insert into annualsalary values('000008',24000 ,1999)
insert into annualsalary values('000009',30000 ,1999)
insert into annualsalary values('000010',24000 ,1999)
insert into annualsalary values('000011',24000 ,1999)
insert into annualsalary values('000012',36000 ,1999)
insert into annualsalary values('000013',48000 ,1999)
insert into annualsalary values('000014',36000 ,1999)
insert into annualsalary values('000015',24000 ,1999)
go
/* data for monthly salary */
raiserror('Inserting data in MonthlySalary table....',0,1)
insert into monthlysalary values('000001',     3833.33,'07/01/1997',0)
insert into monthlysalary values('000001',     3833.33,'08/01/1997',0)
insert into monthlysalary values('000001',     3833.33,'09/01/1997',0)
insert into monthlysalary values('000001',     3833.33,'10/01/1997',0)
insert into monthlysalary values('000001',     3833.33,'11/01/1997',0)
insert into monthlysalary values('000001',     3833.33,'12/01/1997',0)
-------------------------------------------------------------------- 
insert into monthlysalary values('000001',     4000.00,'01/01/1998',0)
insert into monthlysalary values('000001',     4000.00,'02/01/1998',0)
insert into monthlysalary values('000001',     4000.00,'03/01/1998',0)
insert into monthlysalary values('000001',     4000.00,'04/01/1998',0)
insert into monthlysalary values('000001',     4000.00,'05/01/1998',0)
insert into monthlysalary values('000001',     4000.00,'06/01/1998',0)
insert into monthlysalary values('000001',     4000.00,'07/01/1998',0)
-------------------------------------------------------------------- 
insert into monthlysalary values('000002',     3000.00,'07/01/1998',0)
insert into monthlysalary values('000004',     4000.00,'07/01/1998',0)
insert into monthlysalary values('000005',     4000.00,'07/01/1998',0)
-------------------------------------------------------------------- 
insert into monthlysalary values('000001',     4000.00,'08/01/1998',0)
insert into monthlysalary values('000002',     3000.00,'08/01/1998',0)
insert into monthlysalary values('000004',     4000.00,'08/01/1998',0)
insert into monthlysalary values('000005',     4000.00,'08/01/1998',0)
insert into monthlysalary values('000006',     4000.00,'08/01/1998',0)
-------------------------------------------------------------------- 
insert into monthlysalary values('000001',     4000.00,'09/01/1998',0)
insert into monthlysalary values('000002',     3000.00,'09/01/1998',0)
insert into monthlysalary values('000004',     4000.00,'09/01/1998',0)
insert into monthlysalary values('000005',     4000.00,'09/01/1998',0)
insert into monthlysalary values('000006',     4000.00,'09/01/1998',0)
insert into monthlysalary values('000007',     2000.00,'09/01/1998',0)
insert into monthlysalary values('000008',     2000.00,'09/01/1998',0)
-------------------------------------------------------------------- 
insert into monthlysalary values('000001',     4000.00,'10/01/1998',0)
insert into monthlysalary values('000002',     3000.00,'10/01/1998',0)
insert into monthlysalary values('000004',     4000.00,'10/01/1998',0)
insert into monthlysalary values('000005',     4000.00,'10/01/1998',0)
insert into monthlysalary values('000006',     4000.00,'10/01/1998',0)
insert into monthlysalary values('000007',     2000.00,'10/01/1998',0)
insert into monthlysalary values('000008',     2000.00,'10/01/1998',0)
insert into monthlysalary values('000009',     2500.00,'10/01/1998',0)
insert into monthlysalary values('000010',     2000.00,'10/01/1998',0)
insert into monthlysalary values('000011',     2000.00,'10/01/1998',0)
insert into monthlysalary values('000012',     3000.00,'10/01/1998',0)
-------------------------------------------------------------------- 
insert into monthlysalary values('000001',     4000.00,'11/01/1998',0)
insert into monthlysalary values('000002',     3000.00,'11/01/1998',0)
insert into monthlysalary values('000004',     4000.00,'11/01/1998',0)
insert into monthlysalary values('000005',     4000.00,'11/01/1998',0)
insert into monthlysalary values('000006',     4000.00,'11/01/1998',0)
insert into monthlysalary values('000007',     2000.00,'11/01/1998',0)
insert into monthlysalary values('000008',     2000.00,'11/01/1998',0)
insert into monthlysalary values('000009',     2500.00,'11/01/1998',0)
insert into monthlysalary values('000010',     2000.00,'11/01/1998',0)
insert into monthlysalary values('000011',     2000.00,'11/01/1998',0)
insert into monthlysalary values('000012',     3000.00,'11/01/1998',0)
insert into monthlysalary values('000013',     4000.00,'11/01/1998',0)
insert into monthlysalary values('000014',     3000.00,'11/01/1998',0)
-------------------------------------------------------------------- 
insert into monthlysalary values('000001',     4000.00,'12/01/1998',0)
insert into monthlysalary values('000002',     3000.00,'12/01/1998',0)
insert into monthlysalary values('000004',     4000.00,'12/01/1998',0)
insert into monthlysalary values('000005',     4000.00,'12/01/1998',0)
insert into monthlysalary values('000006',     4000.00,'12/01/1998',0)
insert into monthlysalary values('000007',     2000.00,'12/01/1998',0)
insert into monthlysalary values('000008',     2000.00,'12/01/1998',0)
insert into monthlysalary values('000009',     2500.00,'12/01/1998',0)
insert into monthlysalary values('000010',     2000.00,'12/01/1998',0)
insert into monthlysalary values('000011',     2000.00,'12/01/1998',0)
insert into monthlysalary values('000012',     3000.00,'12/01/1998',0)
insert into monthlysalary values('000013',     4000.00,'12/01/1998',0)
insert into monthlysalary values('000014',     3000.00,'12/01/1998',0)
insert into monthlysalary values('000015',     2000.00,'12/01/1998',0)
-------------------------------------------------------------------- 
insert into monthlysalary values('000001',     4000.00,'01/01/1999',0)
insert into monthlysalary values('000002',     3000.00,'01/01/1999',0)
insert into monthlysalary values('000004',     4000.00,'01/01/1999',0)
insert into monthlysalary values('000005',     4000.00,'01/01/1999',0)
insert into monthlysalary values('000006',     4000.00,'01/01/1999',0)
insert into monthlysalary values('000007',     2000.00,'01/01/1999',0)
insert into monthlysalary values('000008',     2000.00,'01/01/1999',0)
insert into monthlysalary values('000009',     2500.00,'01/01/1999',0)
insert into monthlysalary values('000010',     2000.00,'01/01/1999',0)
insert into monthlysalary values('000011',     2000.00,'01/01/1999',0)
insert into monthlysalary values('000012',     3000.00,'01/01/1999',0)
insert into monthlysalary values('000013',     4000.00,'01/01/1999',0)
insert into monthlysalary values('000014',     3000.00,'01/01/1999',0)
insert into monthlysalary values('000015',     2000.00,'01/01/1999',0)
-------------------------------------------------------------------- 
insert into monthlysalary values('000001',     4000.00,'02/01/1999',0)
insert into monthlysalary values('000002',     3000.00,'02/01/1999',0)
insert into monthlysalary values('000004',     4000.00,'02/01/1999',0)
insert into monthlysalary values('000005',     4000.00,'02/01/1999',0)
insert into monthlysalary values('000006',     4000.00,'02/01/1999',0)
insert into monthlysalary values('000007',     2000.00,'02/01/1999',0)
insert into monthlysalary values('000008',     2000.00,'02/01/1999',0)
insert into monthlysalary values('000009',     2500.00,'02/01/1999',0)
insert into monthlysalary values('000010',     2000.00,'02/01/1999',0)
insert into monthlysalary values('000011',     2000.00,'02/01/1999',0)
insert into monthlysalary values('000012',     3000.00,'02/01/1999',0)
insert into monthlysalary values('000013',     4000.00,'02/01/1999',0)
insert into monthlysalary values('000014',     3000.00,'02/01/1999',0)
insert into monthlysalary values('000015',     2000.00,'02/01/1999',0)
-------------------------------------------------------------------- 
insert into monthlysalary values('000001',     4000.00,'03/01/1999',0)
insert into monthlysalary values('000002',     3000.00,'03/01/1999',0)
insert into monthlysalary values('000004',     4000.00,'03/01/1999',0)
insert into monthlysalary values('000005',     4000.00,'03/01/1999',0)
insert into monthlysalary values('000006',     4000.00,'03/01/1999',0)
insert into monthlysalary values('000007',     2000.00,'03/01/1999',0)
insert into monthlysalary values('000008',     2000.00,'03/01/1999',0)
insert into monthlysalary values('000009',     2500.00,'03/01/1999',0)
insert into monthlysalary values('000010',     2000.00,'03/01/1999',0)
insert into monthlysalary values('000011',     2000.00,'03/01/1999',0)
insert into monthlysalary values('000012',     3000.00,'03/01/1999',0)
insert into monthlysalary values('000013',     4000.00,'03/01/1999',0)
insert into monthlysalary values('000014',     3000.00,'03/01/1999',0)
insert into monthlysalary values('000015',     2000.00,'03/01/1999',0)
-------------------------------------------------------------------- 
insert into monthlysalary values('000001',     4000.00,'04/01/1999',0)
insert into monthlysalary values('000002',     3000.00,'04/01/1999',0)
insert into monthlysalary values('000004',     4000.00,'04/01/1999',0)
insert into monthlysalary values('000005',     4000.00,'04/01/1999',0)
insert into monthlysalary values('000006',     4000.00,'04/01/1999',0)
insert into monthlysalary values('000007',     2000.00,'04/01/1999',0)
insert into monthlysalary values('000008',     2000.00,'04/01/1999',0)
insert into monthlysalary values('000009',     2500.00,'04/01/1999',0)
insert into monthlysalary values('000010',     2000.00,'04/01/1999',0)
insert into monthlysalary values('000011',     2000.00,'04/01/1999',0)
insert into monthlysalary values('000012',     3000.00,'04/01/1999',0)
insert into monthlysalary values('000013',     4000.00,'04/01/1999',0)
insert into monthlysalary values('000014',     3000.00,'04/01/1999',0)
insert into monthlysalary values('000015',     2000.00,'04/01/1999',0)
-------------------------------------------------------------------- 
insert into monthlysalary values('000001',     4000.00,'05/01/1999',0)
insert into monthlysalary values('000002',     3000.00,'05/01/1999',0)
insert into monthlysalary values('000004',     4000.00,'05/01/1999',0)
insert into monthlysalary values('000005',     4000.00,'05/01/1999',0)
insert into monthlysalary values('000006',     4000.00,'05/01/1999',0)
insert into monthlysalary values('000007',     2000.00,'05/01/1999',0)
insert into monthlysalary values('000008',     2000.00,'05/01/1999',0)
insert into monthlysalary values('000009',     2500.00,'05/01/1999',0)
insert into monthlysalary values('000010',     2000.00,'05/01/1999',0)
insert into monthlysalary values('000011',     2000.00,'05/01/1999',0)
insert into monthlysalary values('000012',     3000.00,'05/01/1999',0)
insert into monthlysalary values('000013',     4000.00,'05/01/1999',0)
insert into monthlysalary values('000014',     3000.00,'05/01/1999',0)
insert into monthlysalary values('000015',     2000.00,'05/01/1999',0)
-------------------------------------------------------------------- 
insert into monthlysalary values('000001',     4000.00,'06/01/1999',0)
insert into monthlysalary values('000002',     3000.00,'06/01/1999',0)
insert into monthlysalary values('000004',     4000.00,'06/01/1999',0)
insert into monthlysalary values('000005',     4000.00,'06/01/1999',0)
insert into monthlysalary values('000006',     4000.00,'06/01/1999',0)
insert into monthlysalary values('000007',     2000.00,'06/01/1999',0)
insert into monthlysalary values('000008',     2000.00,'06/01/1999',0)
insert into monthlysalary values('000009',     2500.00,'06/01/1999',0)
insert into monthlysalary values('000010',     2000.00,'06/01/1999',0)
insert into monthlysalary values('000011',     2000.00,'06/01/1999',0)
insert into monthlysalary values('000012',     3000.00,'06/01/1999',0)
insert into monthlysalary values('000013',     4000.00,'06/01/1999',0)
insert into monthlysalary values('000014',     3000.00,'06/01/1999',0)
insert into monthlysalary values('000015',     2000.00,'06/01/1999',0)
go
/* data for employee skill */
raiserror('Inserting data in EmployeeSkill table....',0,1)
insert into employeeskill  values('000001','0001')
insert into employeeskill  values('000001','0006')
insert into employeeskill  values('000001','0009')
insert into employeeskill  values('000001','0010')
insert into employeeskill  values('000001','0012')
insert into employeeskill  values('000001','0015')
insert into employeeskill  values('000001','0018')
insert into employeeskill  values('000001','0020')
insert into employeeskill  values('000001','0021')
insert into employeeskill  values('000001','0013')
--  
insert into employeeskill  values('000002','0001')
insert into employeeskill  values('000002','0009')
insert into employeeskill  values('000002','0010')
insert into employeeskill  values('000002','0012')
insert into employeeskill  values('000002','0015')
insert into employeeskill  values('000002','0018')
--
insert into employeeskill  values('000003','0001')
insert into employeeskill  values('000003','0006')
insert into employeeskill  values('000003','0016')
insert into employeeskill  values('000003','0020')
--
insert into employeeskill  values('000004','0001')
insert into employeeskill  values('000004','0006')
insert into employeeskill  values('000004','0009')
insert into employeeskill  values('000004','0010')
insert into employeeskill  values('000004','0012')
insert into employeeskill  values('000004','0015')
insert into employeeskill  values('000004','0018')
insert into employeeskill  values('000004','0020')
insert into employeeskill  values('000004','0021')
insert into employeeskill  values('000004','0013')
--
insert into employeeskill  values('000005','0001')
insert into employeeskill  values('000005','0006')
insert into employeeskill  values('000005','0009')
insert into employeeskill  values('000005','0010')
insert into employeeskill  values('000005','0012')
insert into employeeskill  values('000005','0015')
insert into employeeskill  values('000005','0018')
insert into employeeskill  values('000005','0020')
insert into employeeskill  values('000005','0021')
insert into employeeskill  values('000005','0013')
--
insert into employeeskill  values('000006','0001')
insert into employeeskill  values('000006','0006')
insert into employeeskill  values('000006','0009')
insert into employeeskill  values('000006','0010')
insert into employeeskill  values('000006','0012')
insert into employeeskill  values('000006','0015')
insert into employeeskill  values('000006','0018')
insert into employeeskill  values('000006','0020')
insert into employeeskill  values('000006','0021')
insert into employeeskill  values('000006','0013')
--
insert into employeeskill  values('000007','0001')
insert into employeeskill  values('000007','0016')
insert into employeeskill  values('000007','0020')
--
insert into employeeskill  values('000008','0001')
insert into employeeskill  values('000008','0016')
insert into employeeskill  values('000008','0020')
--
insert into employeeskill  values('000009','0001')
insert into employeeskill  values('000009','0018')
insert into employeeskill  values('000009','0017')
insert into employeeskill  values('000009','0020')
--
insert into employeeskill  values('000010','0001')
insert into employeeskill  values('000010','0016')
insert into employeeskill  values('000010','0020')
--
insert into employeeskill  values('000011','0001')
insert into employeeskill  values('000011','0016')
insert into employeeskill  values('000011','0020')
insert into employeeskill  values('000011','0014')
insert into employeeskill  values('000011','0008')
--
insert into employeeskill  values('000012','0001')
insert into employeeskill  values('000012','0006')
insert into employeeskill  values('000012','0009')
insert into employeeskill  values('000012','0010')
insert into employeeskill  values('000012','0012')
insert into employeeskill  values('000012','0015')
insert into employeeskill  values('000012','0018')
insert into employeeskill  values('000012','0020')
insert into employeeskill  values('000012','0021')
insert into employeeskill  values('000012','0013')
--
insert into employeeskill  values('000013','0001')
insert into employeeskill  values('000013','0006')
insert into employeeskill  values('000013','0009')
insert into employeeskill  values('000013','0010')
insert into employeeskill  values('000013','0012')
insert into employeeskill  values('000013','0015')
insert into employeeskill  values('000013','0018')
insert into employeeskill  values('000013','0020')
insert into employeeskill  values('000013','0021')
insert into employeeskill  values('000013','0013')
--
insert into employeeskill  values('000014','0001')
insert into employeeskill  values('000014','0006')
insert into employeeskill  values('000014','0009')
insert into employeeskill  values('000014','0010')
insert into employeeskill  values('000014','0012')
insert into employeeskill  values('000014','0015')
insert into employeeskill  values('000014','0018')
insert into employeeskill  values('000014','0020')
insert into employeeskill  values('000014','0021')
insert into employeeskill  values('000014','0013')
--
insert into employeeskill  values('000015','0001')
insert into employeeskill  values('000015','0016')
insert into employeeskill  values('000015','0020')
go
/* data for external candidate */
raiserror('Inserting data in CandidateSkill table....',0,1)
insert into candidateskill values('000001','0001')
insert into candidateskill values('000001','0006')
insert into candidateskill values('000001','0009')
insert into candidateskill values('000001','0010')
insert into candidateskill values('000001','0012')
insert into candidateskill values('000001','0013')
insert into candidateskill values('000001','0015')
insert into candidateskill values('000001','0018')
insert into candidateskill values('000001','0020')
insert into candidateskill values('000001','0021')
insert into candidateskill values('000003','0001')
insert into candidateskill values('000003','0009')
insert into candidateskill values('000003','0010')
insert into candidateskill values('000003','0012')
insert into candidateskill values('000003','0015')
insert into candidateskill values('000003','0018')
insert into candidateskill values('000004','0001')
insert into candidateskill values('000004','0006')
insert into candidateskill values('000004','0016')
insert into candidateskill values('000004','0020')
insert into candidateskill values('000005','0001')
insert into candidateskill values('000005','0006')
insert into candidateskill values('000005','0009')
insert into candidateskill values('000005','0010')
insert into candidateskill values('000005','0012')
insert into candidateskill values('000005','0013')
insert into candidateskill values('000005','0015')
insert into candidateskill values('000005','0018')
insert into candidateskill values('000005','0020')
insert into candidateskill values('000005','0021')
insert into candidateskill values('000010','0001')
insert into candidateskill values('000010','0006')
insert into candidateskill values('000010','0009')
insert into candidateskill values('000010','0010')
insert into candidateskill values('000010','0012')
insert into candidateskill values('000010','0013')
insert into candidateskill values('000010','0015')
insert into candidateskill values('000010','0018')
insert into candidateskill values('000010','0020')
insert into candidateskill values('000010','0021')
insert into candidateskill values('000014','0001')
insert into candidateskill values('000014','0006')
insert into candidateskill values('000014','0009')
insert into candidateskill values('000014','0010')
insert into candidateskill values('000014','0012')
insert into candidateskill values('000014','0013')
insert into candidateskill values('000014','0015')
insert into candidateskill values('000014','0018')
insert into candidateskill values('000014','0020')
insert into candidateskill values('000014','0021')
insert into candidateskill values('000016','0001')
insert into candidateskill values('000016','0016')
insert into candidateskill values('000016','0020')
insert into candidateskill values('000018','0001')
insert into candidateskill values('000018','0016')
insert into candidateskill values('000018','0020')
insert into candidateskill values('000026','0001')
insert into candidateskill values('000026','0017')
insert into candidateskill values('000026','0018')
insert into candidateskill values('000026','0020')
insert into candidateskill values('000029','0001')
insert into candidateskill values('000029','0016')
insert into candidateskill values('000029','0020')
insert into candidateskill values('000035','0001')
insert into candidateskill values('000035','0008')
insert into candidateskill values('000035','0014')
insert into candidateskill values('000035','0016')
insert into candidateskill values('000035','0020')
insert into candidateskill values('000039','0001')
insert into candidateskill values('000039','0006')
insert into candidateskill values('000039','0009')
insert into candidateskill values('000039','0010')
insert into candidateskill values('000039','0012')
insert into candidateskill values('000039','0013')
insert into candidateskill values('000039','0015')
insert into candidateskill values('000039','0018')
insert into candidateskill values('000039','0020')
insert into candidateskill values('000039','0021')
insert into candidateskill values('000045','0001')
insert into candidateskill values('000045','0006')
insert into candidateskill values('000045','0009')
insert into candidateskill values('000045','0010')
insert into candidateskill values('000045','0012')
insert into candidateskill values('000045','0013')
insert into candidateskill values('000045','0015')
insert into candidateskill values('000045','0018')
insert into candidateskill values('000045','0020')
insert into candidateskill values('000045','0021')
insert into candidateskill values('000046','0001')
insert into candidateskill values('000046','0006')
insert into candidateskill values('000046','0009')
insert into candidateskill values('000046','0010')
insert into candidateskill values('000046','0012')
insert into candidateskill values('000046','0013')
insert into candidateskill values('000046','0015')
insert into candidateskill values('000046','0018')
insert into candidateskill values('000046','0020')
insert into candidateskill values('000046','0021')
insert into candidateskill values('000047','0001')
insert into candidateskill values('000047','0016')
insert into candidateskill values('000047','0020')
go

raiserror('Inserting data in Position table....',0,1)
insert into positionskill values('0001','0001')
insert into positionskill values('0001','0006')
insert into positionskill values('0002','0001')
insert into positionskill values('0002','0006')
insert into positionskill values('0003','0001')
insert into positionskill values('0004','0001')
insert into positionskill values('0004','0002')
insert into positionskill values('0004','0003')
insert into positionskill values('0004','0005')
insert into positionskill values('0004','0006')
insert into positionskill values('0005','0001')
insert into positionskill values('0005','0005')
insert into positionskill values('0005','0006')
insert into positionskill values('0006','0001')
go

raiserror('Inserting data in EmployeeReferral table....',0,1)
insert into employeereferrals values('000001','000001','000021')
insert into employeereferrals values('000002','000002','000018')
insert into employeereferrals values('000003','000001','000014')
go

raiserror('Inserting data in Requisition table....',0,1)
INSERT into Requisition 
VALUES('000001','0003','03/03/1999','04/04/1999','0009','Texas',10)
INSERT into Requisition 
VALUES('000002','0002','05/06/1999','06/07/1999','0002','Texas',11)
INSERT into Requisition 
VALUES('000004','0015',getdate(),getdate()+7,'0003','Texas',12)
raiserror('Database is now ready for use...',0,1)

