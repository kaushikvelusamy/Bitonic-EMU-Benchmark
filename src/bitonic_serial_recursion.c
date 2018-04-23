/*Author : Kaushik Velusamy
 *An EMU-UMBC collaboration
 *This program is a recursive implementation of the serial bitonic sort algorithm, compiled with gcc.
 *To compile this program Execute: gcc bitonic_serial_recursion.c
 *To Run this program Execute: ./a.out dataset8 8
 *The second argument is the inputfile. The third argument is the inputsize.
 *Run with 2 arguments. InputFilename and totalnumberofelementsinfile   
 *For bitonic sort the Total number of elements (size) of the input should be a power of 2.
 */




#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define TIMING
#define DEBUG

#define direction 1 // direction 1 for asc and 0 for des

void compAndSwap(long a[], long i, long j, int dir)
{
	if (dir==(a[i]>a[j]))
	{
		a[i] = a[i] - a[j];
		a[j] = a[i] + a[j];
		a[i] = a[j] - a[i];
	}
}


void bitonicMerge(long a[], long low, long cnt, int dir)
{
	if (cnt>1)
	{
		long k = cnt/2;
		for (long i=low; i<low+k; i++)
			compAndSwap(a, i, i+k, dir);
		bitonicMerge(a, low, k, dir);
		bitonicMerge(a, low+k, k, dir);
	}
}


void bitonicSort(long a[],long low, long cnt, int dir)
{
	if (cnt>1)
	{
		long k = cnt/2;
		bitonicSort(a, low, k, 1);
		bitonicSort(a, low+k, k, 0);
		bitonicMerge(a, low, cnt, dir);
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


	long *arr, i;

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
	int result;

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

	bitonicSort(arr,0, n, direction);

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

	printf("Test Result: %s \t count: %ld \n",  (result>0 ? "Failed" : "Passed"),n);
	fflush(stdout);
	return result;
}


