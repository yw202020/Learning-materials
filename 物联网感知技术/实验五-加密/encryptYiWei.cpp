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

	cout <<"原始数据是：" <<endl;
	cout <<cNo <<"\t" << (iMoney/100.0) <<endl;

	//iMoney，字节1和字节2交换
·	iMoney=(iMoney<<8) +(iMoney>>8);
	//cNo,每个字符(8个二进制位)，高四位和低四位交换
	for(i=0; i<12;i++)
	{
		char tmp=cNo[i];
		cNo[i]=(tmp <<4) + (tmp >>4);
	}
	cout <<"加密之后：" <<endl;
	cout <<cNo <<"\t" << (iMoney/100.0) <<endl;


	//解密操作
	iMoney=(iMoney<<8) +(iMoney>>8);
	//cNo,每个字符(8个二进制位)，高四位和低四位交换
	for(i=0; i<12;i++)
	{
		char tmp2=cNo[i];
		cNo[i]=(tmp2 <<4) + (tmp2 >>4);
	}
	cout <<"解密之后：" <<endl;
	cout <<cNo <<"\t" << (iMoney/100.0) <<endl;

	return 0;
}