#include <stdio.h> 
int main() 
{ 
	int a,b;
	printf("Enter 2 nos\n");
	scanf("%d",&a); // enter 1st no
	scanf("%d",&b); // enter 2nd no
	printf("Before Swapping: a = %d, b = %d\n",a,b);
	int temp; // temporary variable
	temp = a;
	a = b;
	b = temp;
	printf("After Swapping: a = %d, b = %d",a,b); // nos are swapped
} 
