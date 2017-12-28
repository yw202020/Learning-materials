/*
创建西南石油大学学生数据库
特别说明：以下信息中，学号和姓名是真实的，请勿外泄。
除学号和姓名之外，例如考试分数、手机号等，是随机产生的。
SQL脚本作者 周永  v201712
*/
Use Master
Go

if exists(select * from sysdatabases where name='SwpuStu')
begin
  print '删除原有数据库...'
  drop database SwpuStu
end

print '1.创建数据库'
Create Database SwpuStu
Go

Use SwpuStu
Go

print '2.创建表结构'
--院系表
Create Table Depart
(
 cDepartNo char(2) NOT NULL Constraint PK_Depart_No Primary Key, --院系编号，主关键字
 vName varchar(30) NOT NULL  --院系名称，最多15个汉字
)
Go


--专业表
Create Table Major
(
 cMajorNo char(7) NOT NULL Constraint PK_Major_No Primary Key, --院系编号，主关键字，正常是6位，部分专业需要7位
 vName varchar(30) NOT NULL  --专业名称，最多15个汉字
)
Go

/*
学生表Student，10个属性
学号，姓名，性别，出生日期，民族，政治面貌，
院系编号，专业编号，年级，寝室号，联系电话
*/
Create Table Student
(
 cNo char(12) NOT NULL Constraint PK_Stu_No Primary Key, --学号，12位，主关键字
 vName varchar(30) NOT NULL, --姓名最多允许15个汉字
 cSex char(2) NULL, --性别，一个汉字
 dBirth datetime, --出生日期
 vNation varchar(20) NULL, --民族，最多允许10个汉字
 cPolicitalStatus char(8) NULL, --政治面貌，共产党员，共青团员，群众
 cDepartNo char(2) NOT NULL Constraint FK_Depart_Student_No Foreign Key References Depart(cDepartNo), --院系编号，固定长度两位
 cMajorNo char(7) NOT NULL Constraint FK_Major_Student_No Foreign Key References Major(cMajorNo),  --专业编号，需要和主键表长度一致
 iGrade int NOT NULL, --年级，冗余字段，等于学号的左边四位
 cDormNo char(6) NULL, --寝室号，格式如：19-203
 cPhone char(11) NULL  --手机号码
)
Go

/*
课程相关信息
Course表：课程号，课程名，学分，学时
*/
Create Table Course
(
 cCourseNo char(10) NOT NULL Constraint PK_Course_No Primary Key,--课程号
 vCourseName varchar(30) NOT NULL, --课程名
 iCredit int NOT NULL, --学分
 iHours int NOT NULL --学时
)
Go

/*
学生的分数
Score表：学号，课程号，分数，学期，录入成绩时间
*/
Create Table Score
(
  cNo char(12) Not NULL Constraint FK_Student_Score_No Foreign Key References Student(cNo), --学号
  cCourseNo char(10) NOT NULL Constraint FK_Course_Score_No  Foreign Key References Course(cCourseNo), --课程号
  nScore numeric(4,1) NULL, --总长度四位，三位整数，一位小数
  tSemester tinyint NULL, --学时在第几学期取得的成绩，只存放1到8之间的整数
  dDate datetime NULL --教师为该课程录入成绩的时间
)
Go


print '3.插入数据'
--下面是插入数据
Insert into Depart Values('01','石油与天然气工程学院');
Insert into Depart Values('02','地球科学与技术学院');
Insert into Depart Values('03','机电工程学院');
Insert into Depart Values('04','化学化工学院');
Insert into Depart Values('05','材料科学与工程学院');
Insert into Depart Values('06','计算机科学学院');
Insert into Depart Values('07','电气信息学院');
Insert into Depart Values('08','土木工程与建筑学院');
Insert into Depart Values('09','理学院');
Insert into Depart Values('10','经济管理学院/MBA教育中心法学院');
Insert into Depart Values('11','马克思主义学院');
Insert into Depart Values('12','外国语学院');
Insert into Depart Values('13','体育学院（体育工作委员会）');
Insert into Depart Values('14','艺术学院');

