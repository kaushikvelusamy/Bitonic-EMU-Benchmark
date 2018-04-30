Post Untimed portion: CurrentRSS (MB)=8.85547
Post Untimed portion: PeakRSS (MB)=8.85547
************************************************
Program Name/Arguments: 
../bin/bitonic_EMU_iterative.mwx 
../dataset//small/dataset1024.dat 
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
Post SystemC Startup: CurrentRSS (MB)=8.85547
Post SystemC Startup: PeakRSS (MB)=8.85547
PROGRAM ENDED.
Emu system run time 0.104 sec==104493549600 ps
System thread counts:
	active=0, created=9218, died=9218,
	max live=10 first occurred @96328539516 ps with prog 92.2% complete
	and last occurred @96328539516 ps with prog 92.2% complete
Num_Core_Cycles=31351200
Num_SRIO_Cycles=65308468
Num_Mem_Cycles=26454063
************************************************
MEMORY MAP
453872,3072,2432,0,3584,0,1152,0
1280,3572,1792,1152,0,1024,0,0
128,1152,3728,3072,0,0,1024,0
2432,0,0,3584,1792,0,0,1024
512,1024,0,0,4002,3072,1280,0
1280,0,1024,0,0,3578,1792,1152
128,0,0,1024,0,1152,3692,3072
5248,0,0,0,0,0,0,3556

************************************************
REMOTES MAP
0,0,0,0,0,0,0,0
639,0,0,0,0,0,0,0
439,0,0,0,0,0,0,0
0,711,646,0,0,0,0,0
506,0,0,0,0,0,0,0
0,512,0,0,662,0,0,0
0,0,517,0,698,0,0,0
0,0,0,511,0,440,643,0

************************************************
Module: #_created, #_spawns, #_quits, #_migrates, #_rmos_in, #_rmos_out, mem_bw, IPC
NLET[0]: 1, 8449, 9218, 10240, 1584, 0, 0.0248312, 0.0860638
NLET[1]: 0, 0, 0, 5248, 1223, 639, 0.000403794, 0.00287702
NLET[2]: 0, 128, 0, 5376, 1163, 439, 0.000399863, 0.00307006
NLET[3]: 0, 0, 0, 5248, 511, 1357, 0.000404475, 0.00330954
NLET[4]: 0, 512, 0, 5888, 1360, 506, 0.000425039, 0.00337856
NLET[5]: 0, 0, 0, 5248, 440, 1174, 0.000394646, 0.00337193
NLET[6]: 0, 128, 0, 5376, 643, 1215, 0.000408179, 0.00360707
NLET[7]: 0, 0, 0, 5248, 0, 1594, 0.000393059, 0.0035154

Module: #_in_xacts, in_bw, #_to_nqms, #_to_sysic, p_zero, p_one, opt1, opt2, restored
ME[0].FromNQM[0]: 11824, 0.0058399, 11824, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[1]: 7110, 0.00328064, 7110, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[2]: 6978, 0.00331266, 6978, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[3]: 7116, 0.00332664, 7116, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[4]: 7754, 0.00363565, 7754, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[5]: 6862, 0.00330686, 6862, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[6]: 7234, 0.00337033, 7234, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[7]: 6842, 0.00333301, 6842, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, out_bw, passers_by, passers_stored
ME[0].FromSysIC[0]: 0, 0, 0, 0, 0
ME[0].FromSysIC[1]: 0, 0, 0, 0, 0
ME[0].FromSysIC[2]: 0, 0, 0, 0, 0
ME[0].FromSysIC[3]: 0, 0, 0, 0, 0
ME[0].FromSysIC[4]: 0, 0, 0, 0, 0
ME[0].FromSysIC[5]: 0, 0, 0, 0, 0

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToNQM[0]: 12592, 0.00692082, 0.000404442, 1, 0, -nan, 0.000404442, 1
ME[0].ToNQM[1]: 7110, 0.00327707, 0.000227531, 1, 0, -nan, 0.000227531, 1
ME[0].ToNQM[2]: 6850, 0.00317513, 0.000219188, 1, 0, -nan, 0.000219188, 1
ME[0].ToNQM[3]: 7116, 0.00323184, 0.000227713, 1, 0, -nan, 0.000227713, 1
ME[0].ToNQM[4]: 7242, 0.00324102, 0.000231747, 1, 0, -nan, 0.000231747, 1
ME[0].ToNQM[5]: 6862, 0.00321921, 0.000219582, 1, 0, -nan, 0.000219582, 1
ME[0].ToNQM[6]: 7106, 0.00315012, 0.000227374, 1, 0, -nan, 0.000227374, 1
ME[0].ToNQM[7]: 6842, 0.0031905, 0.000218936, 1, 0, -nan, 0.000218936, 1

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToSysIC[0]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[1]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[2]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[3]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[4]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[5]: 0, 0, 0, -nan, 0, -nan, 0, -nan


************************************************
End of simulation: CurrentRSS (MB)=19.4258
End of simulation: PeakRSS (MB)=19.4258
************************************************
Simulator wall clock time (seconds): 600
