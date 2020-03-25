/*

BitonicSort.c: bitonic sort with smart layout
Janice Onanian McMahon <jmcmahon@emutechnology.com>
March, 2020

*/

#include <stdlib.h>
#include <getopt.h>
#include <cilk.h>
#include <memoryweb.h>
#include <emu_c_utils/emu_c_utils.h>

#define MAX(a,b)              \
  ({ __typeof__ (a) _a = (a); \
  __typeof__ (b) _b = (b);  \
  _a > _b ? _a : _b;})

#define MIN(a,b)              \
  ({ __typeof__ (a) _a = (a); \
  __typeof__ (b) _b = (b);  \
  _a < _b ? _a : _b;})

#define BITMASK(a) ((1 << (a)) - 1)

replicated long g_N;
replicated long g_lgN;
replicated long g_lgE;
replicated long g_lgP;
replicated long g_lgR;
replicated long g_lgC;
replicated long *g_arr1;
replicated long *g_arr2;
replicated long g_forw;
replicated long g_map_step;
replicated long g_map_stage;

unsigned long cyclic_to_block(unsigned long in, long lgE, long lgP)
{
  unsigned long Aval = (in >> lgP) & BITMASK(lgE);
  unsigned long Cval = (in & BITMASK(lgP)) << lgE;
  return Aval | Cval;
}

unsigned long block_to_cyclic(unsigned long in, long lgE, long lgP)
{
  unsigned long Aval = (in >> lgE) & BITMASK(lgP);
  unsigned long Cval = (in & BITMASK(lgE)) << lgP;
  return Aval | Cval;
}

// comparator: do the nodes for stage/step
void nletcomp(long ic, long end, long shift, long dist, long jstart, long jend)
{
  long forw = g_forw;
  long *arr1 = g_arr1;
  long *arr2 = g_arr2;
  long lgE = g_lgE;
  long lgP = g_lgP;
  long start = block_to_cyclic(ic, lgE, lgP); // ic is a relative address
  long newdist = block_to_cyclic(dist, lgE, lgP); // cyclic mapping
  for (long ro = start; ic < end; ro += 2 * dist * NODELETS(), ic += 2 * dist) {
    for (long j = jstart, r = ro; j < jend; j++, r += NODELETS()) {
      long icnew = ic + j;
      unsigned long rdiv2sm2 = (icnew >> shift) & 1;
      unsigned long r1div2sm2 = ((icnew + dist) >> shift) & 1;
      long r1 = r + newdist;
      if (forw) {
	long min_val = MIN(arr1[r], arr1[r1]);
	long max_val = MAX(arr1[r], arr1[r1]);
	if (! rdiv2sm2) arr2[r] = min_val;
	else arr2[r] = max_val;
	if (r1div2sm2) arr2[r1] = min_val;
	else arr2[r1] = max_val;
      } else {
	long min_val = MIN(arr2[r], arr2[r1]);
	long max_val = MAX(arr2[r], arr2[r1]);
	if (! rdiv2sm2) arr1[r] = min_val;
	else arr1[r] = max_val;
	if (r1div2sm2) arr1[r1] = min_val;
	else arr1[r1] = max_val;
      }
    }
  }
}

