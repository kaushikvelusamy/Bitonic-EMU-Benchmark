
# Bitonic-EMU-Benchmark
Implementation of the parallel bitonic sorting algorithm on the EMU architecture

# Overview

Large scale, data-intensive applications pose challenges to systems with a traditional memory hierarchy due to their unstructured data sources and irregular memory access patterns. In response, systems that employ migratory threads have been proposed to mitigate memory access bottlenecks as well as reduce energy consumption. One such system is the Emu Chick, which migrates a small program context to the data being referenced in a memory access. Sorting an unordered list of elements is a critical kernel for countless applications, such as graph processing and tensor decomposition. As such applications can be considered highly suitable for a migratory thread architecture , it is imperative to understand the performance of sorting algorithms on these systems.

We implemented different parallel bitonic sorting algorithms and targeted the EMU system. We investigate the performance of these algorithms on,
* EMU simulator Vs EMU hardware, 
* Cyclic Vs Blocked data layouts, 
* Single node Vs Multinode hardware configurations.


# Publication:

Kaushik Velusamy, Thomas B. Rolinger, Janice Mcmahon and Tyler A. Simon, "Exploring Parallel Bitonic Sort on a Migratory Thread Architecture," 2018 IEEE High Performance Extreme Computing Conference (HPEC ‘18)At: Waltham, MA. DOI: 10.1109/HPEC.2018.8547568

https://www.researchgate.net/publication/328102159_Exploring_Parallel_Bitonic_Sort_on_a_Migratory_Thread_Architecture






# Source Files

1_CPU_iterative
2_CPU_recursive
3_EMU_iterative
4_EMU_recursive
5_EMU_dynamic
6_EMU_network_seq
7_EMU_network
8_EMU_smart


* [**bitonic_EMU_iterative.c]** Follows Comparison based approach. This is an iterative implementation of the parallel bitonic sort for EMU.This is called "dynamic" because it spawns threads as it needs them.  The implementation has sparate cylic and blocked data layouts.



*   [**bitonic_EMU_network.c]** The network version follows the Sorting network based approach and use a fixed number of nodelets and threads. The implementation has sparate cylic and blocked data layouts.

* Implemented a CPU-based version of bitonic sort that is parallelized via Cilk. This will give a reference, that we can possibly compare the EMU code [**bitonic_EMU_dynamic.c]** to CPU based cilk version **[bitonic_CPU_iterative.c]** of the bitonic sort. As they both use Cilk, the underlying structure of the algorithm and execution will be identical (i.e., they will both create the same number of threads, etc.).
* Profililing the  CPU based cilk version **[bitonic_CPU_iterative.c]** of the bitonic sort using PAPI. We gathered the cycle counts as well as cache misses. We do a more or less one-to-one comparison of the cycle counts between the CPU and EMU code. The cache misses can be loosely compared to the thread migrations.
* Make sure the EMU code **[bitonic_EMU_dynamic.c]** is fairly optimized. We are currently not looking to micro-tune every line of code but we want to make sure that things are done in a reasonable way and we aren't doing anything that could kill performance and be easily fixed. Here, we are doing a simply round-robin approach [mw_malloc1dlong].
* Explored the different data layouts for the input array that is to be sorted in the **bitonic_EMU_network.c** . Here we are experimenting with different blocking strategies, where we put chunks of adjacent elements on each nodelet. Here we analysed the Blocked Data Layout Strategy and the Cyclic Data Layout Strategy from "Optimizing Parallel Bitonic Sort by Mihai Florin Ionescu and Klaus E. Schauser".
* For now, we are focusing on single-node execution. We will be analyzing the stability of the multi-node execution later.
In any case, there shouldn't be a difference between the code that runs on 1 node or 8 nodes. We are leaving out the Smart Data Layout Strategy for the future work.


# To generate the random numbers for input

check generate_dataset_scripts directory

```
python generate_random_numbers.py 1 10 ../../dataset
```

For Bitonic Sort, the number of input to be sorted should always be a power of 2.
The first line in the input file generated will be the total number of elements in the file.
The above command will create the input files from 2^1 till 2^10 in the `dataset` folder



# To compile the EMU program

Run one of the following MAKE commands according to your need.

```
make all	To compile both bitonic_dynamic.c and bitonic_network.c file made to run in hardware
make SIM=1	
make DEBUG=1
make CYCLIC=1	if this is defined, the bitonic_network.c code will be compiled for Cyclic Data Layout else Blocked Data Layout
```


The output file `bitonic_dynamic.mwx` and `bitonic_network.mwx` will be generated in the same folder folder


# To Run the program in the simulator for single input

For the dynamic threads version
```
emusim.x --core_clk_mhz 150 --capture_timing_queues --gcs_per_nodelet 1 -o outputfilename bitonic_dynamic.mwx --  -b -f inputFiles
```
For the sorting network version
```
emusim.x --core_clk_mhz 150 --capture_timing_queues --gcs_per_nodelet 1 -o outputfilename bitonic_dynamic.mwx -- -b -f -n NUMNODES -t NUMTHREADS inputFile
```

The output will be displayed on the screen, based on the mode of the MAKE. The cdc and vsf files will be generated in the current folder.

# To Run the program in the Hardware for single input

For the dynamic threads version
```
emu_handler_and_loader 0 0 bitonic_dynamic.mwx -- -b -f inputFile
```

For the sorting network version
```
emu_handler_and_loader 0 0 bitonic_dynamic.mwx -- -b -f -n NUMNODES -t NUMTHREADS inputFile
```

# The Benchmark scripts

The runTests_EMU.sh will gather the metrics on the HW/SIM at the outputDir.

# To Run the program in the simulator for multiple input files

For the dynamic threads version
```
./runTests_EMU_dynamic.sh --exe=bitonic_dynamic.mwx --mode=SIM --datasetDir=pathToIPDataFolder
```
For the sorting network version
```
./runTests_EMU_network.sh --exe=bitonic_network.mwx --mode=SIM --datasetDir=pathToIPDataFolder
```
# To Run the program in the Hardware for multiple input files

For the dynamic threads version
```
./runTests_EMU_dynamic.sh --exe=bitonic_dynamic.mwx --mode=HW --datasetDir=pathToIPDataFolder
```
For the sorting network version
```
./runTests_EMU_network.sh --exe=bitonic_network.mwx --mode=HW --datasetDir=pathToIPDataFolder
```


# To Run the parsing scripts to generate the CSV file from the output Folder

check generate_dataset_scripts directory

For Simulator : dynamic threads version
```    
    python parse_EMU_simulator_metrics.py output_data/ dynamic myOutput.csv
```
For Simulator : sorting network version
```
    python parse_EMU_simulator_metrics.py output_data/ network myOutput.csv
```

For Hardware : dynamic threads version
```
    python parse_EMU_hardware_metrics.py output_data/ dynamic myOutput.csv
```
For Simulator : sorting network version
```
    usage: python parse_EMU_hardware_metrics.py output_data/ network myOutput.csv
```

# To compile the CPU cilk program 

Run one of the following MAKE commands according to your need.

```
make all	
make DEBUG=1
make TIMING=1
```
# To RUN the CPU cilk program 

```
./runTests_CPU.sh [--datasetDir=DATASETDIR] [--outputDir=OUTPUTDIR]
```

The dataset Directory should have 3 folders as below

dataset/

&nbsp;&nbsp;&nbsp;&nbsp; small/ 

&nbsp;&nbsp;&nbsp;&nbsp; medium/

&nbsp;&nbsp;&nbsp;&nbsp; large/


