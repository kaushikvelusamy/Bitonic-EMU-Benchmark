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

#ifdef HPEC
replicated long *remap_ptr;
replicated long *compute_ptr;
#endif
replicated long g_N;
replicated long g_lgN;
replicated long g_lgE;
replicated long g_lgP;
replicated long g_lgR;
replicated long g_lgC;
replicated long *g_inptr;
replicated long *g_outptr;
replicated long g_shift;
replicated long g_dist;
replicated long g_cycdist;
replicated long g_map_step;
replicated long g_map_stage;
replicated long g_new_c;
replicated long g_new_a;
replicated long g_new_t;
replicated long g_old_a;
replicated long g_old_t;

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
void innerloop_diff(long icnew, long innerend, long *inptr, long mask,
		    long *r1_ptr)
{
  while (icnew < innerend) {
    if (icnew & mask) {
      long r_val = *r1_ptr;
      r_val = ATOMIC_MAXMS(inptr, r_val);
#ifdef NOREMOTES
      ATOMIC_MAXM(r1_ptr, r_val);
#else
      REMOTE_MAX(r1_ptr, r_val);
#endif
    } else {
      long r_val = *r1_ptr;
      r_val = ATOMIC_MINMS(inptr, r_val);
#ifdef NOREMOTES
      ATOMIC_MINM(r1_ptr, r_val);
#else
      REMOTE_MIN(r1_ptr, r_val);
#endif
    }
    icnew++; inptr += NODELETS(); r1_ptr += NODELETS();
  }
}

// comparator: do the nodes for stage/step
void innerloop_same(long icnew, long innerend, long *inptr, long mask,
		    long *r1_ptr)
{
  while (icnew < innerend) {
    if (icnew & mask) {
      long r_val = *r1_ptr;
      r_val = ATOMIC_MAXMS(inptr, r_val);
#ifdef NOREMOTES
      ATOMIC_MINM(r1_ptr, r_val);
#else
      REMOTE_MIN(r1_ptr, r_val);
#endif
    } else {
      long r_val = *r1_ptr;
      r_val = ATOMIC_MINMS(inptr, r_val);
#ifdef NOREMOTES
      ATOMIC_MAXM(r1_ptr, r_val);
#else
      REMOTE_MAX(r1_ptr, r_val);
#endif
    }
    icnew++; inptr += NODELETS(); r1_ptr += NODELETS();
  }
}

// innerloop comparator, depends if bits of r and r1 are same or diff
void nletinner(long icnew, long icend)
{
  long r = block_to_cyclic(icnew, g_lgE, g_lgP); // ic is a relative address
  long newdist = g_cycdist; long mask = 1 << g_shift;
  long *inptr = &g_inptr[r]; long *r1_ptr = inptr + newdist;
  if (g_dist == mask) innerloop_diff(icnew, icend, inptr, mask, r1_ptr);
  else innerloop_same(icnew, icend, inptr, mask, r1_ptr);
}

// comparator: do the nodes for stage/step
void outerloop_diff(long icnew, long icend, long *inptr, long mask, long dist,
		    long newdist, long *r1_ptr)
{
  while (icnew < icend) {
    long innerend = icnew + dist;
    while (icnew < innerend) {
      if (icnew & mask) {
	long r_val = *r1_ptr;
	r_val = ATOMIC_MAXMS(inptr, r_val);
#ifdef NOREMOTES
	ATOMIC_MAXM(r1_ptr, r_val);
#else
	REMOTE_MAX(r1_ptr, r_val);
#endif
      } else {
	long r_val = *r1_ptr;
	r_val = ATOMIC_MINMS(inptr, r_val);
#ifdef NOREMOTES
	ATOMIC_MINM(r1_ptr, r_val);
#else
	REMOTE_MIN(r1_ptr, r_val);
#endif
      }
      icnew++; inptr += NODELETS(); r1_ptr += NODELETS();
    }
    icnew += dist; inptr += newdist; r1_ptr += newdist;
  }
}