// comparator: do the nodes for stage/step
void comp(long nctr, unsigned long s, long c)
{
  long lgE = g_lgE;
  long dist = 1 << (c - 1);
  long shift = s;
  long map_c = g_map_step;
  if (map_c >= lgE) { // a = 0; b = lgE;
    unsigned long t = map_c - lgE;
    dist >>= t; // move distance from abs B to rel B
    if ((shift >= 0) && (shift < t))  shift += lgE; // in C
    else if ((shift >= t) && (shift < map_c)) shift -= t; // in B
  } else if (map_c >= 0) { // a = map_c; t = map_c + s - lgE; b = lgE - a;
    long tminusa = s - lgE;
    unsigned long t = map_c + tminusa;
    unsigned long b = lgE - map_c;
    if (c > map_c) dist >>= tminusa; // only move for next stage
    if ((shift >= map_c) && (shift < t))  shift += b; // in C
    else if ((shift >= t) && (shift < s)) shift -= tminusa; // in B
  }
  long totalthreads = 1 << g_lgC;
  long numoutthreads = MAX(MIN((1 << lgE) / (2 * dist), totalthreads), 1);
  long outerinc = (1 << lgE) / numoutthreads;
  long numinthreads = MAX(MIN(dist, totalthreads / numoutthreads), 1);
  long innerinc = dist / numinthreads;
  long start = nctr << lgE, node_end = (nctr + 1) << lgE;
  if (start % (2 * dist) < dist) { // need this for non-smart sort
    for (long r = start; r < node_end; r += outerinc)
      for (long j = 0; j < dist; j += innerinc)
	cilk_spawn nletcomp(r, r + outerinc, shift, dist, 0, dist);
  }
  cilk_sync;
  g_forw ^= 1; // toggle forw in nodelet
}

// comparator: do the nodes for stage/step
#ifdef RECURSIVE
#ifdef LINEAR
void processcolumn(unsigned long low, long s, long c)
{
  long *arr1 = g_arr1;
  if (low < NODELETS() - 1) {
    cilk_spawn_at (&arr1[low + 1]) processcolumn(low + 1, s, c);
  }
  comp(low, s, c);
}
#else
void processcolumn(unsigned long low, unsigned long high, long s, long c)
{
  long *arr1 = g_arr1;
  for (;;) {
    unsigned long count = high - low;
    if (count <= 1) break;
    unsigned long mid = low + count / 2;
    cilk_spawn_at (&arr1[mid]) processcolumn(mid, high, s, c);
    high = mid;
  }
  comp(low, s, c);
}
#endif
#else
void processcolumn(long s, long c)
{
  long *arr1 = g_arr1;
  for (long nctr = 0; nctr < NODELETS(); nctr++) { // spawn in each nodelet
    cilk_spawn_at (&arr1[nctr]) comp(nctr, s, c);
  }
}
#endif

// relative address to absolute
unsigned long rel_to_abs(unsigned long rel, unsigned long a, unsigned long t,
			 long lgE)
{
  unsigned long b = lgE - a;
  unsigned long Aval = rel & ~BITMASK(b + t);
  unsigned long Bval = ((rel >> a) & BITMASK(b)) << t;
  unsigned long Cval = ((rel >> (b + a)) & BITMASK(t - a)) << a;
  unsigned long Dval = rel & BITMASK(a);
  return Aval | Bval | Cval | Dval;
}

// absolute address to relative
unsigned long abs_to_rel(unsigned long abs, unsigned long a, unsigned long t,
			 long lgE)
{
  unsigned long b = lgE - a;
  unsigned long Aval = abs & ~BITMASK(b + t);
  unsigned long Bval = ((abs >> t) & BITMASK(b)) << a;
  unsigned long Cval = ((abs >> a) & BITMASK(t - a)) << (b + a);
  unsigned long Dval = abs & BITMASK(a);
  return Aval | Bval | Cval | Dval;
}

// remap: move data to new mapping from old mapping
void nletmove(long s, long e, long new_s, long new_c)
{
  long forw = g_forw;
  long old_c = g_map_step;
  unsigned long old_s = g_map_stage;
  long *arr1 = g_arr1;
  long *arr2 = g_arr2;
  long lgE = g_lgE;
  long lgP = g_lgP;

  unsigned long old_a, old_t, new_a, new_t;
  if (old_c >= lgE) { old_a = 0; old_t = old_c - lgE; }
  else { old_a = old_c; old_t = old_c + old_s - lgE + 1; }
  if (new_c >= lgE) { new_a = 0; new_t = new_c - lgE; }
  else { new_a = new_c; new_t = new_c + new_s - lgE + 1; }

  long ic = cyclic_to_block(s, lgE, lgP);
  for (long i = s; i < e; i += NODELETS(), ic++) { // search all indices
    unsigned long i_new = ic;
    if (old_c > 0) i_new = rel_to_abs(ic, old_a, old_t, lgE);
    if (new_c > 0) i_new = abs_to_rel(i_new, new_a, new_t, lgE);
    i_new = block_to_cyclic(i_new, lgE, lgP);
    if (forw) arr2[i_new] = arr1[i]; // should be remote write ...
    else arr1[i_new] = arr2[i]; // ... no migration
  }
}

