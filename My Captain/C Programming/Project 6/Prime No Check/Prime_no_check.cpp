#include<stdio.h>

int isPrime(int n, int i = 2)
{
	if(n==2)
	{
		return(1);
	}
	else
	{
		if(i<n)
		{
			if(n%i!=0)
			{
				if(i<n)
				{
					return(isPrime(n,i=i+1));
				}	
				else
				{
					printf("%d ",i);
					return(1);
				}
			}
			else
			{
				return(0);
			}
		}
		else
		{
			return(1);
		}
	}
}

int main()
{
	int n;
	printf("Enter a no: -\n");
	scanf("%d",&n);
	if(isPrime(n))
	{
		printf("%d is a prime no",n);
	}
	else
	{
		printf("%d is not a prime no",n);
	}
	return(0);
}