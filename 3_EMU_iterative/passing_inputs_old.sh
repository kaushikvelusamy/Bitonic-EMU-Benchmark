"""
This script passes the input dataset* files to the mwx file and stores the cdc and vsf output files in a seperate folder
Enter x in { } in the next line where x is the input in terms of 2 power x
"""
#! /bin/bash

for i in {9..20}
do
	a=$((2**i))
	echo "for input count : $a"
	b='dataset'
	c=$b$a
	echo $a $b $c
	d='--capture_timing_queues' 
	emusim.x $d .././b_e_r.mwx $c $a
	echo -e "\n\n"
	d='b_e_i.cdc'
	e='b_e_i.vsf'
	f='.cdc'
	g='.vsf'
	h='cdc-vsf/'
	cp $d $c$f
	cp $e $c$g
	mv $c$f $c$g $h 
	sleep 5s
done

