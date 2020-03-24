/*
    Author: Kaushik Velusamy, Thomas Rolinger and Janice McMahon 
    Date:   04/25/2018
    File:   bitonic_EMU_iterative.c

    Description:    This is an iterative implementation of the
                    parallel bitonic sort for EMU.

                    This is called "dynamic" because it spawns
                    threads as it needs them. This is different
                    from the network version we have which uses
                    a fixed number of nodelets and threads.

*/

#include "memoryweb.h"
#include "cilk.h"
#include "stdio.h"
#include "stdlib.h"
#include "distributed.h"
#include "limits.h"
#include "getopt.h"

#ifndef DEBUG
    #include "timing.h"
#endif

#define direction 1 //direction 1 for asc and 0 for des

void swaploop_asc(unsigned long i, unsigned long step, long* arr) 
{
    unsigned long j,k,temp;
    for (j=i,k=0; k<step; j++,k++) 
    {
        if (arr[j] > arr[j+step])
        {
            temp = arr[j];
            arr[j]=arr[j+step];
            arr[j+step]=temp;
        }
    }
}   

void swaploop_dsc (unsigned long i, unsigned long step, long* arr)
{
    unsigned long j,k,temp;
    for (j=i,k=0; k<step; j++,k++) 
    {
        if (arr[j] < arr[j+step]) 
        {
            temp = arr[j];
            arr[j]=arr[j+step];
            arr[j+step]=temp;
        }
    }
}


void merge_up(long *arr, unsigned long n) 
{
    unsigned long step=n/2;
    unsigned long i;
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

void merge_down(long *arr, unsigned long n) 
{
    unsigned long step=n/2;
    unsigned long i;
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
    void print_array(long arr[], unsigned long n) 
    {
        unsigned long i;
        printf("[%ld",arr[0]);
        fflush(stdout);
        for (i= 1; i < n;i++) {
            printf(",%ld",arr[i]);
            fflush(stdout);
        }
        printf("]\n");  
        fflush(stdout);
    }

    int testsortedresults(long arr[], unsigned long n)
    {
        // Verifying the sorted list 
        for (unsigned long i=0; i<n; i++) {
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
    unsigned long bintest = 0;
    unsigned long sizetest = 0;
    unsigned long buf_size = 1024;
    unsigned long printflag = 0;
    double clockrate = 150.0;   
 
    int c;
    while ((c = getopt(argc, argv, "hbfs:n:t:c:p:")) != -1)
    {
        switch (c)
        {
            case 'h':
                printf("Optional argument: <file> (prompted if not present)\n");
                printf("Program options: -hbfsntcp\n");
                printf("  -h print this help and exit\n");
                printf("  -b binary file, detault text\n");
                printf("  -f first number is size, default no\n");
                printf("  -s <N> for buffer size, default 1024\n");
                printf("  -c <N> for clock rate, default 150.0MHz\n");
                printf("  -p <N> for debug level > 0\n");
                exit(0);
                break;
            case 'b': bintest = 1; break;
            case 'f': sizetest = 1; break;
            case 's': buf_size = atol(optarg); break;
            case 'c': clockrate = atof(optarg); break;
            case 'p': printflag = atol(optarg); break;
        }
    }
    
    char infilenm[64];
    if (optind < argc) sprintf(infilenm, "%s", argv[optind]);
    else { printf("Graph file name: "); fflush(stdout); scanf("%s", infilenm); }

    FILE *fp = fopen(infilenm, "r");
    if (bintest) fp = fopen(infilenm, "rb");
    else fp = fopen(infilenm, "r");
    if (! fp) { fprintf(stderr, "can't open file %s\n", infilenm); exit(0); }

    // read initial size and discard, if there
    long *temp =(long *)malloc(buf_size * sizeof(long));
    if (sizetest) {
        if (bintest) fread(temp, sizeof(long), 1, fp);
        else fscanf(fp, "%ld", &temp[0]);
    } 

    // first pass: count the number of elements
    unsigned long elt_index = 0;
    while (! feof(fp)) {
        unsigned long numread = 0;
        if (bintest) numread = fread(temp, sizeof(long), buf_size, fp);
        else while ((fscanf(fp, "%ld", &temp[numread]) != EOF) &&
            (numread < buf_size)) numread++;
        elt_index += numread;
    }

    rewind(fp);
    if (sizetest) {
        if (bintest) fread(temp, sizeof(long), 1, fp);
        else fscanf(fp, "%ld", &temp[0]);
    }

    // find next power of 2, elts and nodes
    unsigned long power = 1;
    unsigned long lg2power = 0;
    while (power < elt_index) { power <<= 1; lg2power++; }
    unsigned long n = power;

    // Read into 1D striped array    
    long *InputArray = (long *)mw_malloc1dlong(n);
    elt_index = 0;
    while(!feof(fp)) {
        unsigned long numread = 0;
        if (bintest) numread = fread(temp, sizeof(long), buf_size, fp);
        else while ((fscanf(fp, "%ld", &temp[numread]) != EOF) &&
            (numread < buf_size)) numread++;
        for (unsigned long i = 0; i < numread; i++) {
            InputArray[elt_index] = temp[i];
            elt_index++;
        }
    }
    free(temp);
    fclose(fp);

int startTiming = 1;
    
#ifdef DEBUG
    printf("INPUT: "); fflush(stdout); print_array(InputArray, n);
    startTiming = 0;
#endif

    /*
        This way, we can run in debug mode without also having the
        simulator timing.

        For now, the only time we don't want to NOT use starttiming is
        when we run in debug mode.
    */
    if(startTiming) {
        starttiming();
    }

/*#ifdef SIM1
    starttiming();
#else
*/
#ifndef SIM0
    //starttiming();
    unsigned long nid = NODE_ID();
    unsigned long starttime = CLOCK();
#endif
//#endif

    for (unsigned long s=2; s <= n; s*=2) {
        for (unsigned long i=0; i < n;i=i+s*2) {
            merge_up((InputArray+i),s);
            if (s < n) {
                merge_down((InputArray+i+s),s);
            }
        }
    }   

#ifdef SIM1
    exit(0);
#else
#ifndef SIM0
    unsigned long endtime = CLOCK();
    unsigned long nidend = NODE_ID();
    if (nid != nidend) printf("timing problem %lu %lu\n", nid, nidend);
    unsigned long totaltime = endtime - starttime;
    double ms = ((double) totaltime / clockrate) / 1000.0;
    printf("Clock %.1lf Total %lu Time(ms) %.1lf\n",
        clockrate, totaltime, ms); fflush(stdout);
    printf("TOTAL CYCLES: %lu\n", totaltime);
#endif
#endif

#ifdef DEBUG
    printf("SORTED ARRAY:\n");
    print_array(InputArray, n);
    int result = testsortedresults(InputArray, n);
    printf("Test Result: %s; \t count: %d; \n",  (result>0 ? "Failed" : "Passed"),n);
    fflush(stdout);
#endif

    return 0;
}
