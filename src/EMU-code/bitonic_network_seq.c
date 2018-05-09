#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <getopt.h>

#define MAX(a,b)              \
  ({ __typeof__ (a) _a = (a); \
  __typeof__ (b) _b = (b);  \
  _a > _b ? _a : _b;})

#define MIN(a,b)              \
  ({ __typeof__ (a) _a = (a); \
  __typeof__ (b) _b = (b);  \
  _a < _b ? _a : _b;})

void comparator(unsigned long s, unsigned long c, long *In, long *Out,
		unsigned long n)
{
  for (unsigned long r = 0; r < n; r++) {
    unsigned long r1 = r ^ (1 << c);
    unsigned long rdiv2cm2 = (r >> c) & 1;
    unsigned long rdiv2sm2 = (r >> s) & 1;
    if (rdiv2cm2 == rdiv2sm2) Out[r] = MIN(In[r], In[r1]);
    else Out[r] = MAX(In[r], In[r1]);
  }
}

void print_array(long *arr, unsigned long n);

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

  unsigned long power = 1;
  unsigned long lg2power = 0;
  while (power < elt_index) { power <<= 1; lg2power++; }
  for (long i = elt_index; i < power - 1; i++) InArray[i] = LONG_MAX;

  printf("INPUT:\n");
  print_array(InArray, elt_index);

  long *In = InArray;
  long *Out = OutArray;
  for (long stage = 1; stage <= lg2power; stage++) {
    for (long step = stage - 1; step >= 0; step--) {
      comparator(stage, step, In, Out, power);
      printf("Stage %ld Step %ld OUT:\n", stage, step);
      print_array(Out, power);
      long *Tmp = In;
      In = Out;
      Out = Tmp;
    }
  }

  for (long i = 1; i < elt_index - 1; i++) {
    if (InArray[i] > InArray[i + 1]) {
      printf("FAILED\n"); fflush(stdout);
      break;
    }
  }

  printf("SORTED ARRAY:\n");
  print_array(In, elt_index);
  return 0;
}

void print_array(long *arr, unsigned long n)
{
  printf("[%ld", arr[0]); fflush(stdout);
  for (long i = 1; i < n; i++)
    { printf(",%ld", arr[i]); fflush(stdout); }
  printf("]\n"); fflush(stdout);
}
