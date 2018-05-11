#!/usr/bin/env python
import random
import time
import struct
import sys

start_time = time.time()
random.seed(123456)

# 2 power 30 is "1073741824". For bitonic sort the Total number of elements (size) of the input should be a power of 2

#Range of each element can be from 0 to element_range
element_range = 2147483648  
#Total Number of elements to be created
#tot_num_elements = 128
#The output is stored in this file
filename = "dataset" 

def genl (max):
    cur = 0
    while cur <= max:
        yield random.randint(0, element_range)
        cur = cur + 1
    
if(len(sys.argv) != 4):
    print("usage: %s <log2(start)> <log2(end)> <out-dir>" %sys.argv[0])
    sys.exit(-1)

start = int(sys.argv[1])
end = int(sys.argv[2])
outdir = sys.argv[3]

for i in range(start,end+1):
    gen = genl(2**i)
    gen.send(None)
    f = 'dataset'
    f1 = str(2**i)
    filename = outdir + "/" + f + f1 + ".dat"

    print("+ Generating %d numbers..." %2**i)
    with open(filename, "wb") as f:
        f.write(struct.pack('l', 2**i))
        for i in gen:
            f.write(struct.pack('l', i))
    
    print("\t--- %s seconds ---\n" % (time.time() - start_time))
