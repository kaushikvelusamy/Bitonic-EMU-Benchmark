'''
Run 
sh ./runTests_EMU.sh > outputfile.out 2>&1

Run 
sed -i '/STATUS/ d' outputfile.out 

Run 
python2.7 parsing1.py outputfile.out outputfile.csv
'''

import csv
import sys
inputfile = sys.argv[1]
outputfile = sys.argv[2]
#print inputfile, outputfile
final_arr = []
entry_arr = []
with open(inputfile) as outfile:
    for line_num,line in enumerate(outfile):
        #print line
        if line.startswith( 'time' ):
            final_arr.append(entry_arr)
            entry_arr = []
            time_arr = line.split()
            entry_arr.append(time_arr[1])
            entry_arr.append(time_arr[5])
            #print time_arr
        elif line.startswith('Total Remap Ticks'):
            remap_arr = line.split()
            entry_arr.append(long(remap_arr[-1]))
            #print remap_arr
        elif line.startswith('Total Time in'):
            total_arr = line.split()
            entry_arr.append(long(total_arr[-1]))
            entry_arr.append((float(remap_arr[-1]) / float(total_arr[-1])) * 100)
            #print total_arr
        elif line.startswith('Size'):
            size_arr = line.split()
            entry_arr.append(size_arr[3])
            entry_arr.append(size_arr[5])
            entry_arr.append(size_arr[7])
            entry_arr.append(size_arr[9])
            entry_arr.append(size_arr[11])
            #print size_arr

final_arr.append(entry_arr)
            
#print final_arr

heading_arr = [ 'SingleOrMulti', 'filename',
                'remap_ticks', 'total_ticks','remap_percentage',
                'scale', 'RemapThreads', 'ComparisonThreads', 'SmartOrDumb', 'Nodelets']

final_arr = [heading_arr] + final_arr

with open(outputfile, "wb") as f:
    writer = csv.writer(f)
    writer.writerows(final_arr)

