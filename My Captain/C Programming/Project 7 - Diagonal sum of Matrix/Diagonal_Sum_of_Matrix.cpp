#include<stdio.h>

#define row 3
#define col 3

void read_matrix(int matrix[row][col]);
void print_matrix(int matrix[row][col]);
int diagonal_sum(int matrix[row][col]);

int main()
{
    int matrix[row][col];
    
    printf("Enter elements in the matrix of size %dx%d: \n", row, col);
    read_matrix(matrix);

	printf("\nEntered matrix is : \n");
	print_matrix(matrix);
	
	printf("\nThe diagonal elements of the matrix are : ");
	printf("\n\nThe sum of the diagonal elements of the matrix : %d",diagonal_sum(matrix));
	
	return(0);	
}
void read_matrix(int matrix[row][col])
{
    int i, j;
	
    for (i = 0; i < row; i++)
    {
        for (j = 0; j < col; j++)
        {
            scanf("%d", (*(matrix + i) + j));
        }
    }
}

void print_matrix(int matrix[row][col])
{
    int i, j;

    for (i = 0; i < row; i++)
    {
        for (j = 0; j < col; j++)
        {
            printf("%d ", *(*(matrix + i) + j));
        }
        printf("\n");
    }
}

int diagonal_sum(int matrix[row][col])
{
    int i, j, sum = 0;
	
    for (i = 0; i < row; i++)
    {
        for (j = 0; j < col; j++)
        {             
            if(i==j)
            {
            	printf("%d ",*(*(matrix + i) + j));
            	sum = sum + *(*(matrix + i) + j);
			}
        }
    }
    return(sum);
}