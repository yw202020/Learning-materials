--2003-09-07 22:49 周永更正


--创建数据库
set nocount    on
USE master

if exists (select * from sysdatabases where name='VideoKiosk')
begin
  raiserror('Dropping existing VideoKiosk database ....',0,1)
  DROP database VideoKiosk
end
GO


raiserror('Creating VideoKiosk database....',0,1)
CREATE DATABASE VideoKiosk
GO

--创建结构
--2003-09-07 12:24
use VideoKiosk

print 'current database is VideoKiosk'

create table MovieRating
(cRatingId char(5) constraint pk_Rating primary key,
vDescription varchar(10) not null)

print 'Movie Rating'

create table MovieCategory
(cCategoryId char(5) constraint pk_Category primary key,
vCategory varchar(25) not null)

print 'MovieCategory'

create table Director
(cDirectorId char(5) constraint pk_Director primary key,
vFirstName varchar(50) not null,
vLastName varchar(50),
cGender char(1),
dDateOfBirth datetime,
vBackground varchar(255),
vPicture varchar(150))

print 'Director'

create table Producer
(cProducerId char(5) constraint pk_Producer primary key,
vName varchar(25) not null)

print 'Producer'

create table Movie
(cMovieId char(5) constraint pk_Movie primary key,
vTitle varchar(40) not null,
cDirectorId char(5)constraint fk_MovieDirector foreign key references Director(cDirectorId),
cProducerId char(5)constraint fk_MovieProducer foreign key references Producer(cProducerId),
iDuration int,
vDescription varchar(255),
cRatingId char(5)constraint fk_MovieRating foreign key references MovieRating(cRatingId),
cCategoryId char(5)constraint fk_MovieCategory foreign key references MovieCategory(cCategoryId),
vPicture varchar(150),
vClipping varchar(150))

print 'Movie'

create table Customer
(cCustomerId char(5) constraint pk_Customer primary key,
vFirstName varchar(50) not null,
vLastName varchar(50),
vAddress varchar(25),
vCity varchar(25),
cState char(15),
cZip char(7),
cPhone char(10),
vMailId varchar(50),
dDateOfBirth datetime)

print 'Customer'

create table Orders
(cOrderId char(5) constraint pk_Sales primary key,     
dOrderDate datetime not null,
cCustomerId char(5)constraint fk_OrdersCustomer foreign key references Customer(cCustomerId),
cCreditCardNumber char(16) not null,
mOrderValue money not null)

print 'Orders'

create table MovieAwards
(cMovieId char(5) constraint fk_MovieAwardsMovie foreign key references Movie(cMovieId),
vAward varchar(25) not null,
vDescription varchar(25),
iYear int)

print 'MovieAwards'

create table Video
(cVideoId char(5) constraint pk_Video primary key,
cMovieId char(5) constraint fk_VideoMovie foreign key references Movie(cMovieId),
cVideoFormat char(4) not null,
mPrice money not null)

print 'Video'

create table OrderDetail
(cOrderId char(5) constraint fk_OrderDetailOrders foreign key references Orders(cOrderId),
cVideoId char(5)constraint fk_OrderDetailVideo foreign key references Video(cVideoId),
iQuantity int not null)

print 'OrderDetail'

create table Actor
(cActorId char(5) constraint pk_Actor primary key,
vFirstName varchar(50) not null,
vLastName varchar(50),
dDateOfBirth DateTime,
cGender char(2),
vBackground varchar(255),
vPicture varchar(150))

print 'Actor'

create table ActorAwards
(cActorId char(5) constraint fk_ActorAwardsActor foreign key references Actor(cActorId),
cMovieId char(5) constraint fk_ActorAwardsMovie foreign key references Movie(cMovieId),
vAwards varchar(25) not null,
vDescription varchar(25),
iYear int)

print 'ActorAwards'

create table ActorMovie
(cActorId char(5) constraint fk_ActorMovieActor foreign key references Actor(cActorId),
cMovieId char(5) constraint fk_ActorMovieMovie foreign key references Movie(cMovieId),
cRole char(1) not null)

print 'ActorMovie'

