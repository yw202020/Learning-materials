//encrypt.cpp
#include <iostream>
using namespace std;
int main()
{
	unsigned int iMoney;
	char cNo[13]="201531026789";
	iMoney=49578;

	cout <<"原始数据是：" <<endl;
	cout <<cNo <<"\t" << (iMoney/100.0) <<endl;

	//异或操作
	int i;
	unsigned int iKey=23456;
	char cKey[13]="www5swpu.edu";

	iMoney = iMoney ^iKey;
	for(i=0; i<12;i++)
		cNo[i] =cNo[i] ^ cKey[i];
	cout <<"加密之后：" <<endl;
	cout <<cNo <<"\t" << (iMoney/100.0) <<endl;

	//解密操作
	iMoney = iMoney ^iKey;
	for(i=0; i<12;i++)
		cNo[i] =cNo[i] ^ cKey[i];
	cout <<"解密之后：" <<endl;
	cout <<cNo <<"\t" << (iMoney/100.0) <<endl;

	return 0;
}