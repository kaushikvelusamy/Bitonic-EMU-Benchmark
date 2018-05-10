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

void print_array(long *arr, unsigned long n);

void comparator(unsigned long s, long c, long *In, long *Out, unsigned long n)
{
  unsigned long dist = 1 << c;
  unsigned long i = 0;
  for (i = 0; i < n; i += 2 * dist) {
    for (long j = 0; j < dist; j++) {
      unsigned long r = i + j;
      unsigned long r1 = r + dist;
      unsigned long rdiv2sm2 = (r >> s) & 1;
      unsigned long r1div2sm2 = (r1 >> s) & 1;
      long min_val = MIN(In[r], In[r1]);
      long max_val = MAX(In[r], In[r1]);
      if (! rdiv2sm2) Out[r] = min_val;
      else Out[r] = max_val;
      if (r1div2sm2) Out[r1] = min_val;
      else Out[r1] = max_val;
    }
  }
  /*
  for (unsigned long r = 0; r < n; r++) {
    unsigned long r1 = r ^ (1 << c);
    unsigned long rdiv2cm2 = (r >> c) & 1;
    unsigned long rdiv2sm2 = (r >> s) & 1;
    if (rdiv2cm2 == rdiv2sm2) Out[r] = MIN(In[r], In[r1]);
    else Out[r] = MAX(In[r], In[r1]);
  }
  */
}

int main(int argc, char **argv)
{
  unsigned long bintest = 0;
  unsigned long sizetest = 0;
  unsigned long buf_size = 1024;

  int c;
  while ((c = getopt(argc, argv, "hbfs:")) != -1)
    {
      switch (c)
        {
        case 'h':
          printf("Optional argument: <file> (prompted if not present)\n");
          printf("Program options: -hbfs\n");
          printf("  -h print this help and exit\n");
          printf("  -b binary file, detault text\n");
          printf("  -f first number is size, default no\n");
          printf("  -s <N> for buffer size, default 1024\n");
          exit(0);
          break;
        case 'b': bintest = 1; break;
        case 'f': sizetest = 1; break;
        case 's': buf_size = atol(optarg); break;
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
    else fscanf(fp, "%ld", &temp[0]) != EOF;
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
    else fscanf(fp, "%ld", &temp[0]) != EOF;
  }

  // find next power of 2
  unsigned long power = 1;
  unsigned long lg2power = 0;
  while (power < elt_index) { power <<= 1; lg2power++; }

  // second pass: read data into distributed array
  long *InArray =(long *)malloc(power * sizeof(long));
  long *OutArray =(long *)malloc(power * sizeof(long));
  elt_index = 0;
  while (! feof(fp)) {
    unsigned long numread = 0;
    if (bintest) numread = fread(temp, sizeof(long), buf_size, fp);
    else while ((fscanf(fp, "%ld", &temp[numread]) != EOF) &&
                (numread < buf_size)) numread++;

    for (unsigned long i = 0; i < numread; i++) {
      InArray[elt_index] = temp[i];
      elt_index++;
    }
  }
  free(temp);
  fclose(fp);

  for (long i = elt_index; i < power; i++) InArray[i] = LONG_MAX;
  //  printf("INPUT: "); print_array(InArray, elt_index);

  long *In = InArray;
  long *Out = OutArray;
  for (unsigned long stage = 1; stage <= lg2power; stage++) {
    for (long step = stage - 1; step >= 0; step--) {
      comparator(stage, step, In, Out, power);
      //      printf("Stage %ld Step %ld OUT:\n", stage, step);
      //      print_array(Out, power);
      long *Tmp = In;
      In = Out;
      Out = Tmp;
    }
  }

  for (long i = 1; i < power - 1; i++) {
    if (In[i] > In[i + 1]) {
      printf("FAILED %ld\n", i); fflush(stdout);
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