create table DirectorAwards
(cDirectorId char(5) constraint fk_DirectorAwardsDirector foreign key references Director(cDirectorId),
cMovieId char(5) constraint fk_DirectorAwardsMovie foreign key references Movie(cMovieId),
vAward char(25) not null,
vDescription varchar(25),
iYear int)

print 'DirectorAwards'
go


create trigger trgInsertActor on Actor
for insert 
as
begin

declare @cServerName char(20)
declare @cPicsPath char(30)

select @cServerName=@@servername
select @cPicsPath='\\'+@@servername+'\Pics\'

update Actor
set Actor.vPicture=inserted.vPicture
from Actor,inserted
where inserted.cActorId=Actor.cActorId

end
go

create trigger trgUpdateActor on Actor
for update
as
begin
declare @cServerName char(20)
declare @cPicsPath char(30)

select @cServerName=@@servername
select @cPicsPath='\\'+@@servername+'\pics\'
if update(vPicture)
begin
update Actor
set vPicture=rtrim(ltrim(@cPicsPath))+rtrim(ltrim(inserted.vPicture))
from Actor,inserted
where inserted.cActorId=Actor.cActorId
end
end
go


create trigger trgInsertDirector on Director
for insert 
as
begin

declare @cServerName char(20)
declare @cPicsPath char(30)

select @cServerName=@@servername
select @cPicsPath='\\'+@@servername+'\Pics\'

update Director
set Director.vPicture=inserted.vPicture
from Director,inserted
where inserted.cDirectorId=Director.cDirectorId

end
go

create trigger trgUpdateDirector on Director
for update
as
begin

declare @cServerName char(20)
declare @cPicsPath char(30)

select @cServerName=@@servername
select @cPicsPath='\\'+@@servername+'\pics\'
if update(vPicture)
begin
update Director
set vPicture=rtrim(ltrim(@cPicsPath))+rtrim(ltrim(inserted.vPicture))
from Director,inserted
where inserted.cDirectorId=Director.cDirectorId
end
end
go

create trigger trgInsertMovie on Movie
for insert 
as
begin

declare @cServerName char(20)
declare @cPicsPath char(30)
declare @cMoviePath char(30)

select @cServerName=@@servername
select @cPicsPath='\\'+@@servername+'\Pics\'
select @cMoviePath='\\'+@@servername+'\Movie\'

update Movie
set Movie.vPicture=inserted.vPicture
from Movie,inserted
where inserted.cMovieId=Movie.cMovieId

update Movie
set Movie.vClipping=inserted.vClipping
from Movie,inserted
where inserted.cMovieId=Movie.cMovieId
end
go

create trigger trgUpdateMovie on Movie
for update
as
begin
declare @cServerName char(20)
declare @cPicsPath char(30)
declare @cMoviesPath char(30)

select @cServerName=@@servername
select @cPicsPath='\\'+@@servername+'\pics\'
select @cMoviesPath='\\'+@@servername+'\Movie\'
if update(vPicture)
begin
update Movie
set vPicture=rtrim(ltrim(@cPicsPath))+rtrim(ltrim(inserted.vPicture))
from Movie,inserted
where inserted.cMovieId=Movie.cMovieId
end

if update(vClipping)
begin
update Movie
set vClipping=rtrim(ltrim(@cMoviesPath))+rtrim(ltrim(inserted.vClipping))
from Movie,inserted
where inserted.cMovieId=Movie.cMovieId
end
end
go

create procedure prcActorAutoGen @iIncrement int output
as
declare @cActorId char(5)
select @cActorId=max(cActorId) from Actor
select @iIncrement=convert(int,substring(@cActorId,2,4))+1
return
go

create procedure prcOrderAutoGen @iIncrement int output
as
declare @cOrderId char(5)
select @cOrderId=max(cOrderId) from Orders
select @iIncrement=convert(int,substring(@cOrderId,2,4))+1
return
go

create procedure prcDirectorAutoGen @iIncrement int output
as
declare @cDirId char(5)
select @cDirId=max(cDirectorId) from Director
select @iIncrement=convert(int,substring(@cDirId,2,4))+1
return
go


--添加数据
--2003-09-07 12:30--


use VideoKiosk

