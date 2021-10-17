#include<stdio.h>
int main()
{
	int m1,m2,m3,m4,m5;
	printf("Enter the marks for subjct 1: ");
	scanf("%d",&m1);
	printf("Enter the marks for subjct 2: ");
	scanf("%d",&m2);
	printf("Enter the marks for subjct 3: ");
	scanf("%d",&m3);
	printf("Enter the marks for subjct 4: ");
	scanf("%d",&m4);
	printf("Enter the marks for subjct 5: ");
	scanf("%d",&m5);
	
	int tot;
	float per;
	tot = m1+m2+m3+m4+m5;
	printf("The total marks is %d\n",tot);
	
	per = tot/(float)5;
	printf("Percentage is %f\n",per);
	
	printf("Grade: ");
	if(per>=90)
		printf("A grade");
	else if(per>=80 && per<90)
		printf("B Grade");
	else if(per>=65 && per<80)
		printf("C Grade");
	else if(per>=50 && per<65)
		printf("D Grade");
	else if(per>=40 && per<650)
		printf("E Grade");
	else
		printf("Fail");
	
	return(0);
}
