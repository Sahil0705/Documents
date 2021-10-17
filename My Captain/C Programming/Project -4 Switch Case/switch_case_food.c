#include<stdio.h>
int main()
{
	int choice;
	printf("Enter your choice: - ");
	scanf("%d",&choice);
	switch(choice)
	{
		case 1:
			printf("Food item - Pizza, Price - Rs 239");
			break;
		case 2:
			printf("Food item - Burger, Price - Rs 129");
			break;
		case 3:
			printf("Food item - Pasta, Price - Rs 179");
			break;
		case 4:
			printf("Food item - FrenchFries, Price - Rs 99");
			break;
		case 5:
			printf("Food item - Sandwich, Price - Rs 149");
			break;
		default:
			printf("Invalid input");
			break;
	}
	return(0);
}
