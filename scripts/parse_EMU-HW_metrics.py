import sys
import os

'''
    Author: Thomas Rolinger (tbrolin@cs.umd.edu)
    Date: 4/27/2018

    Parses the output from the EMU (hardware) code. What we're gathering are the
    total cycles. This script will average these values for each data set and produce 
    an output CSV of the form:

    NUM ELEMENTS, TOTAL CYCLES

    The arguments to the script are the following:

    1.) top-level directory of the output to parse. For example, 
        output_data/ which will contain small/, medium/ and large/

    2.) The name of the output CSV file

    usage: python parse_EMU-HW_metrics.py output_data/ myOutput.csv
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
    fOut.write("NUM ELEMENTS,TOTAL CYCLES\n")
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
                # Parse each file
                for trialFile in trialFiles:
                    try:
                        fTrial = open(trialFile, "r")
                        lines = fTrial.readlines()
                        fTrial.close()
                        # Get total cycles
                        TOT_CYC += [int(line.split("TOTAL CYCLES:")[1].strip()) for line in lines if "TOTAL CYCLES:" in line][0]
                    except Exception, e:
                        print("**** FAILED to process file %s" %trialFile)
                        print("\t%s" %str(e))
                # Output data to CSV
                fOut.write("%d,%d\n" %(int(numElements), int(TOT_CYC/numFiles)))
    fOut.close()
