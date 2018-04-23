/*Author : Kaushik Velusamy
 *An EMU-UMBC collaboration
 *This program is an iterative implementation of the serial bitonic sort algorithm, compiled with gcc.
 *To compile this program Execute: gcc bitonic_serial_iteration.c
 *To Run this program Execute: ./a.out dataset8 8
 *The second argument is the inputfile. The third argument is the inputsize.
 *Run with 2 arguments. InputFilename and totalnumberofelementsinfile
 *For bitonic sort the Total number of elements (size) of the input should be a power of 2.
 */




#include "stdio.h"
#include "stdlib.h"
#include "time.h"

#define DEBUG
#define TIMING

void swaploop_asc(long i, long step, long* arr)
{
	long j,k,temp;
	for (j=i,k=0; k<step;j++,k++)
	{
		if (arr[j] > arr[j+step])
		{
			temp = arr[j];
			arr[j]=arr[j+step];
			arr[j+step]=temp;
		}
	}
}

void swaploop_dsc (long i, long step, long* arr)
{
	long j,k,temp;
	for (j=i,k=0;k<step;j++,k++)
	{
		if (arr[j] < arr[j+step])
		{
			temp = arr[j];
			arr[j]=arr[j+step];
			arr[j+step]=temp;
		}
	}

}



void merge_up(long *arr, long n) 
{
	long step=n/2,i;
	while (step > 0) 
	{
		for (i=0; i < n; i+=step*2) 
		{
			swaploop_asc(i,step,arr);
		}
		step /= 2;
	}
}

void merge_down(long *arr, long n) 
{
	long step=n/2,i;
	while (step > 0) 
	{
		for (i=0; i < n; i+=step*2) 
		{
			swaploop_dsc(i,step,arr);
		}
		step /= 2;
	}
}

void printArray(long *arr, long n) 
{
	long i;

	printf("[%ld",arr[0]);
	fflush(stdout);	
	for (i=1; i < n;i++) 
	{
		printf(",%ld",arr[i]);
		fflush(stdout);	
	}
	printf("]\n");
	fflush(stdout);	
}


int testsortedresults(long arr[], int n)
{
	// Verifying the sorted list 
	for (long i=0; i<n; i++)
	{
		if( i+1 != n)
		{
			if ( arr[i] > arr[i+1])
			{
				return 1; //ascii code for "fail"
			}
		}
	}
	return 0; //ascii code for "pass"
}

int main(int argc, char **argv) 
{
	long *arr, i,s;

	if(argc != 3)
	{
		printf(" \n Run with 2 arguments. InputFilename and totalnumberofelementsinfile\n");
		exit(1);
	}
	FILE *fp = fopen(argv[1],"r");

	if (fp == NULL) 
	{
		fprintf(stderr,"File not found \n");
		exit(1);
	}


	long n = atol (argv[2]);
	long m =n;
	long result;

	if (m <= 1)
	{
		printf("N should be a valid number >1 and a power of 2\n");
		exit(0);
	}
	while (m != 1)
	{
		if (m%2 != 0)
		{
			printf("N should be a valid number >1 and a power of 2\n");
			exit(0);
		}
		m = m/2;		
	}

#ifdef TIMING
	clock_t tic = clock();
#endif
	arr = (long *)malloc(n*sizeof(long));


	for (i=0; i < n; i++) 
	{
		fscanf(fp,"%ld",(arr+i));
	}
#ifdef DEBUG
	printArray(arr,n);
#endif

	for (s=2; s <= n; s*=2) 
	{
		for (i=0; i < n; i+=s*2) 
		{
			//printf(" \n i = %ld, s = %ld,arr+i =%ld ,arr+i+(s)=%ld \n",i,s,*(arr+i),*(arr+i+(s))); 
			merge_up((arr+i),s);		
			//	printArray(arr,n);
			if (s < n)
				merge_down((arr+i+(s)),s);
		}

		//	printArray(arr,n);
		//	printf("\n****\n");
	}

#ifdef DEBUG
	printArray(arr,n);
#endif
#ifdef TIMING
	clock_t toc = clock();
#endif

	result = testsortedresults(arr, n);

#ifdef TIMING
	printf("\nElapsed: %f seconds\n", (double)(toc - tic) / CLOCKS_PER_SEC);
	fflush(stdout);	
#endif	

	printf("Test Result: %s\t count: %ld \n",  (result>0 ? "Failed" : "Passed"),n);
	fflush(stdout);	
	return result;

}