// spawn threads in each nodelet
void move(long nctr, long new_stage, long new_step)
{
  long N = g_N;
  long workinc = 1 << (g_lgE - g_lgR + g_lgP); // wpt * NODELETS();
  long start = nctr;
  while (start < N) {
    long end = start + workinc;
    cilk_spawn nletmove(start, end, new_stage, new_step);
    start = end;
  }
  cilk_sync;
  g_map_step = new_step; // update global current step in nodelet
  g_map_stage = new_stage; // update global current stage in nodelet
  g_forw ^= 1; // toggle forw in nodelet
}

#ifdef RECURSIVE
#ifdef LINEAR
void remap(unsigned long low, long new_stage, long new_step)
{
  //  long *arr1 = g_arr1; // doesn't work - why??
  if (low < NODELETS() - 1) {
    long *sptr = mw_get_nth(&g_N, low + 1);
    //    cilk_spawn_at (&arr1[low + 1]) remap(low + 1, new_stage, new_step);
    cilk_spawn_at (sptr) remap(low + 1, new_stage, new_step);
  }
  move(low, new_stage, new_step);
}
#else
void remap(unsigned long low, unsigned long high, long new_stage, long new_step)
{
  long *arr1 = g_arr1;
  for (;;) {
    unsigned long count = high - low;
    if (count <= 1) break;
    unsigned long mid = low + count / 2;
    cilk_spawn_at (&arr1[mid]) remap(mid, high, new_stage, new_step);
    high = mid;
  }
  move(low, new_stage, new_step);
}
#endif
#else
// remap: move data to new mapping from old mapping
void remap(long new_stage, long new_step)
{
  long *arr1 = g_arr1;
  for (long nctr = 0; nctr < NODELETS(); nctr++) { // spawn in each nodelet
    cilk_spawn_at (&arr1[nctr]) move(nctr, new_stage, new_step);
  }
}
#endif

// globalsort: return input/output toggle to keep track
void globalsort(long lgE, long lgN, long lgP, long smart)
{
  unsigned long next_stage = lgN + 1; // initial remapping stage
  unsigned long next_step = lgN + 1; // initial remapping step
  if (smart) {
    next_stage = lgE + 1; // initial remapping stage
    next_step = lgE + 1; // initial remapping step
  }
  for (unsigned long stage = 1; stage <= lgN; stage++) {
    for (long step = stage; step > 0; step--) {
      if ((stage == next_stage) && (step == next_step)) {
	long k = stage - lgE;
	long mstep = step;
	if ((k == lgP) && (step <= lgE)) mstep = -1; // last remap, block
	else {
	  next_stage = (step > lgE) ? stage : stage + 1;
	  unsigned long t = (step >= lgE) ? (step - lgE) : step + k + 1;
	  next_step = (t == 0) ? (lgE + k + 1) : t; // page 28
#ifdef DEBUG
	  unsigned long a;
	  if (step >= lgE) a = 0; else a = step;
	  printf("%ld: k %ld s %ld a %ld b %ld t %ld\n",
		 stage, k, step, a, lgE - a, t);
#endif
	}
#ifdef RECURSIVE
#ifdef LINEAR
	remap(0, stage, mstep);
#else
	remap(0, NODELETS(), stage, mstep);
#endif
#else
	remap(stage, mstep);
#endif
      }
#ifdef RECURSIVE
#ifdef LINEAR
      processcolumn(0, stage, step); // compute
#else
      processcolumn(0, NODELETS(), stage, step); // compute
#endif
#else
      processcolumn(stage, step); // compute
#endif
    }
  }
}

