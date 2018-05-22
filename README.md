
# Bitonic-EMU-Benchmark
Implementation of the parallel bitonic sort on the EMU machine


# Updates on the Current Work
* bitonic_CPU_iterative.c and bitonic_dynamic.c .  

	Implemented a CPU-based version of bitonic sort that is parallelized via Cilk. This will give a reference, that we can possibly compare the EMU code [**bitonic_dynamic.c]** to CPU based cilk version **[bitonic_CPU_iterative.c]** of the bitonic sort. As they both use Cilk, the underlying structure of the algorithm and execution will be identical (i.e., they will both create the same number of threads, etc.).
* Profililing the  CPU based cilk version **[bitonic_CPU_iterative.c]** of the bitonic sort using PAPI. We gathered the cycle counts as well as cache misses. We do a more or less one-to-one comparison of the cycle counts between the CPU and EMU code. The cache misses can be loosely compared to the thread migrations.
* Make sure the EMU code **[bitonic_dynamic.c]** is fairly optimized. We are currently not looking to micro-tune every line of code but we want to make sure that things are done in a reasonable way and we aren't doing anything that could kill performance and be easily fixed. Here, we are doing a simply round-robin approach [mw_malloc1dlong].
* Explored the different data layouts for the input array that is to be sorted in the **bitonic_network.c** . Here we are experimenting with different blocking strategies, where we put chunks of adjacent elements on each nodelet. Here we analysed the Blocked Data Layout Strategy and the Cyclic Data Layout Strategy from "Optimizing Parallel Bitonic Sort by Mihai Florin Ionescu and Klaus E. Schauser".
* For now, we are focusing on single-node execution. We will be analyzing the stability of the multi-node execution later.
In any case, there shouldn't be a difference between the code that runs on 1 node or 8 nodes. We are leaving out the Smart Data Layout Strategy for the future work.


# To generate the random numbers for input

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


