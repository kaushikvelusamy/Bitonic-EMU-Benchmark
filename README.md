# Bitonic-EMU-Benchmark
Implementation of the parallel bitonic sort on the EMU machine

# Current Work
* Implement a CPU-based version of bitonic sort that is parallelized via Cilk. This will
give us a reference that we can possibly compare the EMU code to. As they both use Cilk,
the underlying structure of the algorithm and execution will be identical (i.e., they will
both create the same number of threads, etc.).
* Profile the CPU-based code using PAPI. We will gather cycle counts as well as cache misses.
We can do a more or less one-to-one comparison of the cycle counts between the CPU and EMU
code. The cache misses can be loosely compared to the thread migrations.
* Make sure EMU code is fairly optimized. We don't need to micro-tune every line of code but
we want to make sure that things are done in a reasonable way and we aren't doing anything
that could kill performance and be easilt fixed.
* Investigate different data layouts for the input array that is to be sorted. Right now,
we are doing a simply round-robin approach. We can experiment with different blocking strategies,
where we put chunks of adjacent elements on each nodelet. I think there should be a rather
straightforward "calculation" to determine the optimal block size to use depending on the input
size. I will try to think about this more, but we can also just sweep over the different block
sizes and look at the results.
* For now, we should focus on single-node execution. I am not sure how stable the multi-node
stuff is, so it's best to stick with what we know works. We can look towards multi-node afterwards.
In any case, there shouldn't be a difference between the code that runs on 1 node or 8 nodes.