--inserting data into MovieRating 
insert MovieRating values('MR001','Not Rated')
insert MovieRating values('MR002','PG-13')
insert MovieRating values('MR003','R')
insert MovieRating values('MR004','PG')

--inserting data into MovieCategory
insert MovieCategory values('MC001','Classic')
insert MovieCategory values('MC002','Action & Adventure')
insert MovieCategory values('MC003','Science Fiction')
insert MovieCategory values('MC004','Romance')

--inserting data into Director
insert Director(cDirectorId,vFirstName,vLastName,cGender,vPicture) values('D0001','J.Lee','Thompson','M','na.gif')
insert Director(cDirectorId,vFirstName,vLastName,cGender,vPicture) values('D0002','Martin','Campbell','M','na.gif')
insert Director values('D0003','Mel','Gibson','M','1956-03-03','Birthplace : Peekskill, New York, USA','Mel14.gif')
insert Director(cDirectorId,vFirstName,vLastName,cGender,vPicture) values('D0004','David','Lean','M','na.gif')
insert Director(cDirectorId,vFirstName,vLastName,cGender,vPicture) values('D0005','Roger','Spottiswoode','M','na.gif')
insert Director(cDirectorId,vFirstName,vLastName,cGender,vPicture) values('D0006','Roland','Emmerich','M','na.gif')
insert Director values('D0007','James','Cameron','M','1954-08-16','Man obsessed with perfecting the art of story telling.','Cameron.gif')
insert Director values('D0008','Steven','Spielberg','M','1946-12-18','Birthplace : Cincinnati, Ohio, USA.The brilliant mind of Steven Spielberg brings the world more wonders than most would expect from their religion, and amazement which takes us back to our childhood.','spielberg.gif')
insert Director(cDirectorId,vFirstName,vLastName,cGender,vPicture) values('D0009','Mark L.','Lester','M','na.gif')
insert Director(cDirectorId,vFirstName,vLastName,cGender,vPicture) values('D0010','Ted','Kotcheff','M','na.gif')
insert Director(cDirectorId,vFirstName,vLastName,cGender,vPicture) values('D0011','Renny','Harlin','M','na.gif')
insert Director(cDirectorId,vFirstName,vLastName,cGender,vPicture) values('D0012','Richard','Attenborough','M','na.gif')
insert Director(cDirectorId,vFirstName,vLastName,cGender,vPicture) values('D0013','Barry','Levinson','M','na.gif')

--inserting data into Producer
insert Producer values('P0001','Columbia/Tristar')
insert Producer values('P0002','Paramount Pictures')
insert Producer values('P0003','MGM Home Entertainment')
insert Producer values('P0004','Twentyth Century Fox')
insert Producer values('P0005','James Cameron')
insert Producer values('P0006','Universal Studios')
insert Producer values('P0007','Artisan Entertainment')

--inserting data into Movie
insert Movie values('M0001','Mackennas Gold','D0001','P0001',128,'Gold Rush in Grand Canyon','MR001','MC001','Mac.gif',null)

insert Movie values('M0002','The Mask of Zorro','D0002','P0001',137,'Old California adventure story','MR002','MC002','MaskOfZorro.gif',null)

insert Movie values('M0003','BraveHeart','D0003','P0002',177,'Story of a Stottish Commoner who unites the various Clans against the crel King Edward','MR003','MC002','Braveheart.gif',null)

insert Movie values('M0004','Lawrence of Arabia','D0004','P0001',228,'Epic Biographic Adventure of the desert -an all time Action classic.','MR002','MC002','Law.gif',null)

insert Movie values('M0005','Tomorrow Never Dies','D0005','P0003',117,'James Bond movie','MR002','MC002','Bond.gif',null)

insert Movie values('M0006','Independence Day','D0006','P0004',120,'A reporters fierce fight with Extraterrestrials','MR002','MC003','Independenceday.jpg',null)

insert Movie values('M0007','The Terminator','D0007','P0005',108,'A futuristic robot programmed to terminate.','MR003','MC003','Terminator.gif',null)

insert Movie values('M0008','Indiana Jones and the Last Crusade','D0008','P0002',128,'Dr. Jones adventure for treasure','MR004','MC002','Jones1.gif','raidswrd.avi')

