
# Bitonic-EMU-Benchmark
Implementation of the parallel bitonic sort on the EMU machine

# To generate the random numbers for input

```
python generate_random_numbers.py 1 10 ../dataset/small
```

For Bitonic Sort, the number of input to be sorted should always be a power of 2.
The first line in the input file generated will be the total number of elements in the file.

The above command will create the input files from 2^1 till 2^10 in the `dataset/small folder`

The dataset folder should have 3 sub folders as below
+ dataset/
   - small/ [This folder is Mandatory]
   - medium/
   - large/




# To compile the program

Run one of the following MAKE commands according to your need.

```
make DEBUG=1
make HARDWARE=1
make SIMULATOR=1
```


The output file `bitonic_EMU_iterative.mwx` will be generated in the `../../bin` folder


# To Run the program

```
emusim.x emufile.mwx <input_file>
```

For example, emufile.mwx could be `../bin/bitonic_EMU_iterative.mwx` and the 
input_file could be `../dataset/small/dataset8.dat`

The output will be displayed on the screen, based on the mode of the MAKE. The cdc and vsf files will be generated in the current folder.



# To Run the Benchmark Script

The runTests_EMU.sh will gather the metrics on the HW/SIM at the outputDir.

The bitonic_EMU_iterative.mwx file should/will be in the bin/ directory.

The dataset Directory should have 3 folders as below
+ dataset/
   - small/ [Only this folder will be used for the mode=SIM]
   - medium/
   - large/


To gather the metrics on the SIMULATOR, make sure the executable was built with make SIMULATOR=1 and then run

```
./runTests_EMU.sh --mode=SIM --datasetDir=/path/to/dataset --outputDir=/path/to/store/output
```



To gather the metrics on the HARDWARE, make sure the executable was built with make HARDWARE=1 and then run

```
./runTests_EMU.sh --mode=HW --datasetDir=/path/to/datasets --outputDir=/path/to/store/output
```


Each data set is ran 5 times and each trial's output is captured and stored in the output directory

```
output-data-TIME
	- small/
		- numElements/
			* output files for each trial
             		cdc/
             		vfs/
	-medium/
		......
	-large/
		......
```

# To Run the parsing scripts to generate the CSV file from the output Folder
The parsed output format will look like this:
    NUM ELEMENTS, TOTAL CYCLES, TOTAL THREADS CREATED, TOTAL THREAD MIGRATIONS, SIM WALL CLOCK TIME
    To get the specific values for threads created/migrated on a per-node basis,
    you'll need to look at the files yourself.
    The arguments to the script are the following:
    1.) top-level directory of the output to parse. For example, 
        output_data/ which will contain small/ (only this directory since
        we don't bother trying to simulate the larger data sets)
    2.) The name of the output CSV file

```
    usage: python parse_EMU-SIM_metrics.py output_data/ myOutput.csv
```

Parses the output from the EMU (hardware) code. What we're gathering are the
    total cycles. This script will average these values for each data set trials and produce 
    an output CSV of the form:
    NUM ELEMENTS, TOTAL CYCLES
    The arguments to the script are the following:
    1.) top-level directory of the output to parse. For example, 
        output_data/ which will contain small/, medium/ and large/
    2.) The name of the output CSV file

```
    usage: python parse_EMU-HW_metrics.py output_data/ myOutput.csv
```

# Updates on the Current Work
* Implemented a CPU-based version of bitonic sort that is parallelized via Cilk. This will give a reference, that we can possibly compare the EMU code to CPU based cilk version of the bitonic sort. As they both use Cilk, the underlying structure of the algorithm and execution will be identical (i.e., they will both create the same number of threads, etc.).
* Profililing the CPU-based code using PAPI. We gathered the cycle counts as well as cache misses. We do a more or less one-to-one comparison of the cycle counts between the CPU and EMU code. The cache misses can be loosely compared to the thread migrations.
* Make sure EMU code is fairly optimized. We are currently not looking to micro-tune every line of code but
we want to make sure that things are done in a reasonable way and we aren't doing anything that could kill performance and be easilt fixed.
* Investigating different data layouts for the input array that is to be sorted. Right now, we are doing a simply round-robin approach [mw_malloc1dlong]. We will be experimenting with different blocking strategies, where we put chunks of adjacent elements on each nodelet. We will be analyzing the straightforward "calculation" to determine the optimal block size to use depending on the inputsize. We will also analyse the different block sizes and study the results.
* For now, we are focusing on single-node execution. We will be analyzing the stability of the multi-node execution later.
In any case, there shouldn't be a difference between the code that runs on 1 node or 8 nodes.