long log2_val(long n)
{
  long r = 0;
  while (n >>= 1) r++;
  return r;
}

int main(int argc, char **argv)
{
  long smart = 1;
  long profile = 0; // use clock intrinsic for timing
  long lgP = log2_val(NODELETS());
  long lgN = lgP + 1; // two elts per nodelet
  long lgR = 0; // 1 thread
  long lgC = 0; // 1 thread
  int c;
  while ((c = getopt(argc, argv, "sp:n:R:C:")) != -1) {
    switch (c) {
    case 's': smart = 0; break;
    case 'p': profile = atol(optarg); break;
    case 'n': lgN = atol(optarg); break;
    case 'R': lgR = atol(optarg); break;
    case 'C': lgC = atol(optarg); break;
    }
  }

  if (lgN <= lgP) lgN = lgP + 1; // minimum N >= 2 * P
  long lgE = lgN - lgP; // log2_val(epn);
  if (lgE < 0) lgE = 0; // min 1 elt per processor
  if (lgR > lgE) lgR = lgE; // max epn threads for remap
  if (lgC > lgE) lgC = lgE - 1; // max threads for comparisons
  if (lgC < 0) lgC = 0; // min 1 thread
  if (lgR < 0) lgR = 0; // min 1 thread

  long N = 1 << lgN;
  mw_replicated_init(&g_N, N);
  mw_replicated_init(&g_lgN, lgN);
  mw_replicated_init(&g_lgP, lgP);
  mw_replicated_init(&g_lgE, lgE);
  mw_replicated_init(&g_lgR, lgR);
  mw_replicated_init(&g_lgC, lgC);
  long *arr1 = mw_malloc1dlong(N);
  mw_replicated_init((long *)&g_arr1, (long)arr1);
  long *arr2 = mw_malloc1dlong(N);
  mw_replicated_init((long *)&g_arr2, (long)arr2);

  mw_replicated_init(&g_forw, 1); // start with input in 1 and output in 2
  mw_replicated_init(&g_map_step, -1); // initial mapping is block
  mw_replicated_init(&g_map_stage, 0); // initial a (unused in block mapping)
  for (long i = 0; i < N; i++) {
    long ind = block_to_cyclic(i, lgE, lgP);
    arr1[ind] = N - i;
  }

  long startnlet, endnlet;
  unsigned long starttime, endtime;
  if (profile == 2) hooks_region_begin("bitonicsort");
  else if (profile == 1) starttiming();
  else if (profile == 0) {
    startnlet = NODE_ID();
    starttime = CLOCK();
  }
  globalsort(lgE, lgN, lgP, smart);
  if (profile == 2) {
    double time_ms = hooks_region_end();
    printf("Time : %f\n", time_ms); fflush(stdout);
  } else if (profile == 0) {
    endtime = CLOCK();
    endnlet = NODE_ID();
    printf("N %ld P %ld lgN %ld lgP %ld lgE %ld\n",
	   N, NODELETS(), lgN, lgP, lgE);
    double time_ms = (endtime - starttime) / 175000.0;
    printf("start %lu nlet %lu end %lu nlet %lu : Time (ms) = %lf\n",
	   starttime, startnlet, endtime, endnlet, time_ms);

    long *res;
    if (g_forw) res = arr1; else res = arr2;
    long pass = 1;
    for (long i = 0; i < N - 1; i++) {
      long ind1 = block_to_cyclic(i, lgE, lgP);
      long ind2 = block_to_cyclic(i + 1, lgE, lgP);
      printf("%ld ", res[ind1]);
      if (i == N - 2) printf("%ld\n", res[ind2]);
      if (res[ind1] > res[ind2]) pass = 0;
    }
    fflush(stdout);
    if (pass) printf("PASS\n"); else printf("FAIL\n");
  }
  return 0;
}
