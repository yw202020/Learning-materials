//encrypt.cpp
#include <iostream>
using namespace std;
int main()
{
	unsigned int iMoney;
	char cNo[13]="201531026789";
	iMoney=49578;

	cout <<"ԭʼ�����ǣ�" <<endl;
	cout <<cNo <<"\t" << (iMoney/100.0) <<endl;

	//������
	int i;
	unsigned int iKey=23456;
	char cKey[13]="www5swpu.edu";

	iMoney = iMoney ^iKey;
	for(i=0; i<12;i++)
		cNo[i] =cNo[i] ^ cKey[i];
	cout <<"����֮��" <<endl;
	cout <<cNo <<"\t" << (iMoney/100.0) <<endl;

	//���ܲ���
	iMoney = iMoney ^iKey;
	for(i=0; i<12;i++)
		cNo[i] =cNo[i] ^ cKey[i];
	cout <<"����֮��" <<endl;
	cout <<cNo <<"\t" << (iMoney/100.0) <<endl;

	return 0;
}