insert Movie values('M0009','Indiana Jones and the Temple of Doom','D0008','P0002',118,'Dr. Jones adventure quest for a sacred Indian God.','MR004','MC002','Jones2.gif',null)

insert Movie values('M0010','Jaws','D0008','P0006',125,'A Police officers fight to save beachers from a killer shark','MR004','MC002','Jaws.gif','end.avi')

insert Movie values('M0011','Jurassic Park','D0008','P0006',127,'Where two generations meet, the dinosor and man','MR002','MC003','JurassicPark.gif','t_rex.qt')

insert Movie values('M0012','Titanic','D0007','P0002',194,'Love on the illfated starliner called the TITANIC','MR002','MC004','Titanic.gif',null)

insert Movie values('M0013','Commando','D0009','P0004',90,'Father Saves Nation and Daughter from a neuclear diaster','MR003','MC002','Commando.gif',null)

insert Movie values('M0014','First Blood','D0010','P0007',96,'Revenge drives a war hero','MR003','MC002','FirstBlood.gif',null)

insert Movie values('M0015','Cliffhanger','D0011','P0001',180,'Adventure and rescue by a damned mountaineer','MR003','MC002','Cliffhanger.gif',null)

insert Movie values('M0016','Gandhi','D0012','P0001',190,'The legend called Father of India','MR004','MC001','Gandhi.gif',null)

insert Movie values('M0017','Rain Man','D0013','P0003',133,'A battle between innosence and need','MR003','MC001','Rainman.gif',null)

--inserting data into MovieAwards
insert MovieAwards values('M0003','Best Picture','Oscar',1996)
insert MovieAwards values('M0012','Best Picture','Oscar',1997)
insert MovieAwards values('M0016','Best Picture','Oscar',1983)
insert MovieAwards values('M0017','Best Picture','Oscar',1989)

--inserting data into Video
insert video values('V0001','M0001','VHS',10)
insert video values('V0002','M0002','VHS',14)
insert video values('V0003','M0002','DVD',19.5)
insert video values('V0004','M0003','VHS',21.2)
insert video values('V0005','M0004','VHS',18.7)
insert video values('V0006','M0005','VHS',30)
insert video values('V0007','M0005','DVD',24.5)
insert video values('V0008','M0006','VHS',14)
insert video values('V0009','M0007','VHS',10)
insert video values('V0010','M0007','DVD',21)
insert video values('V0011','M0008','VHS',14)
insert video values('V0012','M0009','VHS',14)
insert video values('V0013','M0010','VHS',15)
insert video values('V0014','M0011','VHS',10)
insert video values('V0015','M0012','VHS',20)
insert video values('V0016','M0013','VHS',14)
insert video values('V0017','M0013','DVD',20)
insert video values('V0018','M0014','DVD',17.5)
insert video values('V0019','M0014','VHS',14)
insert video values('V0020','M0015','VHS',10)
insert video values('V0021','M0016','VHS',21.2)
insert video values('V0022','M0017','DVD',17.5)
insert video values('V0023','M0017','VHS',14)

--Here is oK
---Here


--inserting data into Actor
insert Actor values('A0001','Gregory','Peck','1916-05-04','M','Fullname: Eldred Gregory Peck, Birthplace:La Jolla, California, US','Peck.gif')

insert Actor values('A0002','Antonio','Banderas','10-4-1960','M','Fullname: Jose Antonio Dominguez Bandera, Birthplace:Malaga, Spain','ab2.gif')

insert Actor values('A0003','Anthony','Hopkins','3-10-1937','M','Fullname: Philip Anthony Hopkins, Birthplace:Port Talbot, Wales','Anthony.jpg')

insert Actor values('A0004','Mel','Gibson','3-1-1956','M','Birthplace : Peekskill, New York, USA','Mel14.gif')

insert Actor values('A0005','Patrick','McGoohan',null,'M',null,'na.gif')

insert Actor values('A0006','Joes','Ferrer',null,'M',null,'na.gif')

insert Actor values('A0007','Pierce','Brosnan','1-4-1956','M','Birthplace : Navan, County Meath, Ireland','na.gif')

