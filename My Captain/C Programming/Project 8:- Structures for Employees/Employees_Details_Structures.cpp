#include<stdio.h>

#define no_of_employees 3

struct Employee  
{  
    char Name[20];  
    int Age;  
    char Phone_Number[20];
	int Salary;  
}; 

struct Employee emp[no_of_employees];

void read_Employee_details()
{
	int i;
	for(i=0;i<no_of_employees;i++)
	{
		printf("Enter the details for Employee-%d: -\n",(i+1));
		
		printf("\nEnter the name of the Employee-%d: ",(i+1));
		scanf("%s",&emp[i].Name);
		
		printf("Enter the age of the Employee-%d: ",(i+1));
		scanf("%d",&emp[i].Age);
		
		printf("Enter the phone-no of the Employee-%d: ",(i+1));
		scanf("%s",&emp[i].Phone_Number);
		
		printf("Enter the salary of the Employee-%d: ",(i+1));
		scanf("%d",&emp[i].Salary);
		
		printf("\n");
	} 
}

void print_Employee_details()
{
	int i;
	printf("Employee details are as follows: - \n\n");
	for(i=0;i<no_of_employees;i++)
	{
		printf("Employee details for Employee-%d is : \n\n",(i+1));
		
		printf("Name of the Employee-%d : %s",(i+1),emp[i].Name);
		printf("\nAge of the Employee-%d : %d",(i+1),emp[i].Age);
		printf("\nPhone No of the Employee-%d : %s",(i+1),emp[i].Phone_Number);
		printf("\nSalary of the Employee-%d : %d",(i+1),emp[i].Salary);
		
		printf("\n\n");
	}
}

int main()  
{    
    read_Employee_details();
    print_Employee_details();
    return(0);
}