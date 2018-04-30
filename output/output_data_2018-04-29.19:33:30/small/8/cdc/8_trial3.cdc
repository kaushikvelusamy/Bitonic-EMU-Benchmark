Post Untimed portion: CurrentRSS (MB)=8.84375
Post Untimed portion: PeakRSS (MB)=8.84375
************************************************
Program Name/Arguments: 
../bin/bitonic_EMU_iterative.mwx 
../dataset//small/dataset8.dat 
************************************************
Simulator Version: EMUSIM-18.01
************************************************
Configuration Details:
Gossamer Cores per Nodelet=1
Log2 Num Nodelets=3
Log2 Memory Size/Nodelet=33
Capture queue depths=false
Send ACKs from remotes=true
Bandwidth multiplier through MigrEng=1
Core Clock=300 MHz, Pd=3.333
Memory DDR4-2133: Bandwidth = 1.886 GiB/s = 2.025 GB/s
SRIO SystemIC bandwidth=2.32 GiB/s (2.5GB/s)
************************************************
Post SystemC Startup: CurrentRSS (MB)=8.84375
Post SystemC Startup: PeakRSS (MB)=8.84375
PROGRAM ENDED.
Emu system run time 0.000562 sec==561610500 ps
System thread counts:
	active=0, created=18, died=18,
	max live=3 first occurred @115961736 ps with prog 20.6% complete
	and last occurred @115961736 ps with prog 45.4% complete
Num_Core_Cycles=168500
Num_SRIO_Cycles=351006
Num_Mem_Cycles=142179
************************************************
MEMORY MAP
1858,3,5,0,7,0,2,0
3,0,0,2,0,1,0,0
1,2,1,3,0,0,1,0
5,0,0,0,0,0,0,1
4,1,0,0,3,3,3,0
3,0,1,0,0,0,0,2
1,0,0,1,0,2,1,3
6,0,0,0,0,0,0,0

************************************************
REMOTES MAP
0,0,0,0,0,0,0,0
1,0,0,0,0,0,0,0
1,0,0,0,0,0,0,0
0,1,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,2,0,0,0
0,0,0,0,2,0,0,0
0,0,0,1,0,1,1,0

************************************************
Module: #_created, #_spawns, #_quits, #_migrates, #_rmos_in, #_rmos_out, mem_bw, IPC
NLET[0]: 1, 11, 18, 17, 2, 0, 0.0185611, 0.0675371
NLET[1]: 0, 0, 0, 6, 1, 1, 5.62671e-05, 0.0004273
NLET[2]: 0, 1, 0, 7, 0, 1, 5.62671e-05, 0.000593472
NLET[3]: 0, 0, 0, 6, 1, 1, 5.62671e-05, 0.000522255
NLET[4]: 0, 4, 0, 11, 4, 0, 9.84674e-05, 0.000985163
NLET[5]: 0, 0, 0, 6, 1, 2, 6.33005e-05, 0.000534125
NLET[6]: 0, 1, 0, 7, 1, 2, 7.03339e-05, 0.000700297
NLET[7]: 0, 0, 0, 6, 0, 3, 6.33005e-05, 0.00064095

Module: #_in_xacts, in_bw, #_to_nqms, #_to_sysic, p_zero, p_one, opt1, opt2, restored
ME[0].FromNQM[0]: 19, 0.00194659, 19, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[1]: 8, 0.000700297, 8, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[2]: 8, 0.000813056, 8, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[3]: 8, 0.000700297, 8, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[4]: 15, 0.00131157, 15, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[5]: 9, 0.000718101, 9, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[6]: 10, 0.000836795, 10, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[7]: 9, 0.00072997, 9, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, out_bw, passers_by, passers_stored
ME[0].FromSysIC[0]: 0, 0, 0, 0, 0
ME[0].FromSysIC[1]: 0, 0, 0, 0, 0
ME[0].FromSysIC[2]: 0, 0, 0, 0, 0
ME[0].FromSysIC[3]: 0, 0, 0, 0, 0
ME[0].FromSysIC[4]: 0, 0, 0, 0, 0
ME[0].FromSysIC[5]: 0, 0, 0, 0, 0

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToNQM[0]: 25, 0.00277151, 0.000148779, 1, 0, -nan, 0.000148779, 1
ME[0].ToNQM[1]: 8, 0.000682493, 4.75096e-05, 1, 0, -nan, 4.75096e-05, 1
ME[0].ToNQM[2]: 7, 0.000658754, 4.15699e-05, 1, 0, -nan, 4.15699e-05, 1
ME[0].ToNQM[3]: 8, 0.000682493, 4.75096e-05, 1, 0, -nan, 4.75096e-05, 1
ME[0].ToNQM[4]: 11, 0.000913947, 6.53408e-05, 1, 0, -nan, 6.53408e-05, 1
ME[0].ToNQM[5]: 9, 0.000688427, 5.34486e-05, 1, 0, -nan, 5.34486e-05, 1
ME[0].ToNQM[6]: 9, 0.000682493, 5.34483e-05, 1, 0, -nan, 5.34483e-05, 1
ME[0].ToNQM[7]: 9, 0.000676558, 5.3448e-05, 1, 0, -nan, 5.3448e-05, 1

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToSysIC[0]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[1]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[2]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[3]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[4]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[5]: 0, 0, 0, -nan, 0, -nan, 0, -nan


************************************************
End of simulation: CurrentRSS (MB)=9.16016
End of simulation: PeakRSS (MB)=9.16016
************************************************
Simulator wall clock time (seconds): 3