insert Actor values('A0008','Jonathan','Pryce',null,'M',null,'na.gif')

insert Actor values('A0009','Will','Smith',null,'M',null,'na.gif')

insert Actor values('A0010','Bill','Pullman',null,'M',null,'na.gif')

insert Actor values('A0011','Jeff','Goldblum',null,'M',null,'na.gif')

insert Actor values('A0012','Arnold','Schwarzenegger','3-1-1947','M','Birthplace : Thal, Austria. Bodybuilder turned Actor.','Arnold.gif')

insert Actor values('A0013','Linda','Hamilton','6-9-1956','F','Birthplace : Salisbury,Maryland,USA.','na.gif')

insert Actor values('A0014','Harrison','Ford','3-1-1942','M','Birthplace : Chicago, Illinois.The legendary Indiana Jones.','Harrison.gif')

insert Actor values('A0015','Roy','Scheider',null,'M',null,'na.gif')

insert Actor values('A0016','Sam','Neill',null,'M',null,'na.gif')

insert Actor values('A0017','Leonardo','Di Caprio','11-11-1974','M','Birthplace : Los Angels, CA. The handsom young lad aboard the dream starliner called Titanic.','Leo.gif')

insert Actor values('A0018','Kate','Winslet','5-10-1975','F','Birthplace :Reading, England. One of the 50 Most Beautiful People in the world.','Kate1.gif')

insert Actor values('A0019','Sylvester','Stallon','1946','M','Fullname: Sylvester Enzio Stallon, Birthplace:New York. Known for his memorable role as ''John Rambo'' in First Blood among others.','Stallon.gif')

insert Actor values('A0020','Crenna',null,null,'F',null,'na.gif')

insert Actor values('A0021','Ben','Kingsley','11-11-1943','M','Fullname: Krishna Bhanji, Birthplace:Scarborough, England,U.K. Known for his memorable role in and as Gandhi','Ben.gif')

insert Actor values('A0022','Dustin','Hoffman','8-8-1937','M','Birthplace :Los Angels, Calif, USA.One of the greatest Showmans of Hollywood.','dustin.gif')

insert Actor values('A0023','Tom','Cruise','3-1-1962','M','Fullname: Thomas Cruise Mapother IV, Birthplace:Syracuse, New York(Upstate), USA.','Tom.gif')

insert Actor values('A0024','Catherene Zeta','Jones','5-9-1969','F','Birthplace :Swansea, West Glamorgan, Wales.','Jones.gif')

--inserting data into ActorAwards
insert ActorAwards values('A0021','M0016','Oscar','Best Actor','1983')
insert ActorAwards values('A0022','M0017','Oscar','Best Actor','1989')

--inserting data into ActorMovie
insert ActorMovie values('A0001','M0001','L')
insert ActorMovie values('A0002','M0002','L')
insert ActorMovie values('A0003','M0002','N')
insert ActorMovie values('A0004','M0003','L')
insert ActorMovie values('A0005','M0003','N')
insert ActorMovie values('A0006','M0004','L')
insert ActorMovie values('A0007','M0005','L')
insert ActorMovie values('A0008','M0005','N')
insert ActorMovie values('A0009','M0006','L')
insert ActorMovie values('A0010','M0006','N')
insert ActorMovie values('A0011','M0006','N')
insert ActorMovie values('A0012','M0007','L')
insert ActorMovie values('A0013','M0007','N')
insert ActorMovie values('A0014','M0008','L')
insert ActorMovie values('A0014','M0009','L')
insert ActorMovie values('A0015','M0010','L')
insert ActorMovie values('A0016','M0011','L')
insert ActorMovie values('A0017','M0012','L')
insert ActorMovie values('A0018','M0012','L')
insert ActorMovie values('A0012','M0013','L')
insert ActorMovie values('A0019','M0014','L')
insert ActorMovie values('A0020','M0014','N')
insert ActorMovie values('A0019','M0015','L')
insert ActorMovie values('A0021','M0016','L')
insert ActorMovie values('A0022','M0017','L')
insert ActorMovie values('A0023','M0017','N')
insert ActorMovie values('A0024','M0002','N')
insert ActorMovie values('A0003','M0002','N')

