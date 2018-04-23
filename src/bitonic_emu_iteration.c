/*Author : Kaushik Velusamy
 *An EMU-UMBC collaboration
 *This program is an iterative implementation of the parallel bitonic sort algorithm, compiled with emu-cc.
 *To compile this program Execute: emu-cc bitonic_serial_iteration.c
 *To Run this program Execute: emusim ./a.out.mwx dataset8 8
 *The third argument is the inputfile. The fourth argument is the inputsize.
 *Run with 2 arguments. InputFilename and totalnumberofelementsinfile
 *For bitonic sort the Total number of elements (size) of the input should be a power of 2.
 */

#include "memoryweb.h"
#include "timing.h"
#include "cilk.h"

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
	long step=n/2;
	long i;
	while (step > 0) 
	{
		for(i=0; i<n; i+=step*2) 
		{
			cilk_spawn swaploop_asc(i,step,arr);

		}
		cilk_sync;
		step = step/2;
	}
}

void merge_down(long *arr, long n) 
{
	long step=n/2;
	long i;
	while (step > 0) 
	{
		for(i=0; i<n; i+=step*2)
		{
			cilk_spawn swaploop_dsc(i,step,arr);

		}

		cilk_sync;
		step = step/2;
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


int testsortedresults(long arr[], int n)
{
	// Verifying the sorted list 
	for(long i=0; i<n; i++)
	{
		if( i+1 != n)
		{
			if ( arr[i] > arr[i+1])
			{
				printf(" \n The failed numbers are %ld and %ld \n", arr[i],arr[i+1]);
				return 1; //ascii code for "fail"

			}
		}
	}
	return 0; //ascii code for "pass"
}



int main(int argc, char **argv) 
{

	long i,s;

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
	printArray(InputArray,n);
	fflush(stdout);
#endif

#ifdef TIMING
	starttiming();
	long nidstart = NODE_ID();	
	unsigned long tic = CLOCK();
#endif

	for (s=2; s <= n; s*=2) 
	{
		for (i=0; i < n;i=i+s*2) 
		{
			merge_up((InputArray+i),s);
			if ( s < n )
				merge_down((InputArray+i+s),s);
		}
	//	printArray(InputArray,n);
	//	fflush(stdout);
	}

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
	printf("\n\n");
	printArray(InputArray,n);
	fflush(stdout);
#endif

	result = testsortedresults(InputArray, n);
#ifdef TIMING
	printf("\nElapsed: %f seconds\n", (double)(toc - tic));
	fflush(stdout);
#endif

	printf("Test Result: %s \t count: %ld \n ",  (result>0 ? "Failed" : "Passed"),n);

	fflush(stdout);
	return result;

}

