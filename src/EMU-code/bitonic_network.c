#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "memoryweb.h"
#include "cilk.h"

#define GET_NODE(v, p) (v / p)
#define GET_OFFSET(v, p) (v % p)
#define GET_INDEX(n, o, p) (n * p + o)

#define MAX(a,b)              \
  ({ __typeof__ (a) _a = (a); \
  __typeof__ (b) _b = (b);  \
  _a > _b ? _a : _b;})

#define MIN(a,b)              \
  ({ __typeof__ (a) _a = (a); \
  __typeof__ (b) _b = (b);  \
  _a < _b ? _a : _b;})

replicated unsigned long elts_per_nlet;
replicated unsigned long numthreads;
replicated unsigned long curr_index;

long dest_max_nlet(long g, long p, long n, long o)
{
  return 0; // compute destination
}

long dest_min_nlet(long g, long p, long n, long o)
{
  return 0; // compute destination
}

long dest_max_offset(long g, long p, long n, long o)
{
  return 0; // compute desintation
}

long dest_min_offset(long g, long p, long n, long o)
{
  return 0; // compute destination
}

// grab a pair of values at an offset and write max/min to correct dest
void comparator_thread(unsigned long *currp, unsigned long offset, long stage,
		       long step, long *In, long **Out)
{
  long nnum = NODE_ID();
  long epn = elts_per_nlet;
  while (offset < epn) {
    long max_val = MAX(In[offset], In[offset + 1]);
    long min_val = MIN(In[offset], In[offset + 1]);
    long max_nlet = dest_max_nlet(stage, step, nnum, offset);
    long min_nlet = dest_min_nlet(stage, step, nnum, offset);
    long max_off = dest_max_offset(stage, step, nnum, offset);
    long min_off = dest_min_offset(stage, step, nnum, offset);
    Out[max_nlet][max_off] = max_val; // may migrate to get pointer
    Out[min_nlet][min_off] = min_val; // replace with pointer computation

    offset = ATOMIC_ADDMS((long *)currp, 2);
  }
}

void comparator_nodelet(unsigned long *currp, long stage, long step, long *In,
			long **Out)
{
  unsigned long nthreads = numthreads;
  if (nthreads > elts_per_nlet / 2) nthreads = elts_per_nlet / 2;
  *currp = 2 * nthreads;
  for (unsigned long i = 0; i < nthreads; i *= 2)
    cilk_spawn comparator_thread(currp, i, stage, step, In, Out);
}

int main(int argc, char **argv)
{
  unsigned long bintest = 0;
  unsigned long nnodes = NODELETS();
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

  mw_replicated_init((long *)&numthreads, (long)nthreads);
  mw_replicated_init((long *)&elts_per_nlet, (long)epn);
  mw_replicated_init((long *)&curr_index, 0);

  long **InArray =(long **)mw_malloc2d(nnodes, epn * sizeof(long));
  long **OutArray =(long **)mw_malloc2d(nnodes, epn * sizeof(long));
  long *temp =(long *)malloc(buf_size * sizeof(long));
  long elt_index = 0;
  while (! feof(fp)) {
    long numread = 0;
    if (bintest) numread = fread(temp, sizeof(long), buf_size, fp);
    else while ((fscanf(fp, "%ld", &temp[numread]) != EOF) &&
		(numread < buf_size)) numread++;

    for (long i = 0; i < numread; i++) {
      long nlet = GET_NODE(elt_index, epn);
      long off = GET_OFFSET(elt_index, epn);
      InArray[nlet][off] = temp[i];
      elt_index++;
    }
  }
  free(temp);
  fclose(fp);

#ifndef SIM0
  if (printflag == 1) {
    for (long i = 0; i < nnodes; i++) {
      for (long j = 0; j < epn; j++) {
	printf("NID %ld ofset %ld value %ld\n", i, j, InArray[i][j]);
        fflush(stdout);
      }
    }
  }
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
  for (long stage = 2; stage <= elt_index; stage *= 2) {
    for (long step = 2; step < stage * 2; step *= 2) {
      for (long i = 0; i < nnodes; i++) {
	unsigned long *currp = mw_get_nth(&curr_index, i);
	cilk_spawn comparator_nodelet(currp, stage, step, In[i], Out);
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
  printf("Nlets %lu Clock %.1lf Total %lu Time(ms) %.1lf\n",
	 nnodes, clockrate, totaltime, ms); fflush(stdout);

  for (long i = 1; i < elt_index - 1; i++) {
    long nlet = GET_NODE(i, epn);
    long off = GET_OFFSET(i, epn);
    long nletp1 = GET_NODE(i + 1, epn);
    long offp1 = GET_OFFSET(i + 1, epn);
    if (InArray[nlet][off] > InArray[nletp1][offp1]) {
      printf("FAILED\n"); fflush(stdout);
      break;
    }
  }

  if (printflag == 2) {
    printf("SORTED ARRAY:\n");
    printf("[%ld", InArray[0][0]); fflush(stdout);
    for (long i = 1; i < elt_index; i++) {
      long nlet = GET_NODE(i, epn);
      long off = GET_OFFSET(i, epn);
      printf(",%ld", InArray[nlet][off]); fflush(stdout);
    }
    printf("]\n"); fflush(stdout);
  }
#endif
#endif
    return 0;
}
