import sys
import os

'''
    Author: Thomas Rolinger (tbrolin@cs.umd.edu)
    Date: 4/30/2018

    Parses the output from the EMU (simulator) code. We gather the total cycles
    (same format as the hardware results) as well as thread creations and migrations.
    We can also get the simulator wall clock time
    The parsed output format will look like this:

    NUM ELEMENTS, TOTAL CYCLES, TOTAL THREADS CREATED, TOTAL THREAD MIGRATIONS, SIM WALL CLOCK TIME

    To get the specific values for threads created/migrated on a per-node basis,
    you'll need to look at the files yourself.

    The arguments to the script are the following:

    1.) top-level directory of the output to parse. For example, 
        output_data/ which will contain small/ (only this directory since
        we don't bother trying to simulate the larger data sets)

    2.) The name of the output CSV file

    usage: python parse_EMU-SIM_metrics.py output_data/ myOutput.csv
'''

def getSubDirs(myDir):
    return [name for name in os.listdir(myDir) if os.path.isdir(os.path.join(myDir, name))]

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("usage: python %s <output directory> <output file name>" %sys.argv[0])
        sys.exit(-1)

    # First arg is top-level directory
    topDir = sys.argv[1]
    if topDir[-1] == '/':
        topDir = topDir[:-1]
    # Second arg is output file
    outFile = sys.argv[2]

    # Create the output file.
    fOut = open(outFile, "w")

    # Write out header. 
    fOut.write("NUM ELEMENTS,TOTAL CYCLES,TOTAL THREADS CREATED,TOTAL THREAD MIGRATIONS,SIM WALL CLOCK TIME\n")
    # Get the subdirs in the top level dir. This should only be small/
    subDirs = getSubDirs(topDir)
    subDirs = [os.path.join(topDir, subDir) for subDir in subDirs]
    
    # For each subdir (again, should only be 1)
    for subDir in subDirs:
        # Within here, we have directories for each data set (number of elements)
        dataSets = getSubDirs(subDir)
        dataSets.sort(key=lambda x: int(x))
        dataSets = [os.path.join(subDir, dataSet) for dataSet in dataSets]
        # Now parse files in each data set
        for dataSet in dataSets:
            # Get the number of elements
            numElements = dataSet.split("/")[-1].strip()
            
            #
            # Parse trial file to get cycle counts
            #
            # Get trial files. This are called numElements_trial1.out
            trialFile = dataSet + "/" + "%s_trial1.out" %numElements
            TOT_CYC = 0
            try:
                fTrial = open(trialFile, "r")
                lines = fTrial.readlines()
                fTrial.close()
                # Get total cycles
                TOT_CYC = [int(line.split("TOTAL CYCLES:")[1].strip()) for line in lines if "TOTAL CYCLES:" in line][0]
            except Exception, e:
                print("**** FAILED to process file %s" %trialFile)
                print("\t%s" %str(e))
            
            #
            # Parse cdc file to get simulator wall clock time
            #
            cdcFiles = ["%s/cdc/%s" %(dataSet,f) for f in os.listdir(dataSet+"/cdc") if os.path.isfile(os.path.join(dataSet+"/cdc", f))]
            cdcFile = dataSet + "/cdc/" + "%s_trial1.cdc" %numElements
            SIM_WALL = 0
            try:
                fcdc = open(cdcFile, "r")
                lines = fcdc.readlines()
                fcdc.close()
                # Get Sim wall clock time (seconds)
                SIM_WALL = [int(line.split("Simulator wall clock time (seconds):")[1].strip()) for line in lines if "Simulator wall clock time (seconds):" in line][0]
            except Exception, e:
                print("**** FAILED to process file %s" %cdcFile)
                print("\t%s" %str(e))
            
            
            #
            # Parse vsf file to get thread creations and migrations
            #
            vsfFiles = ["%s/vsf/%s" %(dataSet,f) for f in os.listdir(dataSet+"/vsf") if os.path.isfile(os.path.join(dataSet+"/vsf", f))]
            vsfFile = dataSet + "/vsf/" + "%s_trial1.vsf" %numElements
            THREAD_CREATE = 0
            THREAD_MIGRATE = 0
            try:
                fvsf = open(vsfFile, "r")
                lines = fvsf.readlines()
                fvsf.close()
                # Get thread migrations
                THREAD_MIGRATE = sum([int(line.split("num migrates, ")[1].strip()) for line in lines if "num migrates, " in line])
                # Get thread creations
                THREAD_CREATE = sum([int(line.split("num_spawns=")[1].strip().split(",")[0]) for line in lines if "num_spawns=" in line])
            except Exception, e:
                print("**** FAILED to process file %s" %cdcFile)
                print("\t%s" %str(e))

            # Output results
            fOut.write("%d,%d,%d,%d,%d\n" %(int(numElements), TOT_CYC, THREAD_CREATE, THREAD_MIGRATE, SIM_WALL))

    fOut.close()
