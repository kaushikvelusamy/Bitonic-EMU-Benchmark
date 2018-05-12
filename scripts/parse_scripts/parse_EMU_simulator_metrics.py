import sys
import os

'''
    Author: Thomas Rolinger (tbrolin@cs.umd.edu)
    Date: 4/30/2018

    Parses the output from the EMU (simulator) code, both dynamic and network verisons.
    The network version has more subdirectories (nodes, threads), so it requires a 
    different approach
 
    We gather the total cycles (same format as the hardware results) as well as thread creations and migrations.
    We can also get the simulator wall clock time
    The parsed output format will look like this:

    PLATFORM, SORT TYPE, NUM ELEMENTS, NUM NODES, NUM THREADS, TOTAL CYCLES, TOTAL THREADS CREATED, TOTAL THREAD MIGRATIONS, SIM WALL CLOCK TIME(s)

    For the network code, we use two columns: NUM NODES and NUM THREADS. These
    are empty for the dynamic code (set to -1)

    To get the specific values for threads created/migrated on a per-node basis,
    you'll need to look at the files yourself.

    The arguments to the script are the following:

    1.) top-level directory of the output to parse.

    3.) The type of executable: dynamic or network

    3.) The name of the output CSV file

    usage: python parse_EMU_simulator_metrics.py output_data/ dynamic-or-network myOutput.csv
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
def getSimWallClock(resFile):
    SIM_WALL = 0
    try:
        fcdc = open(resFile, "r")
        lines = fcdc.readlines()
        fcdc.close()
        # Get Sim wall clock time (seconds)
        SIM_WALL = [int(line.split("Simulator wall clock time (seconds):")[1].strip()) for line in lines if "Simulator wall clock time (seconds):" in line][0]
        return SIM_WALL
    except Exception, e:
        print("**** FAILED to process file %s" %resFile)
        print("\t%s" %str(e))
        return -99

##################################################################################################
def getThreadInfo(resFile):
    THREAD_CREATE = 0
    THREAD_MIGRATE = 0
    try:
        fvsf = open(resFile, "r")
        lines = fvsf.readlines()
        fvsf.close()
        # Get thread migrations
        THREAD_MIGRATE = sum([int(line.split("num migrates, ")[1].strip()) for line in lines if "num migrates, " in line])
        # Get thread creations
        THREAD_CREATE = sum([int(line.split("num_spawns=")[1].strip().split(",")[0]) for line in lines if "num_spawns=" in line])
        return THREAD_MIGRATE, THREAD_CREATE
    except Exception, e:
        print("**** FAILED to process file %s" %resFile)
        print("\t%s" %str(e))
        return -99,-99

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
        # Parse file to get cycle counts
        #
        resFile = subDir + "/" + "%selements.out" %numElements
        TOT_CYC = getCycles(resFile)
        #
        # Parse cdc file to get simulator wall clock time
        #
        cdcFiles = ["%s/cdc/%s" %(subDir,f) for f in os.listdir(subDir+"/cdc") if os.path.isfile(os.path.join(subDir+"/cdc", f))]
        cdcFile = subDir + "/cdc/" + "%selements.cdc" %numElements
        SIM_WALL = getSimWallClock(cdcFile)
        #
        # Parse vsf file to get thread creations and migrations
        #
        vsfFiles = ["%s/vsf/%s" %(subDir,f) for f in os.listdir(subDir+"/vsf") if os.path.isfile(os.path.join(subDir+"/vsf", f))]
        vsfFile = subDir + "/vsf/" + "%selements.vsf" %numElements
        THREAD_MIGRATE, THREAD_CREATE = getThreadInfo(vsfFile)
        # Output results
        fOut.write("SIMULATOR,DYNAMIC,%d,-1,-1,%d,%d,%d,%d\n" %(int(numElements), TOT_CYC, THREAD_CREATE, THREAD_MIGRATE, SIM_WALL))

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
                # Parse cdc file to get simulator wall clock time
                #
                cdcFiles = ["%s/cdc/%s" %(dataDir,f) for f in os.listdir(dataDir+"/cdc") if os.path.isfile(os.path.join(dataDir+"/cdc", f))]
                cdcFile = dataDir + "/cdc/" + "%selements_%snodes_%sthreads.cdc" %(numElements, numNodes, numThreads)
                SIM_WALL = getSimWallClock(cdcFile)
                #
                # Parse vsf file to get thread creations and migrations
                #
                vsfFiles = ["%s/vsf/%s" %(dataDir,f) for f in os.listdir(dataDir+"/vsf") if os.path.isfile(os.path.join(dataDir+"/vsf", f))]
                vsfFile = dataDir + "/vsf/" + "%selements_%snodes_%sthreads.vsf" %(numElements, numNodes, numThreads)
                THREAD_MIGRATE, THREAD_CREATE = getThreadInfo(vsfFile)
                
                # Update results
                resDict[int(numElements)][(int(numNodes),int(numThreads))] = ["SIMULATOR","NETWORK", int(numElements), numNodes, numThreads, TOT_CYC, THREAD_CREATE, THREAD_MIGRATE, SIM_WALL]

    # Output the results in a reason order
    NODES.sort()
    THREADS.sort()
    ELEMENTS.sort()
    try:
        for e in ELEMENTS:
            for n in NODES:
                for t in THREADS: 
                    for i in range(0, len(resDict[e][(n,t)])-1):
                        fOut.write("%s," %str(resDict[e][(n,t)][i]))
                    fOut.write("%s\n" %str(resDict[e][(n,t)][-1]))
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
    fOut.write("PLATFORM,SORT TYPE,NUM ELEMENTS,NUM NODES,NUM THREADS,TOTAL CYCLES,TOTAL THREADS CREATED,TOTAL THREAD MIGRATIONS,SIM WALL CLOCK TIME (s)\n")
    
    # Depending on the sort type, we have different parsing to do
    if(sortType == "DYNAMIC"):
        parseDynamicSort(topDir, fOut)
    else:
        parseNetworkSort(topDir, fOut)

    print("#### DONE ####")
