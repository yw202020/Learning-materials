rem 周永 2003/09/07 23:18制作


rem 创建CreditCard数据库，可能会使用10秒时间
osql	-E	-S.\SQLEXPRESS	-iCreditCard.sql

rem 创建OnlineBanking数据库，可能会使用10--30秒时间
osql	-E	-S.\SQLEXPRESS	-iOnlineBanking.sql

rem 创建Recruitment数据库，可能会使用10--30秒时间
osql	-E	-S.\SQLEXPRESS	-iRecruitment.sql

rem 创建ToyUniverse数据库，可能会使用10--30秒时间,请耐心等待
osql	-E	-S.\SQLEXPRESS	-iToyUniverse.sql

rem 创建VideoKiosk数据库
osql	-E	-S.\SQLEXPRESS	-iVideoKiosk.sql


rem 打印帮助信息
cls
type Readme.txt|more
