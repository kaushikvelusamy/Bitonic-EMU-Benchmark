    /*Author : Kaushik Velusamy
     *An EMU-UMBC collaboration
     *This program is a recursive implementation of the parallel bitonic sort algorithm, compiled with emu-cc.
     *To compile this program Execute: emu-cc bitonic_emu_recursion.c
     *To Run this program Execute: emusim.x ./a.out.mwx dataset8 8
     *The third argument is the inputfile. The fourth argument is the inputsize.
     *Run with 2 arguments. InputFilename and totalnumberofelementsinfile
     *For bitonic sort the Total number of elements (size) of the input should be a power of 2.
     */

#include "memoryweb.h"
#include "cilk.h"
#include "stdio.h"
#include "stdlib.h"
#include "time.h"
#include "timing.h"

#define TIMING
#define DEBUG

#define direction 1 //direction 1 for asc and 0 for des

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
		cilk_spawn bitonicMerge(a, low, k, dir);
		cilk_spawn bitonicMerge(a, low+k, k, dir);

		cilk_sync;
	}
}


void bitonicSort(long a[],long low, long cnt, int dir)

{
	if (cnt>1)
	{
		long k = cnt/2;

		cilk_spawn bitonicSort(a, low, k, 1);

		cilk_spawn bitonicSort(a, low+k, k, 0);

		cilk_sync;

		cilk_spawn bitonicMerge(a, low, cnt, dir);

		cilk_sync;
	}
}


void printArray(long arr[], long n)
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

int testsortedresults(long arr[], long n)
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

	int n_nodelets = NODELETS();
	long i;
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


	long *InputArray = (long *)mw_malloc1dlong(n_nodelets);

	for (i=0; i < n; i++) 
	{
		fscanf(fp,"%ld",(InputArray+i));
	}

	#ifdef DEBUG
		printArray(InputArray, n);
		fflush(stdout);
	#endif
	
	MIGRATE(InputArray);
	
	#ifdef TIMING
		starttiming();
		long nidstart = NODE_ID();
		unsigned long tic = CLOCK();
	#endif	
	
	bitonicSort(InputArray, 0, n, direction);
	MIGRATE(InputArray);
	
	#ifdef TIMING
		unsigned long toc = CLOCK();
		long nidend = NODE_ID();
		
		if (nidstart != nidend)
		{
			printf("\n Start Node %ld End Node %ld\n", nidstart, nidend);	
			fflush(stdout);	
		}     
	#endif

	#ifdef DEBUG
		printArray(InputArray, n);
		fflush(stdout);
	#endif
	
	result = testsortedresults(InputArray, n);


	#ifdef TIMING
        	printf("\nElapsed: %lu seconds;\t", (toc - tic) );
		fflush(stdout);
	#endif

	printf("Test Result: %s; \t count: %ld; \n",  (result>0 ? "Failed" : "Passed"),n);
	fflush(stdout);

	return result;

}

