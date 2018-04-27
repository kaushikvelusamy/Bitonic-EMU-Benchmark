import sys
import os

'''
    Author: Thomas Rolinger (tbrolin@cs.umd.edu)
    Date: 4/27/2018

    Parses the output from the CPU code. What we're gathering are the
    total cycles and various cache load misses. This script will average
    these values for each data set and produce an output CSV of the form:

    NUM ELEMENTS, TOTAL CYCLES, L1 LDM, L2 LDM, L3 LDM

    The arguments to the script are the following:

    1.) top-level directory of the output to parse. For example, 
        output_data/ which will contain small/, medium/ and large/

    2.) The name of the output CSV file

    usage: python parse_CPU_metrics.py output_data/ myOutput.csv
'''

def getSubDirs(myDir):
    return [name for name in os.listdir(myDir) if os.path.isdir(os.path.join(myDir, name))]

if __name__ == "__main__":
    # First arg is top-level directory
    topDir = sys.argv[1]
    if topDir[-1] == '/':
        topDir = topDir[:-1]
    # Second arg is output file
    outFile = sys.argv[2]

    # Create the output file.
    fOut = open(outFile, "w")

    # Write out header. 
    fOut.write("NUM ELEMENTS,TOTAL CYCLES,L1 LDM,L2 LDM,L3 LDM\n")
    # Get the subdirs in the top level dir. These should be the small, medium, large.
    # We want to order them as small, medium, large (happens to be reverse alphabetical)
    subDirs = getSubDirs(topDir)
    subDirs.sort(reverse=True)
    subDirs = [os.path.join(topDir, subDir) for subDir in subDirs]
    
    # For each subdir
    for subDir in subDirs:
        # Within here, we have directories for each data set (number of elements)
        dataSets = getSubDirs(subDir)
        dataSets.sort(key=lambda x: int(x))
        dataSets = [os.path.join(subDir, dataSet) for dataSet in dataSets]
        # Now parse files in each data set
        for dataSet in dataSets:
            # Get the number of elements
            numElements = dataSet.split("/")[-1].strip()
            # Get trial files
            trialFiles = ["%s/%s" %(dataSet,f) for f in os.listdir(dataSet) if os.path.isfile(os.path.join(dataSet, f))] 
            # Get number of trial files
            numFiles = len(trialFiles)
            # If no files, skip
            if numFiles != 0:
                TOT_CYC = 0.0
                L1_LDM = 0.0
                L2_LDM = 0.0
                L3_LDM = 0.0
                # Parse each file
                for trialFile in trialFiles:
                    try:
                        fTrial = open(trialFile, "r")
                        lines = fTrial.readlines()
                        fTrial.close()
                        # Get total cycles
                        TOT_CYC += [int(line.split("TOTAL CYCLES:")[1].strip()) for line in lines if "TOTAL CYCLES:" in line][0]
                        # Get cache load misses
                        L1_LDM += [int(line.split("L1 LOAD MISSES:")[1].strip()) for line in lines if "L1 LOAD MISSES:" in line][0]
                        L2_LDM += [int(line.split("L2 LOAD MISSES:")[1].strip()) for line in lines if "L2 LOAD MISSES:" in line][0] 
                        L3_LDM += [int(line.split("L3 LOAD MISSES:")[1].strip()) for line in lines if "L3 LOAD MISSES:" in line][0]
                    except Exception, e:
                        print("**** FAILED to process file %s" %trialFile)
                        print("\t%s" %str(e))
                # Output data to CSV
                fOut.write("%d,%d,%d,%d,%d\n" %(int(numElements), int(TOT_CYC/numFiles), int(L1_LDM/numFiles), int(L2_LDM/numFiles), int(L3_LDM/numFiles)))
                


    fOut.close()
