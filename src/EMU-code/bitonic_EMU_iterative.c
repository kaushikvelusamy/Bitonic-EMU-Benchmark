/*
    Author: Kaushik Velusamy and Thomas Rolinger
    Date:   04/25/2018
    File:   bitonic_EMU_iterative.c

    Description:    This is an iterative implementation of the
                    parallel bitonic sort for EMU.

                    The only argument to the program is the
                    input data set. The first number in this
                    file indicates how many elements there are.
                    This is a binary file, where each element is
                    a long.
*/

#include "memoryweb.h"
#include "cilk.h"
#include "stdio.h"
#include "stdlib.h"

#ifdef HARDWARE
    #include "timing.h"
#endif

#ifdef SIMULATOR
    #include "timing.h"
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
    if(argc != 2) {
        printf("usage: %s <input file>\n", argv[0]);
        exit(-1);
    }
    
    FILE *fp = fopen(argv[1],"rb");
    if(fp == NULL) {
        fprintf(stderr, "ERROR: Input file %s could not be opened for reading\n", argv[1]);
        exit(-1);
    }

    // First number in file is number of elements
    long n;
    fread(&n, sizeof(long), 1, fp); 

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
        //fscanf(fp, "%ld", (InputArray+i));
        fread((InputArray+i), sizeof(int), 1, fp);
    }
    fclose(fp);

    #ifdef DEBUG
        printf("INITIAL ARRAY:\n");
        printArray(InputArray, n);
        fflush(stdout);
    #endif

    #ifdef HARDWARE
        long nidstart = NODE_ID();
        unsigned long tic = CLOCK();
    #endif

    #ifdef SIMULATOR
        starttiming();
    #endif

    for (long s=2; s <= n; s*=2) {
        for (long i=0; i < n;i=i+s*2) {
            merge_up((InputArray+i),s);
            //if (s < n) {
                merge_down((InputArray+i+s),s);
            //}
        }
    }   
 
    #ifdef SIMULATOR
        // Immediately exit; any other code slows down simulator
        return 0;
    #endif

    #ifdef HARDWARE
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



