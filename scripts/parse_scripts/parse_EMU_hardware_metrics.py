import sys
import os

'''
    Author: Thomas Rolinger (tbrolin@cs.umd.edu)
    Date: 4/30/2018

    Parses the output from the EMU (hardware) code, both dynamic and network verisons.
    The network version has more subdirectories (nodes, threads), so it requires a 
    different approach
 
    We gather the total cycles and wall clock time
    The parsed output format will look like this:

    SORT TYPE, NUM ELEMENTS, NUM NODES, NUM THREADS, TOTAL CYCLES, WALL CLOCK TIME(s)

    For the network code, we use two columns: NUM NODES and NUM THREADS. These
    are empty for the dynamic code (set to -1)

    The arguments to the script are the following:

    1.) top-level directory of the output to parse.

    3.) The type of executable: dynamic or network

    3.) The name of the output CSV file

    usage: python parse_EMU_hardware_metrics.py output_data/ dynamic-or-network myOutput.csv
'''
##################################################################################################
def getCycles(resFile):
    TOT_CYC = 0
    try:
        fFile = open(resFile, "r")
        lines = fFile.readlines()
        fFile.close()
        # Get total cycles
        TOT_CYC = [int(line.split("TOTAL CYCLES:")[1].strip()) for line in lines if "TOTAL CYCLES:" in line][0]
        return TOT_CYC
    except Exception, e:
        print("**** FAILED to process file %s" %resFile)
        print("\t%s" %str(e))
        return -99

##################################################################################################
def getWallClock(resFile):
    WALL = 0
    try:
        f = open(resFile, "r")
        lines = f.readlines()
        f.close()
        # Get wall clock time (seconds)
        # Find the line that has "real"
        for line in lines:
            if "real" in line:
                # Get minutes
                mins = int(line.split("real")[-1].strip().split("m")[0])
                # Get seconds
                secs = int(line.split("m")[-1].strip().split(".")[0].strip())
                # get total secs
                WALL = 60*mins + secs
        return WALL
    except Exception, e:
        print("**** WALL FAILED to process file %s" %resFile)
        print("\t%s" %str(e))
        return -99

##################################################################################################
def parseDynamicSort(topDir, fOut):
    # Get the subdirs in the top level dir.
    subDirs = getSubDirs(topDir)
    subDirs.sort(key=lambda x: int(x.split("_")[0]))
    subDirs = [os.path.join(topDir, subDir) for subDir in subDirs]

    for subDir in subDirs:
        # Get the number of elements
        numElements = subDir.split("/")[-1].strip().split("_")[0]

        #
        # Parse file to get cycle counts and wall clock time
        #
        resFile = subDir + "/" + "%selements.out" %numElements
        TOT_CYC = getCycles(resFile)
        WALL_TIME = getWallClock(resFile)
        
        # Output results
        fOut.write("DYNAMIC,%d,-1,-1,%d,%d\n" %(int(numElements), TOT_CYC, WALL_TIME))

    fOut.close()

##################################################################################################
def parseNetworkSort(topDir, fOut):
    # We construct a dictionary of the results.
    # The keys are data set sizes.
    # The values are another dictionary that contain the results for the various node/thread
    # counts
    resDict = {}

    # keeps track of number of elements, threads and nodes we used
    ELEMENTS = []
    NODES= []
    THREADS = []

    # Get the subdirs in the top level dir. These will be 1nodes, 2nodes, 4nodes, 8nodes
    subDirs = getSubDirs(topDir)
    # Sort the dirs by node counts
    subDirs.sort(key=lambda x: int(x.split("nodes")[0]))
    subDirs = [os.path.join(topDir, subDir) for subDir in subDirs]

    # For each of the node dirs
    for nodeDir in subDirs:
        # Within here, we have dirs for each thread count
        threadDirs = getSubDirs(nodeDir)
        # Sort the dirs by thread counts
        threadDirs.sort(key=lambda x: int(x.split("threads")[0]))
        threadDirs = [os.path.join(nodeDir, threadDir) for threadDir in threadDirs]
    
        # Get the number of nodes
        numNodes = nodeDir.split("/")[-1].strip().split("nodes")[0]        
        if int(numNodes) not in NODES:
            NODES.append(int(numNodes))

        # For each thread dir
        for threadDir in threadDirs:
            # Get number of threads
            numThreads = threadDir.split("/")[-1].strip().split("threads")[0]
            if int(numThreads) not in THREADS:
                THREADS.append(int(numThreads))
            # Here we have dirs for each data set we ran on
            dataDirs = getSubDirs(threadDir)
            # Sort the dirs by element counts
            dataDirs.sort(key=lambda x: int(x.split("_elements")[0]))
            dataDirs = [os.path.join(threadDir, dataDir) for dataDir in dataDirs]
            # Now, we can parse the files like we do in parseDynamicSort
            for dataDir in dataDirs:
                # Get the number of elements
                numElements = dataDir.split("/")[-1].strip().split("_")[0]
                if int(numElements) not in resDict:
                    resDict[int(numElements)] = {}
                if int(numElements) not in ELEMENTS:
                    ELEMENTS.append(int(numElements))
                #
                # Parse file to get cycle counts
                #
                resFile = dataDir + "/" + "%selements_%snodes_%sthreads.out" %(numElements, numNodes, numThreads)
                TOT_CYC = getCycles(resFile)
                #
                # Parse file to get wall clock time
                WALL_TIME = getWallClock(resFile)
                #
                
                # Update results
                resDict[int(numElements)][(int(numNodes),int(numThreads))] = ["NETWORK", int(numElements), numNodes, numThreads, TOT_CYC, WALL_TIME]

    # Output the results in a reason order
    NODES.sort()
    THREADS.sort()
    ELEMENTS.sort()
    try:
        for e in ELEMENTS:
            for n in NODES:
                for t in THREADS: 
                    for m in resDict[e][(n,t)]:
                        fOut.write("%s," %str(m))
                    fOut.write("\n")
    except Exception, e:
        print("**** FAILED to write out result")
        print("\t%s" %str(e))
    
    fOut.close()

##################################################################################################
def getSubDirs(myDir):
    return [name for name in os.listdir(myDir) if os.path.isdir(os.path.join(myDir, name))]

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("usage: python %s <output directory> <dynamic or network> <output file name>" %sys.argv[0])
        sys.exit(-1)

    # First arg is top-level directory
    topDir = sys.argv[1]
    if topDir[-1] == '/':
        topDir = topDir[:-1]

    # second arg is type
    sortType = sys.argv[2].upper()
    if sortType not in ["DYNAMIC", "NETWORK"]:
        print("usage: python %s <output directory> <dynamic or network> <output file name>" %sys.argv[0])
        sys.exit(-1)

    # Third arg is output file
    outFile = sys.argv[3]

    # Create the output file.
    fOut = open(outFile, "w")

    # Write out header. 
    fOut.write("SORT TYPE,NUM ELEMENTS,NUM NODES,NUM THREADS,TOTAL CYCLES,WALL CLOCK TIME (s)\n")  
  
    # Depending on the sort type, we have different parsing to do
    if(sortType == "DYNAMIC"):
        parseDynamicSort(topDir, fOut)
    else:
        parseNetworkSort(topDir, fOut)

    print("#### DONE ####")