--inserting data into DirectorAwards
insert DirectorAwards values('D0003','M0003','Best Director','Oscar',1996)
insert DirectorAwards values('D0007','M0012','Best Director','Oscar',1997)
insert DirectorAwards values('D0012','M0016','Best Director','Oscar',1983)
insert DirectorAwards values('D0013','M0017','Best Director','Oscar',1989)

--inserting data into customer
insert customer values('C0001','Angela','Smith','16223 Radiance Court','Woodbridge','Virginia','22191','227-2344','angelas@qmail.com','11/24/1975')
insert customer values('C0002','Barbara','Johnson','227 Beach Ave.','Sunnyvale','California','94087','123-5673','barbaraj@speedmail.com','09/11/1956')
insert customer values('C0003','Betty','Williams','1 Tread Road','Virginia Beach','Varginia','23455','458-3299','bettyw@dpeedmil.com','3/21/1961')
insert customer values('C0004','Carol','Jones','765 Furling Road Apt 112','Boone','North Carolina','28607','678-4544','carolj@qmail.com','4/12/1964')
insert customer values('C0005','Catherine','Roberts','5508 Aquiline Court','San Jose','California','95123','445-2256','catheriner@qmail.com','2/22/1972')
insert customer values('C0006','Charles','Brown','7822 S. Glitzy Avenue','Maitland','Florida','32751','225-6678','charlesb@speedmail.com','5/9/1973')
insert customer values('C0007','Christopher','Davis','4896 11th ST','Hill Avenue','Utah','84056','556-9087','Christopherd@qmail.com','7/9/1972')
insert customer values('C0008','Cynthia','Miller','98066 Weary Storm Street','Moon Park','California','93021','422-5688','cynthiam@qmail.com','9/13/1969')
insert customer values('C0009','Daniel','Wilson','4642 Peripheral Drive','Brecksville','Ohio','44141','454-2246','danielw@speedmail.com','7/3/1971')
insert customer values('C0010','David','Moore','8808 Joviality Drive','San Ramon','California','94583','982-5577','davidm@qmail.com','1/1/1970')

--inserting data into orders
insert orders values('O0001','1999-05-20','C0002','5345146765854356',235.5)
insert orders values('O0002','1999-05-20','C0005','3756784562869963',91)
insert orders values('O0003','1999-05-20','C0007','7899887675443322',60)
insert orders values('O0004','1999-05-20','C0006','3454678545443344',10)
insert orders values('O0005','1999-05-21','C0002','5345146765854356',96.7)
insert orders values('O0006','1999-05-21','C0001','6947343412896785',110)
insert orders values('O0007','1999-05-22','C0008','2345566576879900',30)
insert orders values('O0008','1999-05-22','C0009','2345467890986745',28)
insert orders values('O0009','1999-05-22','C0010','2343556678799674',127.5)
insert orders values('O0010','1999-05-22','C0003','4747343412896785',41.2)

--inserting data into orderdetail
insert OrderDetail values('O0001','V0007',3)
insert OrderDetail values('O0001','V0008',3)
insert OrderDetail values('O0002','V0016',3)
insert OrderDetail values('O0003','V0017',3)
insert OrderDetail values('O0004','V0001',1)
insert OrderDetail values('O0005','V0002',4)
insert OrderDetail values('O0005','V0003',1)
insert OrderDetail values('O0005','V0004',1)
insert OrderDetail values('O0006','V0013',2)
insert OrderDetail values('O0006','V0017',1)
insert OrderDetail values('O0007','V0006',1)
insert OrderDetail values('O0008','V0023',2)
insert OrderDetail values('O0009','V0001',2)
insert OrderDetail values('O0009','V0018',1)
insert OrderDetail values('O0010','V0020',2)
insert OrderDetail values('O0010','V0021',1)
insert OrderDetail values('O0001','V0006',4)
insert OrderDetail values('O0002','V0007',2)
insert OrderDetail values('O0009','V0006',3)
insert OrderDetail values('O0006','V0006',2)

raiserror('◆Database VideoKiosk is now ready for use◆ Author:Mr.Zhou ver:2003-09-07',0,1)