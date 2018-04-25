/*
    Author: Kaushik Velusamy and Thomas Rolinger
    Date:   04/25/2018
    File:   bitonic_EMU_recursive.c

    Description:    This is a recursive implementation of the
                    parallel bitonic sort for EMU.

                    The first argument to the program is the
                    input data set and the second argument is
                    the number of elements in the data set.
*/

#include "memoryweb.h"
#include "timing.h"
#include "cilk.h"

#include "stdio.h"
#include "stdlib.h"

#ifdef TIMING
    #include "timing.h"
#endif

#define direction 1 //direction 1 for asc and 0 for des

void compAndSwap(long a[], long i, long j, int dir)
{
    if(dir == (a[i] > a[j])) {
        a[i] = a[i] - a[j];
        a[j] = a[i] + a[j];
        a[i] = a[j] - a[i];
    }
}


void bitonicMerge(long a[], long low, long cnt, int dir)
{
    if(cnt > 1) {
        long k = cnt/2;
        for(long i = low; i < low+k; i++) {
            compAndSwap(a, i, i+k, dir);
        }
        cilk_spawn bitonicMerge(a, low, k, dir);
        cilk_spawn bitonicMerge(a, low+k, k, dir);
        cilk_sync;
    }
}


void bitonicSort(long a[],long low, long cnt, int dir)
{
    if(cnt > 1) {
        long k = cnt/2;
        cilk_spawn bitonicSort(a, low, k, 1);
        cilk_spawn bitonicSort(a, low+k, k, 0);
        cilk_sync;
        cilk_spawn bitonicMerge(a, low, cnt, dir);
        cilk_sync;
    }
}

#ifdef DEBUG
    void printArray(long arr[], long n) 
    {
        long i;
        printf("[%ld",arr[0]);
        fflush(stdout);
        for (i= 1; i < n;i++) {
            printf(",%ld",arr[i]);
            fflush(stdout);
        }
        printf("]\n");  
        fflush(stdout);
    }

    int testsortedresults(long arr[], long n)
    {
        // Verifying the sorted list 
        for (long i=0; i<n; i++) {
            if( i+1 != n) {
                if ( arr[i] > arr[i+1]) {
                    return 1; //ascii code for "fail"
                }   
            }   
        }
        return 0; //ascii code for "pass"
    }
#endif


int main(int argc, char **argv)
{
    if(argc != 3) {
        printf("usage: %s <input file> <number of elements>\n", argv[0]);
        exit(-1);
    }
    
    FILE *fp = fopen(argv[1],"r");
    if(fp == NULL) {
        fprintf(stderr, "ERROR: Input file %s could not be opened for reading\n", argv[1]);
        exit(-1);
    }

    long n = atol(argv[2]);
    long m = n;
    if(n <= 1) {
        fprintf(stderr, "ERROR: Number of elements must be greater than 1 and power of 2\n");
        fclose(fp);
        exit(-1);
    } 
    while(m != 1) {
        if(m % 2 != 0) {
            fprintf(stderr, "ERROR: Number of elements must be power of 2\n");
            fclose(fp);
            exit(-1);
        }
        m /= 2;
    }
    
    long *InputArray = (long *)mw_malloc1dlong(sizeof(long) * n);
    for(long i = 0; i < n; i++) {
        fscanf(fp, "%ld", (InputArray+i));
    }
    fclose(fp);

    #ifdef DEBUG
        printf("INITIAL ARRAY:\n");
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
        if(nidstart != nidend) {
            printf("WARNING: Start and end nodes differ for timings\n");
        }
        printf("######## TOTAL CYCLES: %ld\n", toc-tic);
    #endif

    #ifdef DEBUG
        printf("SORTED ARRAY:\n");
        printArray(InputArray, n);
        long result = testsortedresults(InputArray, n);
        printf("Test Result: %s; \t count: %ld; \n",  (result>0 ? "Failed" : "Passed"),n);
        fflush(stdout);
    #endif

    return 0;
}



