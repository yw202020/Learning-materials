//encryptYiWei.cpp
#include <iostream>
using namespace std;
int main()
{
	unsigned int iMoney;
	char cNo[13]="201531065432";
	iMoney=49578; //11000001 10101010
	              //==>1010101011000001
	int i;

	cout <<"ԭʼ�����ǣ�" <<endl;
	cout <<cNo <<"\t" << (iMoney/100.0) <<endl;

	//iMoney���ֽ�1���ֽ�2����
��	iMoney=(iMoney<<8) +(iMoney>>8);
	//cNo,ÿ���ַ�(8��������λ)������λ�͵���λ����
	for(i=0; i<12;i++)
	{
		char tmp=cNo[i];
		cNo[i]=(tmp <<4) + (tmp >>4);
	}
	cout <<"����֮��" <<endl;
	cout <<cNo <<"\t" << (iMoney/100.0) <<endl;


	//���ܲ���
	iMoney=(iMoney<<8) +(iMoney>>8);
	//cNo,ÿ���ַ�(8��������λ)������λ�͵���λ����
	for(i=0; i<12;i++)
	{
		char tmp2=cNo[i];
		cNo[i]=(tmp2 <<4) + (tmp2 >>4);
	}
	cout <<"����֮��" <<endl;
	cout <<cNo <<"\t" << (iMoney/100.0) <<endl;

	return 0;
}