Insert into Major Values('080901','计算机科学与技术');
Insert into Major Values('080902','软件工程');
Insert into Major Values('080903','网络工程');
Insert into Major Values('080905','物联网工程');
Insert into Major Values('120102','信息管理与信息系统');

Insert into Course values ('9812202040','单片机与SoC',4,64);
Insert into Course values ('9812204040','物联网信息感知技术',4,64);
Insert into Course values ('5607602035','数据库原理及应用',4,64);


Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010101','马圆媛','女 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010102','梁健芬','女 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010103','颜熙','女 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010104','银盈','女 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010105','吴姝泓','女 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010106','冯玲琳','女 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010108','高寒','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010111','李东楠','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010113','向桔冰','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010116','曾大宇','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010117','肖俊岑','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010118','羊薇迪','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010119','杜广','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010122','赵辉','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010126','谭伟','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010127','黄森','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010128','黄帷','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010130','付小斌','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010201','张绿蕾','女 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010202','李爱红','女 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010203','吴帮莹','女 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010204','蒲雨琪','女 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010205','辛雪静','女 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010206','徐志远','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010207','李镠','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010208','杨军','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010209','许瑾','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010210','曾渌麟','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010212','李丹曦','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010214','徐锡','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010215','叶毅','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010216','鲁智远','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010218','刘锟','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010219','华杰','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010221','蔡凯文','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010222','邓磊','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010224','蔡扬','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010225','秦吉','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010226','唐坤','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010227','邹海瑞','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010228','付林盛','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010230','唐文阳','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010301','宋样','女 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010302','李曼','女 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010303','杜星','女 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010304','胡昳','女 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010306','魏鸿','女 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010307','李弘峰','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010309','曹志涛','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010310','卢浩','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010311','王磊','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010312','李祥','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010314','母涛','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010315','梁礼洋','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010316','袁智','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010317','汤宝锏','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010318','肖杰','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010319','周俊威','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010322','詹杰','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010323','伍中华','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010324','蒋孟春','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010326','顾浩觉','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010328','卿建章','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010329','张傲','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010401','刘碧清','女 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010403','杨茜','女 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010404','王娟','女 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010405','张颖颖','女 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010406','张富玲','女 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010407','柳朝顺','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010409','倪英迪','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010410','赵凡','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010415','贺顺龙','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010416','唐浩然','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010417','胡刘海','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010419','任奕林','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010420','谭强','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010424','周杰','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010425','张珂','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010426','祝烨','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010428','曾云姜','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010429','田浩然','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205010430','周磊','男 ','06','080901',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020102','朱璐瑶','女 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020103','谭环','女 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020104','刘倩倩','女 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020106','蔡海艳','女 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020107','王莎','女 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020108','米南阳','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020109','靳建平','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020111','陈福康','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020113','成宇','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020114','曾荻阳','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020115','李嘉明','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020116','林思瀚','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020117','苏蔚','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020118','符亮星','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020119','王贤杰','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020120','汤绍文','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020123','邹文凯','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020124','堵俊杰','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020125','黄亚岚','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020126','张荣鑫','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020127','白俊','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020128','周渝森','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020130','李俊达','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020132','向川','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020135','敬智杰','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020136','杨攀','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020201','陈萍','女 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020202','古英','女 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020205','邓婷婷','女 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020206','黄琦','女 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020208','乔振豪','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020209','张佳民','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020211','王飞腾','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020212','冯启晨','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020214','高南岚','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020215','韩博','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020216','李志强','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020217','欧阳建宇','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020219','易树良','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020220','张超','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020221','魏兵','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020222','杨国伟','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020225','敬泽中','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020226','韦涵宇','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020228','康富安','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020232','黄何','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020233','李明林','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020234','刘川博','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020235','吴彦学','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020236','杨杰','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020237','姜秋平','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020238','赵泽宇','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020301','蒋梦颖','女 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020302','孙庆娜','女 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020303','葛忆','女 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020304','徐梦莹','女 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020307','吴亚玲','女 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020310','白晏丞','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020311','曹壮','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020314','梁鑫','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020315','王涛','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020316','赵本东','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020318','刘佳明','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020319','刘超','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020320','陈洪宇','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020321','徐云飞','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020322','陈堃','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020323','骆靖元','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020325','赵剑','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020326','唐才高','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020327','赵颖','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020329','彭亮','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020330','李沿岑','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020331','杨肖','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020332','米南星','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020333','姜亚鹏','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020334','熊大林','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020336','罗玉川','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020337','张元侠','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020401','孟亦男','女 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020402','宋晓南','女 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020403','徐月','女 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020404','陈文心','女 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020405','李惠','女 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020406','伍利','女 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020407','刘美奇','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020408','郑庆刚','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020410','张弛','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020413','禹博伟','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020414','夏宇擎','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020415','欧阳尹虹','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020418','彭勇龙','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020419','刘龙基','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020421','吴勇军','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020422','黄茗','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020424','雷乾','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020425','代博','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020427','邓力峰','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020428','赖全新','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020429','雷海军','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020430','蒋洋','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020434','陈珏修','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205020438','彭超','男 ','06','080902',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030101','曲东怡','女 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030102','隋欢','女 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030103','钱程','女 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030104','曾梦','女 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030105','席文琴','女 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030106','黄筱喆','女 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030107','李中莉','女 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030108','刘美玲','女 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030111','张哲','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030112','张洋','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030113','吴东方','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030114','郭涛','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030116','杨晓龙','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030117','周涛','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030118','何维梁','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030119','胡桐','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030121','邓彬彬','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030122','李家成','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030123','唐一平','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030124','柯涛','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030125','邓君','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030126','洪定国','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030127','杨坤','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030130','郑俊松','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030131','杨杰','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030132','邓云天','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030133','瞿科涛','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030134','喻新潮','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030135','陈柳圻','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030136','罗楷锋','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030137','洪渭澄','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030138','海境','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030139','张超','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030141','朱海宁','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030142','宋喆','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030201','游美娟','女 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030202','马耀璇','女 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030203','刘彩丽','女 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030204','缪杨帆','女 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030205','谢燕','女 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030206','唐维','女 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030207','熊利平','女 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030208','樊娟','女 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030209','高敏','女 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030210','石俊峰','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030211','曹少武','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030212','刘文昌','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030213','徐刘根','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030216','胡鑫','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030218','罗凯','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030219','兰博文','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030220','刘洋洋','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030221','王玺','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030222','赵磊','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030223','陈柏戈','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030225','王志','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030227','鲜鸿伟','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030229','何小波','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030231','许峻华','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030235','王浩','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030236','陈辰','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030238','许斌','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205030241','穆禹锟','男 ','06','080903',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040101','杜凤翎','女 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040103','魏宇笛','女 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040104','朱婷婷','女 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040106','王藜瑾','女 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040107','舒鸿','女 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040108','欧娇','女 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040109','吴雅男','女 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040110','李钊','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040112','石子贤','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040115','侯卓','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040117','黄纯洪','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040118','蒲鹤夫','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040119','喻晨希','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040121','付翔','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040122','林俊','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040123','杨浩章','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040124','唐煌','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040125','张熙祥','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040126','陈超','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040127','张波','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040128','马辉','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040201','唐蕾','女 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040202','钟璐远','女 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040203','陈赛春','女 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040204','樊美琴','女 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040205','王秒','女 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040207','段卓辰','女 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040208','张伊然','女 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040209','杨敏','女 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040210','田广','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040212','迟文林','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040213','朱军','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040214','罗戈石布','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040216','张放','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040217','蒋畅','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040218','游进','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040219','李国冬','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040220','金灵','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040221','符越','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040222','陈可','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040223','刘威','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040224','贺冷豪','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040226','杨光','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040227','王凯','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040228','权赵恒','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040229','李瑞泽','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1205040230','谢佳益','男 ','06','080905',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030102','高超','女 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030103','曲亚男','女 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030105','范军雁','女 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030106','赖红芝','女 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030111','徐小川','女 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030112','王言言','女 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030113','张婉蒂','女 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030114','刘童','女 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030116','刘驰','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030117','汪磊','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030118','叶荣发','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030119','李冰华','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030120','冉物格','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030121','刘岢','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030122','黄一恩','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030125','范忠義','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030126','叶晋池','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030128','李胜祥','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030129','冯凯','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030130','龚晓微','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030201','黄兀','女 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030202','苏润','女 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030203','谢秋','女 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030205','李因时','女 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030206','林凤珠','女 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030207','雷玉婷','女 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030208','蔡欣','女 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030209','泽四姐','女 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030210','四郎青初','女 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030211','马燕','女 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030212','徐畅','女 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030213','张仕焦','女 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030214','金玥乔','女 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030215','王雄','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030216','何正池','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030217','杨岷钢','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030218','吴学谦','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030219','刘海川','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030220','胡晟康','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030221','唐鹏','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030222','马补伙','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030223','切吉尔布','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030224','申文高','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030225','李天蛟','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030227','申晨','男 ','06','120102',2012);
Insert into Student(cNo,vName,cSex,cDepartNo,cMajorNo,iGrade) Values('1209030229','冉江伟','男 ','06','120102',2012);

Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040148','熊旭东','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040110','魏雪梅','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040108','李萍','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040109','苏文雅','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040105','严诗雨','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201309020112','周丽娜','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040132','杨昀杰','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040144','张西','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040111','魏敏','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040101','陈歆鹏','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040145','卢杰','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040130','戴瑞','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040133','柴林波','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040131','倪川','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040146','余池','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040138','周星宇','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040119','张龙','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040122','陈潜','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040104','杨越','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040117','刘冬冬','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040121','胡洋','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040103','霍敏','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040127','李忠','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040150','周凤林','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040151','鲁湘','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040136','陈开勇','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040143','曹勇','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040141','刘康','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040137','汪国兴','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040102','王艺洁','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040149','蒋杭呈','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040125','严钦','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040123','邹章胤','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040140','余皓翔','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040135','岳林','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040116','尤蒙蒙','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040114','韩亮','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040113','王思舜','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040126','蒲星宇','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040124','赵闽江','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040115','李保杰','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040147','陈中刚','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040118','赵乾','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040129','李一','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201305040152','郭江龙','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('1205040111','唐子翔','男','汉族','共青团员','06','080905',2013);


Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060235','赵圆圆','女','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060236','李可心','女','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060238','杨莹','女','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060240','陈亚萍','女','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060241','李慧莹','女','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060242','王迎春','女','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060244','陈吉它','女','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060245','路哲媛','女','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060246','胡梦秋','女','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060247','李晓煌','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060260','苏杰','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060261','刘涛','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060263','孙子焱','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060264','朱帅','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060265','何伟','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060266','林庆','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060267','邱航','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060269','徐博','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060271','吴国强','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060273','刘朗','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060275','肖仕静','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060277','杨杰','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060280','谢君翊','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060281','向康','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060282','李祥','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060284','杨娇','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060285','严华楠','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060286','胡毅','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060288','付东方','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060290','张赟','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060291','吴昊','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060292','刘文程','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060293','毛雨杰','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060294','肖近秋','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060296','蒲杨','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060298','赵禾才','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060299','羊荣毅','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431130151','徐志豪','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060237','赵红梅','女','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060248','蒋倩','女','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060249','凡锦玲','女','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060250','张馨尹','女','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060251','胡杰雅','女','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060252','魏彤','女','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060253','程颖','女','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060254','肖亚琴','女','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060255','房薇','女','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060256','周嘉沁','女','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060257','邹芷桐','女','汉族','共产团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060259','易雪','女','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060262','黄之浩','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060300','魏君','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060301','庞坤','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060302','郝立夫','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060303','杨卓宏','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060304','林峰涛','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060306','谢磊','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060307','钟世皓','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060309','胡浩','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060310','邓维','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060311','黄海银','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060312','黄飞','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060313','罗永涛','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060315','夏浩然','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060316','刘汉东','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060317','张泰','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060318','陈科宇','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060319','帅双平','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060321','韩昀辰','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060325','杨雨岱','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060327','徐进','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060328','王怡','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060329','吴豪杰','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060330','陈庙红','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060331','林辉','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060332','李永乐','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060333','朱柯名','男','汉族','共青团员','06','080905',2013);
Insert into Student(cNo,vName,cSex,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201431060334','夏明辉','男','汉族','共青团员','06','080905',2013);


Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060544','罗思维','女','1997-01-01','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060545','明利萍','女','1997-01-02','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060546','王艳','女','1997-01-03','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060547','魏于涵','女','1997-01-04','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060548','郑博','女','1997-01-05','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060549','廖梦羽','女','1997-01-06','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060550','梁琴','女','1997-01-07','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060551','王爱平','女','1997-01-08','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060552','向萱岭','女','1997-01-09','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060553','杨根','男','1997-01-10','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060554','黄书豪','男','1997-01-11','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060555','孟大寓','男','1997-01-12','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060556','徐睿晗','男','1997-01-13','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060557','冉驰昊','男','1997-01-14','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060559','任启强','男','1997-01-15','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060560','杜鹏','男','1997-01-16','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060561','苗幼林','男','1997-01-17','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060562','孔维坤','男','1997-01-18','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060563','杜泽明','男','1997-01-19','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060564','张耀儒','男','1997-01-20','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060565','薛泽','男','1997-01-21','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060566','宋骐飞','男','1997-01-22','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060567','张村','男','1997-01-23','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060568','李林峰','男','1997-01-24','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060569','皮永飞','男','1997-01-25','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060570','石华','男','1997-01-26','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060571','巫传鑫','男','1997-01-27','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060572','何雄','男','1997-01-28','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060573','李友波','男','1997-01-29','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060574','谢宇翔','男','1997-01-30','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060575','曾优美','女','1997-01-31','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060576','何悦','女','1997-02-01','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060577','杨卫平','女','1997-02-02','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060578','吕诺颖','女','1997-02-03','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060579','赖妍菱','女','1997-02-04','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060580','彭媛媛','女','1997-02-05','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060581','杨雪琪','女','1997-02-06','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060582','曹雪梅','女','1997-02-07','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060583','张小敏','女','1997-02-08','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060584','肖子文','男','1997-02-09','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060585','穆博龙','男','1997-02-10','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060586','祝鑫','男','1997-02-11','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060587','杨权','男','1997-02-12','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060588','刘奕羿','男','1997-02-13','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060589','韩梦航','男','1997-02-14','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060590','杨珂尔','男','1997-02-15','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060591','张良','男','1997-02-16','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060592','朱智勇','男','1997-02-17','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060593','张磊','男','1997-02-18','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060594','罗龙','男','1997-02-19','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060595','胡新强','男','1997-02-20','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060596','先伟杰','男','1997-02-21','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060597','李怀谷','男','1997-02-22','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060598','李志钰','男','1997-02-23','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060599','曾辉洋','男','1997-02-24','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060600','姚雪雨','男','1997-02-25','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060601','杜宇','男','1997-02-26','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060602','王开来','男','1997-02-27','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060603','卢俊邑','男','1997-01-01','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060604','宋书磊','男','1997-01-02','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060605','俞海','男','1997-01-03','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('1105010105','李静','女','1997-01-04','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060606 ','季华','女','1997-01-05','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060607 ','罗瑶','女','1997-01-06','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060608 ','刘懿庆','女','1997-01-07','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060609 ','王梓宥','女','1997-01-08','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060610 ','吴琼','女','1997-01-09','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060611 ','徐静','女','1997-01-10','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060612 ','胡文','女','1997-01-11','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060613 ','刘思敏','女','1997-01-12','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060614 ','刘婷怡','女','1997-01-13','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060615 ','罗小龙','男','1997-01-14','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060616 ','王萍','男','1997-01-15','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060617 ','游伟','男','1997-01-16','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060618 ','易小风','男','1997-01-17','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060619 ','王圣文','男','1997-01-18','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060620 ','唐光圣','男','1997-01-19','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060621 ','刘卓林','男','1997-01-20','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060622 ','龚睿','男','1997-01-21','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060623 ','郑伟','男','1997-01-22','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060624 ','李雙江','男','1997-01-23','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060625 ','郭锋锐','男','1997-01-24','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060626 ','张健淞','男','1997-01-25','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060627 ','邓旭','男','1997-01-26','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060628 ','冯涛','男','1997-01-27','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060629 ','陈仁杰','男','1997-01-01','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060630 ','王洪','男','1997-01-02','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060631 ','邵永杰','男','1997-01-03','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060632 ','梁凌峰','男','1997-01-04','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060633 ','杨松柏','男','1997-01-05','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060634 ','周成','男','1997-01-06','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060635 ','吉锋涛','男','1997-01-07','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060636 ','王沛然','男','1997-01-08','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060637 ','郑红柳','女','1997-01-09','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060638 ','李玲','女','1997-01-10','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060639 ','沈湘渝','女','1997-01-11','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060640 ','吕亚兰','女','1997-01-12','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060641 ','罗雪','女','1997-01-13','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060642 ','黄懿璇','女','1997-01-14','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060643 ','邱丁香','女','1997-01-15','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060644 ','谢文娜','女','1997-01-16','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060645 ','杜雨奇','女','1997-01-17','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060646 ','李一凡','男','1997-01-18','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060647 ','陈前伍','男','1997-01-19','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060648 ','马畅','男','1997-01-20','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060649 ','江承轩','男','1997-01-21','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060650 ','刘海川','男','1997-01-22','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060651 ','陈科宇','男','1997-01-23','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060652 ','李威','男','1997-01-24','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060653 ','邓凯','男','1997-01-25','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060654 ','朱志文','男','1997-01-26','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060655 ','王韬铭','男','1997-01-27','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060656 ','王然','男','1997-01-28','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060657 ','刘建明','男','1997-01-29','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060658 ','钟家辉','男','1997-01-30','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060659 ','毛伟丞','男','1997-01-31','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060660 ','杨鑫','男','1997-02-01','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060661 ','吴海峰','男','1997-02-02','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060662 ','张攀','男','1997-02-03','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060663 ','谭彪','男','1997-02-04','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060664 ','田峰','男','1997-02-05','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060665 ','李莲庆','男','1997-02-06','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060666 ','任治林','男','1997-02-07','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060667 ','王森','男','1997-02-08','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060668 ','王春成','男','1997-02-09','汉族','共青团员','06','080905',2015);
Insert into Student(cNo,vName,cSex,dBirth,vNation,cPolicitalStatus,cDepartNo,cMajorNo,iGrade) Values('201531060669 ','邓宇恒','男','1997-02-10','汉族','共青团员','06','080905',2015);

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

print  CONVERT(varchar(100), GETDATE(), 121)+' 成功创建数据库'
print '数据仅限教学使用，请注意保密'

select *  from student

