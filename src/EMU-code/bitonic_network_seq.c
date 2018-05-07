#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>

#define MAX(a,b)              \
  ({ __typeof__ (a) _a = (a); \
  __typeof__ (b) _b = (b);  \
  _a > _b ? _a : _b;})

#define MIN(a,b)              \
  ({ __typeof__ (a) _a = (a); \
  __typeof__ (b) _b = (b);  \
  _a < _b ? _a : _b;})

long dest_max_index(long g, long p, long i)
{
  return 0; // compute desintation
}

long dest_min_index(long g, long p, long i)
{
  return 0; // compute destination
}

void comparator(long stage, long step, long *In, long *Out, long n)
{
  for (long i = 0; i < n; i += 2) {
    long max_val = MAX(In[i], In[i+1]);
    long min_val = MIN(In[i], In[i+1]);
    long jmax = dest_max_index(stage, step, i);
    long jmin = dest_min_index(stage, step, i);
    Out[jmax] = max_val;
    Out[jmin] = min_val;
  }
}

int main(int argc, char **argv)
{
  unsigned long bintest = 0;
  unsigned long nnodes = 8;
  unsigned long nthreads = 16;
  unsigned long printflag = 0;
  unsigned long epn = 131072;
  unsigned long buf_size = 1024;
  double clockrate = 150.0;

  int c;
  while ((c = getopt(argc, argv, "hbn:t:e:s:c:p:")) != -1)
    {
      switch (c)
        {
        case 'h':
          printf("Optional argument: <file> (prompted if not present)\n");
          printf("Program options: -hbntescp\n");
          printf("  -h print this help and exit\n");
          printf("  -b binary file, detault text\n");
          printf("  -n <N> for number of nodelets, default NODELETS()\n");
          printf("  -t <N> for number of threads, default 16\n");
          printf("  -e <N> for max elts per nodelet, default 131072\n");
          printf("  -s <N> for buffer size, default 1024\n");
          printf("  -c <N> for clock rate, default 150.0MHz\n");
          printf("  -p <N> for debug level > 0\n");
          exit(0);
          break;
        case 'b': bintest = 1; break;
        case 'n': nnodes = atol(optarg); break;
        case 't': nthreads = atol(optarg); break;
        case 'e': epn = atol(optarg); break;
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

  long *InArray =(long *)malloc(nnodes * epn * sizeof(long));
  long *OutArray =(long *)malloc(nnodes * epn * sizeof(long));
  long *temp =(long *)malloc(buf_size * sizeof(long));
  long elt_index = 0;
  while (! feof(fp)) {
    long numread = 0;
    if (bintest) numread = fread(temp, sizeof(long), buf_size, fp);
    else while ((fscanf(fp, "%ld", &temp[numread]) != EOF) &&
		(numread < buf_size)) numread++;

    for (long i = 0; i < numread; i++) {
      InArray[elt_index] = temp[i];
      elt_index++;
    }
  }
  free(temp);
  fclose(fp);

#ifndef SIM0
  if (printflag == 1) {
    for (long i = 0; i < nnodes; i++) {
      for (long j = 0; j < epn; j++) {
	printf("NID %ld ofset %ld value %ld\n", i, j, InArray[i * j]);
        fflush(stdout);
      }
    }
  }
#endif

  long *In = InArray;
  long *Out = OutArray;
  for (long stage = 2; stage <= elt_index; stage *= 2) {
    for (long step = 2; step < stage * 2; step *= 2) {
      comparator(stage, step, In, Out, nnodes * epn);
      long *Tmp = In;
      In = Out;
      Out = Tmp;
    }
  }

#ifndef SIM0
  for (long i = 1; i < elt_index - 1; i++) {
    if (InArray[i] > InArray[i + 1]) {
      printf("FAILED\n"); fflush(stdout);
      break;
    }
  }

  if (printflag == 2) {
    printf("SORTED ARRAY:\n");
    printf("[%ld", InArray[0]); fflush(stdout);
    for (long i = 1; i < elt_index; i++) {
      printf(",%ld", InArray[i]); fflush(stdout);
    }
    printf("]\n"); fflush(stdout);
  }
#endif
    return 0;
}