// comparator: do the nodes for stage/step
void outerloop_same(long icnew, long icend, long *inptr, long mask, long dist,
		    long newdist, long *r1_ptr)
{
  while (icnew < icend) {
    long innerend = icnew + dist;
    while (icnew < innerend) {
      if (icnew & mask) {
	long r_val = *r1_ptr;
	r_val = ATOMIC_MAXMS(inptr, r_val);
#ifdef NOREMOTES
	ATOMIC_MINM(r1_ptr, r_val);
#else
	REMOTE_MIN(r1_ptr, r_val);
#endif
      } else {
	long r_val = *r1_ptr;
	r_val = ATOMIC_MINMS(inptr, r_val);
#ifdef NOREMOTES
	ATOMIC_MAXM(r1_ptr, r_val);
#else
	REMOTE_MAX(r1_ptr, r_val);
#endif
      }
      icnew++; inptr += NODELETS(); r1_ptr += NODELETS();
    }
    icnew += dist; inptr += newdist; r1_ptr += newdist;
  }
}

// outerloop comparator, depends on whether bits of r and r1 are same or diff
void nletcomp(long icnew, long icend)
{
  long r = block_to_cyclic(icnew, g_lgE, g_lgP); // ic is a relative address
  long dist = g_dist; long newdist = g_cycdist; long mask = 1 << g_shift;
  long *inptr = &g_inptr[r]; long *r1_ptr = inptr + newdist;
  if (dist == mask) outerloop_diff(icnew, icend, inptr, mask, dist, newdist,
				   r1_ptr);
  else outerloop_same(icnew, icend, inptr, mask, dist, newdist, r1_ptr);
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

  long start = nctr << lgE;
  if (start % (2 * dist) < dist) { // need this for non-smart sort
    g_shift = shift;
    g_dist = dist;
    g_cycdist = block_to_cyclic(dist, lgE, g_lgP); // cyclic mapping

    long node_end = (nctr + 1) << lgE;
    long totalthreads = 1 << g_lgC;
    long numblocks = (1 << lgE) / (2 * dist);
#ifdef WITHINNER
    if (numblocks >= totalthreads) { // parallel over blocks (outer only)
#else
    if (1) { // parallel over blocks (outer only)
#endif
      long numoutthreads = MAX(MIN(numblocks, totalthreads), 1);
      long outerinc = (1 << lgE) / numoutthreads;
      for (long r = start; r < node_end; r += outerinc)
	cilk_spawn nletcomp(r, r + outerinc);
    } else { // one block per outer thread; each block parallelized, slower
      long mypart = 1 << lgE; // if block is spread over nodelets
      long numinthreads = totalthreads; // all threads are inner
      if (numblocks >= 1) // otherwise, threads are nested
	{ mypart = dist; numinthreads = MIN(dist, totalthreads / numblocks); }
      long innerinc = mypart / numinthreads;
      long cinc = block_to_cyclic(innerinc, lgE, g_lgP);

      for (long r = start; r < node_end; r += 2 * dist) {
	long ro = block_to_cyclic(r, g_lgE, g_lgP); // relative address
	for (long j = 0; j < mypart; j += innerinc, ro += cinc)
	  cilk_spawn nletinner(r + j, r + j + innerinc);
      }
    }
    cilk_sync;
  }
}

// comparator: do the nodes for stage/step
#ifdef RECURSIVE
#ifdef LINEAR
void processcolumn(unsigned long low, long s, long c)
{
  long *inptr = g_inptr;
  if (low < NODELETS() - 1) {
    cilk_spawn_at (&inptr[low + 1]) processcolumn(low + 1, s, c);
  }
  comp(low, s, c);
}
#else
void processcolumn(unsigned long low, unsigned long high, long s, long c)
{
  long *inptr = g_inptr;
  for (;;) {
    unsigned long count = high - low;
    if (count <= 1) break;
    unsigned long mid = low + count / 2;
    cilk_spawn_at (&inptr[mid]) processcolumn(mid, high, s, c);
    high = mid;
  }
  comp(low, s, c);
}
#endif
#else
void processcolumn(long s, long c)
{
  long *inptr = g_inptr;
  for (long nctr = 0; nctr < NODELETS(); nctr++) { // spawn in each nodelet
    cilk_spawn_at (&inptr[nctr]) comp(nctr, s, c);
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

// remap: move data to new mapping from old mapping (old_c <= 0, new_c > 0)
void nletmove_oldblock(long s, long e)
{
  long *inarr = g_inptr;
  long *outarr = g_outptr;
  long lgE = g_lgE;
  long lgP = g_lgP;
  long new_a = g_new_a;
  long new_t = g_new_t;
  long i = block_to_cyclic(s, lgE, lgP); // cyclic address to index arrays
  for (long ic = s; ic < e; ic++, i += NODELETS()) { // loop over portion
    unsigned long i_new = abs_to_rel(ic, new_a, new_t, lgE); // new address
    i_new = block_to_cyclic(i_new, lgE, lgP); // cyclic to address arrays
    outarr[i_new] = inarr[i]; // should be remote write ...
  }
}

// remap: move data to new mapping from old mapping (new_c <= 0, old_c > 0)
void nletmove_newblock(long s, long e)
{
  long *inarr = g_inptr;
  long *outarr = g_outptr;
  long lgE = g_lgE;
  long lgP = g_lgP;
  long old_a = g_old_a;
  long old_t = g_old_t;
  long i = block_to_cyclic(s, lgE, lgP); // cyclic address to index arrays
  for (long ic = s; ic < e; ic++, i += NODELETS()) { // loop over portion
    unsigned long i_new = rel_to_abs(ic, old_a, old_t, lgE); // new address
    i_new = block_to_cyclic(i_new, lgE, lgP); // cyclic to address arrays
    outarr[i_new] = inarr[i]; // should be remote write ...
  }
}

// remap: move data to new mapping from old mapping (new_c > 0, old_c > 0)
void nletmove(long s, long e)
{
  long *inarr = g_inptr;
  long *outarr = g_outptr;
  long lgE = g_lgE;
  long lgP = g_lgP;
  long old_a = g_old_a;
  long old_t = g_old_t;
  long new_a = g_new_a;
  long new_t = g_new_t;
  long i = block_to_cyclic(s, lgE, lgP); // cyclic address to index arrays
  for (long ic = s; ic < e; ic++, i += NODELETS()) { // loop over portion
    unsigned long i_new = rel_to_abs(ic, old_a, old_t, lgE);
    i_new = abs_to_rel(i_new, new_a, new_t, lgE); // new address
    i_new = block_to_cyclic(i_new, lgE, lgP); // cyclic to address arrays
    outarr[i_new] = inarr[i]; // ... no migration
  }
}

// spawn threads in each nodelet
void move(long nctr, long new_s, long new_c)
{
  g_new_c = new_c;
  long old_c = g_map_step;
  long lgE = g_lgE;
  unsigned long old_a, old_t, new_a, new_t;
  if (old_c >= lgE) { old_a = 0; old_t = old_c - lgE; }
  else { old_a = old_c; old_t = old_c + g_map_stage - lgE + 1; }
  if (new_c >= lgE) { new_a = 0; new_t = new_c - lgE; }
  else { new_a = new_c; new_t = new_c + new_s - lgE + 1; }

  g_new_a = new_a;
  g_new_t = new_t;
  g_old_a = old_a;
  g_old_t = old_t;
  long start = nctr << lgE;
  long node_end = (nctr + 1) << lgE;
  long outerinc = 1 << (g_lgE - g_lgR); // lgE always >= lgR
  if (old_c < 0) {
    for (long r = start; r < node_end; r += outerinc)
      cilk_spawn nletmove_oldblock(r, r + outerinc);
  } else if (new_c < 0) {
    for (long r = start; r < node_end; r += outerinc)
      cilk_spawn nletmove_newblock(r, r + outerinc);
  } else {
    for (long r = start; r < node_end; r += outerinc)
      cilk_spawn nletmove(r, r + outerinc);
  }
  cilk_sync;
  g_map_step = new_c; // update global current step in nodelet
  g_map_stage = new_s; // update global current stage in nodelet
  long *temp = g_inptr; g_inptr = g_outptr; g_outptr = temp; // swap buffers
}

#ifdef RECURSIVE
#ifdef LINEAR
void remap(unsigned long low, long new_stage, long new_step)
{
  //  long *inptr = g_inptr; // doesn't work - why??
  if (low < NODELETS() - 1) {
    long *sptr = mw_get_nth(&g_N, low + 1);
    //    cilk_spawn_at (&inptr[low + 1]) remap(low + 1, new_stage, new_step);
    cilk_spawn_at (sptr) remap(low + 1, new_stage, new_step);
  }
  move(low, new_stage, new_step);
}
#else
void remap(unsigned long low, unsigned long high, long new_stage, long new_step)
{
  long *inptr = g_inptr;
  for (;;) {
    unsigned long count = high - low;
    if (count <= 1) break;
    unsigned long mid = low + count / 2;
    cilk_spawn_at (&inptr[mid]) remap(mid, high, new_stage, new_step);
    high = mid;
  }
  move(low, new_stage, new_step);
}
#endif
#else
// remap: move data to new mapping from old mapping
void remap(long new_stage, long new_step)
{
  long *inptr = g_inptr;
  for (long nctr = 0; nctr < NODELETS(); nctr++) { // spawn in each nodelet
    cilk_spawn_at (&inptr[nctr]) move(nctr, new_stage, new_step);
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
#ifdef HPEC
      volatile long rtime = -CLOCK();
#endif
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
#ifdef HPEC
      MIGRATE(&rtime);
      REMOTE_ADD(remap_ptr, rtime + CLOCK());
      volatile long ctime = -CLOCK();
#endif
#ifdef RECURSIVE
#ifdef LINEAR
      processcolumn(0, stage, step); // compute
#else
      processcolumn(0, NODELETS(), stage, step); // compute
#endif
#else
      processcolumn(stage, step); // compute
#endif
#ifdef HPEC
      MIGRATE(&ctime);
      REMOTE_ADD(compute_ptr, ctime + CLOCK());
#endif
    }
  }
}

void check(long nctr, long *pass)
{
  long *res = g_inptr;
  long bstart = nctr << g_lgE;
  long bend = (nctr + 1) << g_lgE;
  for (long i = bstart, j = nctr; i < bend; i++, j += NODELETS())
    if (res[j] != i + 1) { *pass = 0; break; }
}

long log2_val(long n)
{
  long r = 0;
  while (n >>= 1) r++;
  return r;
}

int main(int argc, char **argv)
{
  long smart = 1; long docheck = 1; // default smart, check results
  long profile = 0; // default none; 1 = startiming, 2 = hooks
  long lgP = log2_val(NODELETS());
  long lgN = lgP + 1; // two elts per nodelet
  long lgE = 1; // two elts per nodelet
  long lgR = 0; // 1 thread
  long lgC = 0; // 1 thread
  int c;
  while ((c = getopt(argc, argv, "sqp:n:R:C:")) != -1) {
    switch (c) {
    case 's': smart = 0; break; // -s means run in dumb mode
    case 'q': docheck = 0; break; // -q means quiet - no checking
    case 'p': profile = atol(optarg); break; // profile options
    case 'n': lgN = atol(optarg); break; // scale
    case 'R': lgR = atol(optarg); break; // remap threads
    case 'C': lgC = atol(optarg); break; // compute threads
    }
  }

  // small arrays: no remapping, one elt and one thread per nodelet
  if (lgN <= lgP) { smart = 0; lgE = 0; lgC = 0; lgR = 0; }
  else {
    lgE = lgN - lgP; // log2_val(epn);
    if (lgR > lgE) lgR = lgE; // max epn threads for remap
    if (lgC >= lgE) lgC = lgE - 1; // max threads for comparisons
    if (lgC < 0) lgC = 0; // min 1 thread
    if (lgR < 0) lgR = 0; // min 1 thread
  }
  
  long N = 1 << lgN;
  mw_replicated_init(&g_N, N);
  mw_replicated_init(&g_lgN, lgN);
  mw_replicated_init(&g_lgP, lgP);
  mw_replicated_init(&g_lgE, lgE);
  mw_replicated_init(&g_lgR, lgR);
  mw_replicated_init(&g_lgC, lgC);
  long *arr1 = mw_malloc1dlong(N);
  mw_replicated_init((long *)&g_inptr, (long)arr1); // input starts in arr1
  long *arr2 = mw_malloc1dlong(N);
  mw_replicated_init((long *)&g_outptr, (long)arr2); // output starts in arr2

  mw_replicated_init(&g_map_step, -1); // initial mapping is block
  mw_replicated_init(&g_map_stage, 0); // initial a (unused in block mapping)
  for (long i = 0; i < N; i++) {
    long ind = block_to_cyclic(i, lgE, lgP);
    arr1[ind] = N - i;
  }

#ifdef HPEC
  long r_ticks = 0; long c_ticks = 0;
  mw_replicated_init((long *)&remap_ptr, (long)&r_ticks);
  mw_replicated_init((long *)&compute_ptr, (long)&c_ticks);
#endif

  long P = 1 << lgP;
  long R = 1 << lgR;
  long C = 1 << lgC;

  volatile long total_ticks;
  if (profile == 1) { starttiming(); total_ticks = -CLOCK(); }
  if (profile == 2) {
    hooks_set_attr_i64("Size", N);
    hooks_set_attr_i64("Scale", lgN);
    hooks_set_attr_i64("Remap", R);
    hooks_set_attr_i64("Compute", C);
    hooks_set_attr_i64("Smart", smart);
    hooks_set_attr_i64("Nodelets", P);
    hooks_region_begin("bitonicsort");
  }

  globalsort(lgE, lgN, lgP, smart);

  if (profile == 2) hooks_region_end();
  if (profile == 1) {
    MIGRATE(&total_ticks);
    total_ticks += CLOCK();
    double time_ms = (total_ticks) / (175.0 * 1e3);
    printf("{\"Size\":%ld,\"Scale\":%ld,\"Remap\":%ld,\"Compute\":%ld,\"Smart\":%ld,\"Nodelets\":%ld,\"time_ms\":%3.2f,\"ticks\":%ld}\n",
	   N, lgN, R, C, smart, P, time_ms, total_ticks);
    fflush(stdout);
  }

#ifdef HPEC
  if ((profile == 1) || (profile == 2)) {
    printf("{\"Size\":%ld,\"Scale\":%ld,\"Remap\":%ld,\"Compute\":%ld,\"Smart\":%ld,\"Nodelets\":%ld,\"Remap\":%ld,\"Compute\":%ld,\"Sum\":%ld}\n",
	   N, lgN, R, C, smart, P, r_ticks, c_ticks, r_ticks + c_ticks);
  }
#endif

  if (docheck) {
#ifdef DEBUG
    long *res = g_inptr;
    for (long i = 0; i < N; i++) { // DEBUG does print
      long ind = block_to_cyclic(i, lgE, lgP);
      printf("%ld ", res[ind]);
    }
    printf("\n");
#endif
    long pass = 1;
    long lim = MIN(N, NODELETS());
    for (long i = 0; i < lim; i++) {
      long *sptr = mw_get_nth(&g_N, i);
      cilk_spawn_at (sptr) check(i, &pass);
    }
    cilk_sync;
    printf("Size %ld Scale %ld Remap %ld Compute %ld Smart %ld Nodelets %ld ",
	   N, lgN, R, C, smart, P);
    if (pass) printf("PASS\n"); else printf("FAIL\n");
  }
  return 0;
}
