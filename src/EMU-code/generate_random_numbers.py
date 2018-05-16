#!/usr/bin/env python
import random
import time
import struct
import sys

start_time = time.time()
random.seed(123456)

# 2 power 30 is "1073741824". For bitonic sort the Total number of elements (size) of the input should be a power of 2

filename = "dataset_2.dat" 

arr = [7,5]

with open(filename, "wb") as f:
    f.write(struct.pack('l', 2))
    for i in arr:
        f.write(struct.pack('l', i))
