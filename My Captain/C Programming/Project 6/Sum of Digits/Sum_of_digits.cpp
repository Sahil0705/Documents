#include<stdio.h>

int Digital_Sum(int n, int sum);

int main()
{
	int n, sum = 0;
	printf("Enter a no: -\n");
	scanf("%d",&n);
	printf("The sum of the digits in the entered no is : %d",Digital_Sum(n,sum));
	return(0);
}

int Digital_Sum(int n, int sum)
{
	if(n==0)
	{
		return(sum);
	}
	else
	{
		sum = sum + (n%10);
		return(Digital_Sum(n/10,sum));	
	}
}