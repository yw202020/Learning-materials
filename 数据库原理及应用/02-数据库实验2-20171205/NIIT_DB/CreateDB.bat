rem ���� 2003/09/07 23:18����


rem ����CreditCard���ݿ⣬���ܻ�ʹ��10��ʱ��
osql	-E	-S.\SQLEXPRESS	-iCreditCard.sql

rem ����OnlineBanking���ݿ⣬���ܻ�ʹ��10--30��ʱ��
osql	-E	-S.\SQLEXPRESS	-iOnlineBanking.sql

rem ����Recruitment���ݿ⣬���ܻ�ʹ��10--30��ʱ��
osql	-E	-S.\SQLEXPRESS	-iRecruitment.sql

rem ����ToyUniverse���ݿ⣬���ܻ�ʹ��10--30��ʱ��,�����ĵȴ�
osql	-E	-S.\SQLEXPRESS	-iToyUniverse.sql

rem ����VideoKiosk���ݿ�
osql	-E	-S.\SQLEXPRESS	-iVideoKiosk.sql


rem ��ӡ������Ϣ
cls
type Readme.txt|more
