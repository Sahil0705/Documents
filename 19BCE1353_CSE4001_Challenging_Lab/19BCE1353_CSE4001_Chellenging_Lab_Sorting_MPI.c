// Sahil Sachin Donde - 19BCE1353
// CSE4001 - PDC Challenging Lab Exercise
// Sorting using MPI


#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

 
// Following function returns the pivot element in a array: -
// i.e., it returns index among start, mid and end of arrays, whose value lies in between the middle of the other two
// arr is the array whose pivot element has to be found
// start is the starting index of the sub array
// end is the ending index of the sub array
 
int pivot(int* arr, int start, int end) 
{
	int mid = end - (end-start)/2;
	if(arr[start] <= arr[mid] && arr[start] <= arr[end]) 
	{
		if(arr[mid] <= arr[end]) 
		{
			
			return mid;
		} else 
		{
			return end;
		}
	} 
	else if(arr[mid] <= arr[start] && arr[mid] <= arr[end]) 
	{
		if(arr[start] <= arr[end]) 
		{
			return start;
		} 
		else 
		{
			return end;
		}
	} 
	else 
	{
		if(arr[mid] <= arr[start]) 
		{
			return mid;
		} 
		else 
		{
			return start;
		}
	}
}

// Following function swaps the contents of the array at two given indices/places: -
// Arr is the array in which 2 elements has to be swapped
// a and b are the 2 nos in arr which needs to be swapped

void swap(int* Arr, int a, int b) 
{
	int temp = Arr[a];
	Arr[a] = Arr[b];
	Arr[b] = temp;
}

 
// Following function partitions the array by its pivot element 
// It places all elements less than the pivot before it, and all elements greater than the pivot after it. 
// So automatically, the pivot is in its sorted position after partitioning
// arr is the array in which we want to do partition
// start is the starting index of the sub array
// end is the ending index of the sub array

void partition(int* arr, int start, int end, int* left, int* right) 
{
	int piv = arr[*left];
	*left = start;
	*right = start;
	int ubound = end;

	while(*right <= ubound) 
	{
		if(arr[*right] < piv) // element is less than pivot
		{
			swap(arr, *left, *right);
			*left += 1;
			*right += 1;
		} 
		else if(arr[*right] > piv) // element is greater than pivot
		{
			swap(arr, *right, ubound);
			ubound--;
		} 
		else // element is equal to pivot
		{
			
			*right += 1;
		}
	}
}

// Finally, following is the sorting algorithm using quick sort
// arr is the array/sub-array to be sorted
// start and end are the starting and the ending indices of the sub-arrays respectively

void quicksort(int* arr, int start, int end) 
{
	if(start >= end) {
		return;
	}
	int left = pivot(arr, start, end), right = left;
	partition(arr, start, end, &left, &right);
	quicksort(arr, start, left-1);
	quicksort(arr, right, end);
}

// Following is the function which merges 2 sorted arrays

int* merge(int* Arr1, int size_1, int* Arr2, int size_2) {
	int first = 0;
	int second = 0;
	int sort_index = 0;
	int* sorted;
	MPI_Alloc_mem(sizeof(int) * (size_1 + size_2), MPI_INFO_NULL, &sorted);
	
	while(first < size_1 && second < size_2) 
	{
		if(Arr1[first] < Arr2[second]) 
		{
			sorted[sort_index++] = Arr1[first++];
		} else 
		{
			sorted[sort_index++] = Arr2[second++];
		}
	}

	while(first < size_1) 
	{
		sorted[sort_index++] = Arr1[first++];
	}

	while(second < size_2) 
	{
		sorted[sort_index++] = Arr2[second++];
	}

	return sorted;
}


int next_gap(int gap) {
	if(gap <= 1) {
		return 0;
	}
	return (gap / 2) + (gap % 2);
}


void compare_split(int* self_arr, int size, int self_id, int rank1, int rank2) {
	/* both processes send their data to the other one (assume same size of both) */
	int other_arr[size]; /* does not need to persist beyond this function */
	MPI_Status status;
	MPI_Sendrecv(
		self_arr,
		size,
		MPI_INT, 
		((self_id == rank1) ? rank2 : rank1),
		0,
		other_arr,
		size,
		MPI_INT,
		((self_id == rank1) ? rank2 : rank1),
		0,
		MPI_COMM_WORLD, 
		&status
	);
	int i, j, gap = size + size;

	if(self_id == rank1) {
		/* self_arr stores smallest elements in sorted order */
		for (gap = next_gap(gap); gap > 0; gap = next_gap(gap)) { 
			/* comparing elements in the first array */ 
			for (i = 0; i + gap < size; i++) {
				if (self_arr[i] > self_arr[i + gap]) { 
					swap(self_arr, i, i + gap); 
				}
			}
	
			/* comparing elements in both arrays */
			for (j = gap > size ? gap-size : 0 ; i < size && j < size; i++, j++) { 
				if (self_arr[i] > other_arr[j]) {
					/* swap contents of the two arrays at indices i and j respectively */ 
					int temp = self_arr[i];
					self_arr[i] = other_arr[j];
					other_arr[j] = temp;
				}
			}
	
			if (self_id == rank2 && j < size) { 
				/* comparing elements in the second array */ 
				for (j = 0; j + gap < size; j++) { 
					if (other_arr[j] > other_arr[j + gap]) {
						swap(other_arr, j, j + gap);
					}
				}
			} 
		}
	} else {
		/* self_arr stores largest elements, sorted in ascending order */
				/* self_arr stores smallest elements in sorted order */
		for (gap = next_gap(gap); gap > 0; gap = next_gap(gap)) { 
			/* comparing elements in the first array */ 
			for (i = 0; i + gap < size; i++) {
				if (other_arr[i] > other_arr[i + gap]) { 
					swap(other_arr, i, i + gap); 
				}
			}
	
			/* comparing elements in both arrays */
			for (j = gap > size ? gap-size : 0 ; i < size && j < size; i++, j++) { 
				if (other_arr[i] > self_arr[j]) {
					/* swap contents of the two arrays at indices i and j respectively */ 
					int temp = other_arr[i];
					other_arr[i] = self_arr[j];
					self_arr[j] = temp;
				}
			}
	
			if (self_id == rank2 && j < size) { 
				/* comparing elements in the second array */ 
				for (j = 0; j + gap < size; j++) { 
					if (self_arr[j] > self_arr[j + gap]) {
						swap(self_arr, j, j + gap);
					}
				}
			} 
		}
	}
}

