Post Untimed portion: CurrentRSS (MB)=28.4844
Post Untimed portion: PeakRSS (MB)=28.4844
************************************************
Program Name/Arguments: 
./b_e_i.mwx 
dataset16 
16 
************************************************
Simulator Version: EMUSIM-18.01
************************************************
Configuration Details:
Gossamer Cores per Nodelet=4
Log2 Num Nodelets=3
Log2 Memory Size/Nodelet=33
Capture queue depths=true
Timing sample interval (ns)=10000
Send ACKs from remotes=true
Bandwidth multiplier through MigrEng=1
Core Clock=300 MHz, Pd=3.333
Memory DDR4-2133: Bandwidth = 1.886 GiB/s = 2.025 GB/s
SRIO SystemIC bandwidth=2.32 GiB/s (2.5GB/s)
************************************************
Post SystemC Startup: CurrentRSS (MB)=28.4844
Post SystemC Startup: PeakRSS (MB)=28.4844
PROGRAM ENDED.
Emu system run time 0.00434 sec==4336899600 ps
System thread counts:
	active=0, created=1, died=1,
	max live=1 first occurred @0 s with prog 0% complete
	and last occurred @0 s with prog 0% complete
Num_Core_Cycles=1301200
Num_SRIO_Cycles=2710562
Num_Mem_Cycles=1097949
************************************************
MEMORY MAP
13230,33,29,20,28,16,19,12
17,4,2,8,0,6,0,0
13,0,4,12,0,0,6,0
32,0,0,4,2,0,0,6
10,0,0,0,4,12,8,0
24,0,0,0,0,4,2,8
23,0,0,0,0,0,4,12
38,0,0,0,0,0,0,3

************************************************
REMOTES MAP
0,7,5,14,4,8,9,12
12,0,0,0,0,0,0,0
10,0,0,0,0,0,0,0
8,6,5,0,0,0,0,0
7,0,0,0,0,0,0,0
12,2,0,0,3,0,0,0
9,0,2,0,4,0,0,0
16,0,0,2,0,3,4,0

************************************************
Module: #_created, #_spawns, #_quits, #_migrates, #_rmos_in, #_rmos_out, mem_bw, IPC
NLET[0]: 1, 0, 1, 157, 74, 59, 0.0133121, 0.0557378
NLET[1]: 0, 0, 0, 33, 15, 12, 4.7361e-05, 0.000183677
NLET[2]: 0, 0, 0, 31, 12, 10, 4.28071e-05, 0.000177528
NLET[3]: 0, 0, 0, 40, 16, 19, 5.55581e-05, 0.000209038
NLET[4]: 0, 0, 0, 30, 11, 7, 4.18963e-05, 0.000170612
NLET[5]: 0, 0, 0, 34, 11, 17, 4.55395e-05, 0.000205964
NLET[6]: 0, 0, 0, 35, 13, 15, 4.82718e-05, 0.00019751
NLET[7]: 0, 0, 0, 38, 12, 25, 4.91826e-05, 0.000237473

Module: #_in_xacts, in_bw, #_to_nqms, #_to_sysic, p_zero, p_one, opt1, opt2, restored
ME[0].FromNQM[0]: 290, 0.00296803, 290, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[1]: 60, 0.000622502, 60, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[2]: 53, 0.000580234, 53, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[3]: 75, 0.000763142, 75, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[4]: 48, 0.000554872, 48, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[5]: 62, 0.000648632, 62, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[6]: 63, 0.000663234, 63, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[7]: 75, 0.000738549, 75, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, out_bw, passers_by, passers_stored
ME[0].FromSysIC[0]: 0, 0, 0, 0, 0
ME[0].FromSysIC[1]: 0, 0, 0, 0, 0
ME[0].FromSysIC[2]: 0, 0, 0, 0, 0
ME[0].FromSysIC[3]: 0, 0, 0, 0, 0
ME[0].FromSysIC[4]: 0, 0, 0, 0, 0
ME[0].FromSysIC[5]: 0, 0, 0, 0, 0

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToNQM[0]: 290, 0.00299109, 0.000223539, 1, 0, -nan, 0.000223539, 1
ME[0].ToNQM[1]: 60, 0.000627113, 4.61401e-05, 1, 0, -nan, 4.61401e-05, 1
ME[0].ToNQM[2]: 53, 0.000583308, 4.07553e-05, 1, 0, -nan, 4.07553e-05, 1
ME[0].ToNQM[3]: 75, 0.000758531, 5.76828e-05, 1, 0, -nan, 5.76828e-05, 1
ME[0].ToNQM[4]: 48, 0.000561021, 3.69097e-05, 1, 0, -nan, 3.69097e-05, 1
ME[0].ToNQM[5]: 62, 0.00063941, 4.76787e-05, 1, 0, -nan, 4.76787e-05, 1
ME[0].ToNQM[6]: 63, 0.00066016, 4.84488e-05, 1, 0, -nan, 4.84488e-05, 1
ME[0].ToNQM[7]: 75, 0.000718567, 5.76805e-05, 1, 0, -nan, 5.76805e-05, 1

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToSysIC[0]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[1]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[2]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[3]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[4]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[5]: 0, 0, 0, -nan, 0, -nan, 0, -nan


************************************************
End of simulation: CurrentRSS (MB)=28.7656
End of simulation: PeakRSS (MB)=28.7656
************************************************
Simulator wall clock time (seconds): 29
