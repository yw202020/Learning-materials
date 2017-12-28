16:10 2017-11-28



本次实验核心任务：
1、在数据库中建立三张表
2、往表中输入数据
3、备份数据库，存储到自己邮箱中。

本次实验，操作性质，不写实验报告。

如果已经确定数据服务器处于启动状态
运行窗口输入ssms启动工具
连接的时候，服务器填写：
.\SQLEXPRESS
其中圆点，代表当前计算机。SQLEXPRESS是安装时候的实例名。

也可以在命令行下，输入hostname
获取自己的主机名称，用主机名称连接。
或者是IpConfig 获取IP地址，用IP连接。

net start | find "SQL"

CREATE TABLE [dbo].[SC](
	[sNo] [char](7) NOT NULL,
	[cNo] [char](10) NOT NULL,
	[Grade] [int] NOT NULL
) ON [PRIMARY]