int  main(int argc, char** argv) {
	
	int num_proc, id, size, chunk_size;
	int* arr, *chunk;
	double time_taken;

	// Initializing MPI
	MPI_Init(&argc, &argv);

	// Getting number of processes
	MPI_Comm_size(MPI_COMM_WORLD, &num_proc);

	// Getting current process id
	MPI_Comm_rank(MPI_COMM_WORLD, &id);

	if(id == 0) 
	{
		// read the input file
		
		FILE* fp = fopen("input.txt", "r");
		
		// Here I have assumed that the 1st number specifies number of integers in the file to be sorted
		fscanf(fp, "%d", &size);
		printf("Total no of elements to be sorted is : %d\n\n",size);

		// Computing chunk size
		chunk_size = size / num_proc;
		
		if(size % num_proc != 0) 
		{
			// Here, I have increased chunk size to the next multiple of num_proc, 
			// to avoid data not fitting in all the processes
			
			chunk_size++;
		}

		// Here, I created array of size such that all processes receive equal parts
		MPI_Alloc_mem(chunk_size * num_proc * sizeof(int), MPI_INFO_NULL, &arr);

		// Reading data from file 
		printf("The data read from file is : ");
		int i;
		for(i = 0; i < size; i++) 
		{
			fscanf(fp, "%d", &arr[i]);
			printf("%d ",arr[i]);
		}
		
		fclose(fp);

		for(i = size; i < chunk_size * num_proc; i++) 
		{
			arr[i] = __INT_MAX__;
		}
	}

	// Using MPI Barrier, I am synchronizing all processes till this point
	MPI_Barrier(MPI_COMM_WORLD);

	// Starting the timer to note down the execution time
	time_taken = MPI_Wtime();

	// Broadcasting the chunk size to all processes
	MPI_Bcast(&chunk_size, 1, MPI_INT, 0, MPI_COMM_WORLD);

	// Scattering the input array to all processes
	MPI_Alloc_mem(chunk_size * sizeof(int), MPI_INFO_NULL, &chunk);

	MPI_Scatter(arr, chunk_size, MPI_INT, chunk, chunk_size, MPI_INT, 0, MPI_COMM_WORLD);

	// Now as I don't need our original array - arr, so I released the memory consumed by it
	if(id == 0) 
	{
		MPI_Free_mem(arr);
	}

	// Sorting the chunk of data in each process 
	quicksort(chunk, 0, chunk_size-1);

	// Synchronizing processes post individual sorting 
	MPI_Barrier(MPI_COMM_WORLD);

	int i = 1;

	for(i = 0; i < num_proc; i++) {
		if(i%2 == 0) {
			/* even to odd transposition */
			if((id % 2 == 0) && (id < num_proc - 1)) {
				compare_split(chunk, chunk_size, id, id, id+1);
			} else if (id % 2 == 1) {
				compare_split(chunk, chunk_size, id, id-1, id);
			}
		} else {
			/* odd to even transposition */
			if((id % 2 == 1) && (id <= num_proc - 2)) {
				compare_split(chunk, chunk_size, id, id, id+1);
			} else if((id %2 == 0) && (id > 0)) {
				compare_split(chunk, chunk_size, id, id-1, id);
			}
		}
		/* Synchronize may be needed after each iteration: uncomment below to synchronize */
		MPI_Barrier(MPI_COMM_WORLD);
	}

	// Till here, the sorting ends, so merging results into root
	if(id == 0) 
	{
		MPI_Alloc_mem(num_proc * chunk_size * sizeof(int), MPI_INFO_NULL, &arr);
		memset(arr, 0, chunk_size * num_proc * sizeof(int)); 
	}

	// Aggregating the results from all processes
	int status = MPI_Gather(chunk, chunk_size, MPI_INT, arr, chunk_size, MPI_INT, 0, MPI_COMM_WORLD);

	// Stoping the timer 
	time_taken = MPI_Wtime() - time_taken;

	// Deallocating memory chunk which is no longer needed now
	MPI_Free_mem(chunk);

	if(id == 0) 
	{
		printf("\n\nThe number sequence after sorting those numbers is : \n");
		// The master process prints the output to file - output.txt, and also prints in terminal
		FILE* outfile = fopen("output.txt", "w");
		for(i = 0; i < size; i++) {
			fprintf(outfile, "%d\n", arr[i]);
			printf("%d ",arr[i]);
		}
		fclose(outfile);

		printf("\n\nTime taken for execution is %lf seconds\n", time_taken);
	}

	MPI_Finalize();

	return 0;
}
