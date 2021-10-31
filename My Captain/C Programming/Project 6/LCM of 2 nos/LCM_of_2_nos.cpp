#include<stdio.h>

int max;

int LCM(int a,int b)
{
	if(max%a==0 && max%b==0)
	{
		return(max);
	}
	else
	{
		max++;
		return(LCM(a,b));
	}
}

int main()
{
	int a,b;
	printf("Enter 2 nos: \n");
	scanf("%d",&a);
	scanf("%d",&b);
	max = a > b ? a : b;
	printf("LCM of %d and %d is %d",a,b,LCM(a,b));
	return(0);
}