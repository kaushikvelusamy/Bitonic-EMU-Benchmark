#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <getopt.h>
#include "memoryweb.h"
#include "cilk.h"

#define GET_NODE(v, p) ((v) / (p))
#define GET_OFFSET(v, p) ((v) % (p))

#define MAX(a,b)              \
  ({ __typeof__ (a) _a = (a); \
  __typeof__ (b) _b = (b);  \
  _a > _b ? _a : _b;})

#define MIN(a,b)              \
  ({ __typeof__ (a) _a = (a); \
  __typeof__ (b) _b = (b);  \
  _a < _b ? _a : _b;})

replicated unsigned long total_elts;
replicated unsigned long elts_per_nlet;
replicated unsigned long numthreads;
replicated unsigned long curr_index;

// grab a pair of values at an offset and write max/min to correct dest
void comparator_thread(unsigned long *currp, unsigned long offset, 
		       unsigned long s, long c, long **In, long **Out)
{
  unsigned long nnum = NODE_ID();
  unsigned long epn = elts_per_nlet;
  unsigned long tote = total_elts;
  while (offset < epn) {
    unsigned long r = nnum * epn + offset;
    if (r >= tote) break;
    unsigned long r1 = r ^ (1 << c);
    unsigned long r1nlet = GET_NODE(r1, epn);
    unsigned long r1off = GET_OFFSET(r1, epn);
    unsigned long rdiv2cm2 = (r >> c) & 1;
    unsigned long rdiv2sm2 = (r >> s) & 1;
    long value = In[nnum][offset];
    long partner = In[r1nlet][r1off];

    if (rdiv2cm2 == rdiv2sm2) Out[nnum][offset] = MIN(value, partner);
    else Out[nnum][offset] = MAX(value, partner);

    offset = ATOMIC_ADDMS((long *)currp, 2);
  }
}

void comparator_nodelet(unsigned long *currp, unsigned long stage, long step,
			long **In, long **Out)
{
  unsigned long nthreads = numthreads;
  if (nthreads > elts_per_nlet) nthreads = elts_per_nlet;
  *currp = nthreads;
  for (unsigned long i = 0; i < nthreads; i++)
    cilk_spawn comparator_thread(currp, i, stage, step, In, Out);
}

void print_array(long **arr, unsigned long n);

int main(int argc, char **argv)
{
  unsigned long bintest = 0;
  unsigned long buf_size = 1024;
  unsigned long nnodes1 = NODELETS();
  unsigned long nthreads = 16;
  unsigned long printflag = 0;
  double clockrate = 150.0;

  int c;
  while ((c = getopt(argc, argv, "hbs:n:t:c:p:")) != -1)
    {
      switch (c)
        {
        case 'h':
          printf("Optional argument: <file> (prompted if not present)\n");
          printf("Program options: -hbntscp\n");
          printf("  -h print this help and exit\n");
          printf("  -b binary file, detault text\n");
          printf("  -s <N> for buffer size, default 1024\n");
          printf("  -n <N> for nodelets (power of 2), default NODELETS()\n");
          printf("  -t <N> for number of threads, default 16\n");
          printf("  -c <N> for clock rate, default 150.0MHz\n");
          printf("  -p <N> for debug level > 0\n");
          exit(0);
          break;
        case 'b': bintest = 1; break;
        case 's': buf_size = atol(optarg); break;
        case 'n': nnodes1 = atol(optarg); break;
        case 't': nthreads = atol(optarg); break;
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

  // first pass: count the number of elements
  unsigned long elt_index = 0;
  long *temp =(long *)malloc(buf_size * sizeof(long));
  while (! feof(fp)) {
    unsigned long numread = 0;
    if (bintest) numread = fread(temp, sizeof(long), buf_size, fp);
    else while ((fscanf(fp, "%ld", &temp[numread]) != EOF) &&
		(numread < buf_size)) numread++;
    elt_index += numread;
  }
  rewind(fp);

  // find next power of 2, elts and nodes
  unsigned long power = 1;
  unsigned long lg2power = 0;
  while (power < elt_index) { power <<= 1; lg2power++; }
  unsigned long nnodes = 1;
  while (nnodes < nnodes1) nnodes <<= 1;
  unsigned long epn = power / nnodes; // epn is 2^x

  // initialize replicated variables
  mw_replicated_init((long *)&total_elts, (long)power);
  mw_replicated_init((long *)&elts_per_nlet, (long)epn);
  mw_replicated_init((long *)&numthreads, (long)nthreads);
  mw_replicated_init((long *)&curr_index, 0);

  // second pass: read data into distributed array, start with block mapping
  long **InArray = (long **)mw_malloc2d(nnodes, epn * sizeof(long));
  long **OutArray = (long **)mw_malloc2d(nnodes, epn * sizeof(long));
  elt_index = 0;
  while (! feof(fp)) {
    unsigned long numread = 0;
    if (bintest) numread = fread(temp, sizeof(long), buf_size, fp);
    else while ((fscanf(fp, "%ld", &temp[numread]) != EOF) &&
		(numread < buf_size)) numread++;

    for (unsigned long i = 0; i < numread; i++) {
      unsigned long nlet = GET_NODE(elt_index, epn);
      unsigned long off = GET_OFFSET(elt_index, epn);
      InArray[nlet][off] = temp[i];
      elt_index++;
    }
  }
  free(temp);
  fclose(fp);

  // fill to nearest power of 2
  for (unsigned long i = elt_index; i < power - 1; i++) {
    unsigned long nlet = GET_NODE(i, epn);
    unsigned long off = GET_OFFSET(i, epn);
    InArray[nlet][off] = LONG_MAX;
  }

#ifndef SIM0
  printf("INPUT:\n"); fflush(stdout); print_array(InArray, power);
#endif

#ifdef SIM1
  starttiming();
#else
#ifndef SIM0
  unsigned long nid = NODE_ID();
  unsigned long starttime = CLOCK();
#endif
#endif
  long **In = InArray;
  long **Out = OutArray;
  for (unsigned long stage = 1; stage <= lg2power; stage++) {
    for (long step = stage - 1; step >= 0; step--) {
      for (unsigned long i = 0; i < nnodes; i++) {
	unsigned long *currp = mw_get_nth(&curr_index, i);
	cilk_spawn comparator_nodelet(currp, stage, step, In, Out);
      }
      cilk_sync;
      long **Tmp = In;
      In = Out;
      Out = Tmp;
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
  printf("Nlets %lu Nthreads %lu Clock %.1lf Total %lu Time(ms) %.1lf\n",
	 nnodes, nthreads, clockrate, totaltime, ms); fflush(stdout);

  for (unsigned long i = 0; i < power - 1; i++) {
    unsigned long nlet = GET_NODE(i, epn);
    unsigned long off = GET_OFFSET(i, epn);
    unsigned long nletp1 = GET_NODE(i + 1, epn);
    unsigned long offp1 = GET_OFFSET(i + 1, epn);
    if (In[nlet][off] > In[nletp1][offp1]) {
      printf("FAILED\n"); fflush(stdout);
      break;
    }
  }

  printf("OUTPUT:\n"); fflush(stdout); print_array(In, power);
#endif
#endif
    return 0;
}

void print_array(long **arr, unsigned long n)
{
  printf("[%ld", arr[0][0]); fflush(stdout);
  for (unsigned long i = 1; i < n; i++) {
    unsigned long nlet = GET_NODE(i, elts_per_nlet);
    unsigned long off = GET_OFFSET(i, elts_per_nlet);
    printf(",%ld", arr[nlet][off]); fflush(stdout);
  }
  printf("]\n"); fflush(stdout);
}
