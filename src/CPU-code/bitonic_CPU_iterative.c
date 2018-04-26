/*
    Author: Kaushik Velusamy and Thomas Rolinger
    Date:   04/25/2018
    File:   bitonic_CPU_iterative.c

    Description:    This is an iterative implementation of the
                    parallel bitonic sort. It relies on Cilk for
                    parallelism.

                    The first argument to the program is the
                    input data set and the second argument is
                    the number of elements in the data set.

                    Currently, we are using icc to compile this
                    code. For performance metrics, we are using
                    PAPI to gather total cycles, etc.
*/

#include <cilk/cilk.h>
#include <stdio.h>
#include <stdlib.h>

#ifdef TIMING
    #include <papi.h>
    #define NUM_EVENTS 2
    void handle_error(int retval)
    {
        printf("PAPI error %d: %s\n", retval, PAPI_strerror(retval));
        exit(1);
    }
#endif

#define direction 1 //direction 1 for asc and 0 for des

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
    
    FILE *fp = fopen(argv[1],"rb");
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
    
    long *InputArray = (long *)malloc(sizeof(long) * n);
    for(long i = 0; i < n; i++) {
        //fscanf(fp, "%ld", (InputArray+i));
        fread((InputArray+i), sizeof(int), 1, fp);
    }
    fclose(fp);

    #ifdef DEBUG
        printf("INITIAL ARRAY:\n");
        printArray(InputArray, n);
        fflush(stdout);
    #endif

    #ifdef TIMING
        int Events[NUM_EVENTS] = {PAPI_TOT_CYC, PAPI_TOT_INS};
        long_long values[NUM_EVENTS];
        int retval = PAPI_start_counters(Events, NUM_EVENTS);
        if(retval != PAPI_OK) {
            handle_error(retval);
        }
    #endif

    for (long s=2; s <= n; s*=2) {
        for (long i=0; i < n;i=i+s*2) {
            merge_up((InputArray+i),s);
            //if (s < n) {
                merge_down((InputArray+i+s),s);
            //}
        }
    }   
 
    #ifdef TIMING
        retval = PAPI_stop_counters(values, NUM_EVENTS);
        if(retval != PAPI_OK) {
            handle_error(retval);
        }
        printf("######## TOTAL CYCLES: %lld, TOTAL INSTRUCTIONS: %lld\n", values[0], values[1]);
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



