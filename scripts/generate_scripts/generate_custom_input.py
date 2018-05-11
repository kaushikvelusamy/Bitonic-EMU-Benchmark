#!/usr/bin/env python
# This program creates a custom inputs for the bitonic sort
# Just enter your filename in filename and elements in arr. 
# Make sure the first element is number of elements to be sorted  and remaining elements are the numbers that will be sorted. For example arr = [2,5,3] will sort 5 and 3


import random
import time
import struct
import sys

filename = "newdataset8" 
arr=[8,3,7,4,8,6,2,1,5]

start_time = time.time()
with open(filename, "wb") as f:
   for i in arr:
     f.write(struct.pack('l', i))
    
print("\t--- %s seconds ---\n" % (time.time() - start_time))
