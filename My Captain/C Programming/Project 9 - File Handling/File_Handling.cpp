# include <stdio.h>
# include <string.h>

void write_date(FILE *fp)
{
	fp = fopen("Test.txt", "w");
	char data[20] = "My Captain";
	if(fp == NULL )
	{
		printf("Test.txt file failed to open..");
	}
	else
	{
		printf("Test.txt file is opened...\n\n");
		if(strlen(data)>0)
		{
			fputs(data, fp);
		}
		printf("Data is been written in Test.txt file\n\n");
		
		fclose(fp) ;
		printf("The file is now closed...") ;
	}
}

void read_data(FILE *fp)
{
   fp = fopen("Test.txt", "r");
   
   char read_data[20];
   
   fgets(read_data, 20, (FILE*)fp);
   
   printf("\n\nData read from file : %s", read_data);
   printf("\n\nData read from file in Reversed Format : %s", strrev(read_data));
   
   fclose(fp);

}

void copy_file(FILE *fp)
{
	FILE *fp_copy;
	fp_copy = fopen("Test_Copy.txt", "w");
	char read_data[20];
    fp = fopen("Test.txt", "r");
    
   	fgets(read_data, 20, (FILE*)fp);
   	fputs(read_data, fp_copy);
   	
   	printf("Data is been copied from Test.txt file to Test_Copy.txt file...\n");
}

int main()
{	
	FILE *fp;
	
	printf("Writing Data to the File...\n\n");
	write_date(fp);
	
	printf("\n\n\nReading Data from the File...");
	read_data(fp);
	
	printf("\n\n\nCopying Data from Test.txt file to Test_Copy.txt file...\n\n");
	copy_file(fp);
	
	return(0);
}
