#!/usr/bin/env python
import random
import time

start_time = time.time()
random.seed()

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
    
for i in range(25,29):
    gen = genl(2**i)
    gen.send(None)
    f = 'dataset'
    f1 = str(2**i)
    filename = f + f1 

    with open(filename, "w") as f:
        for i in gen:
            f.write(str(i) + '\n')
    
    print("--- %s seconds ---" % (time.time() - start_time))
