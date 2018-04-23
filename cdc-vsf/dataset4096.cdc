Post Untimed portion: CurrentRSS (MB)=28.3203
Post Untimed portion: PeakRSS (MB)=28.3203
************************************************
Program Name/Arguments: 
./b_e_i.mwx 
dataset4096 
4096 
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
Post SystemC Startup: CurrentRSS (MB)=28.3203
Post SystemC Startup: PeakRSS (MB)=28.3203
PROGRAM ENDED.
Emu system run time 1.51 sec==1505396778600 ps
System thread counts:
	active=0, created=1539, died=1539,
	max live=65 first occurred @1503154272873 ps with prog 99.9% complete
	and last occurred @1503154272873 ps with prog 99.9% complete
Num_Core_Cycles=451664200
Num_SRIO_Cycles=940872986
Num_Mem_Cycles=381113108
************************************************
MEMORY MAP
6079797,34316,36687,25307,38462,24762,28829,21891
27592,11871,473,3256,0,3374,0,0
26854,0,11978,6769,386,0,3320,0
31892,0,0,11751,488,213,0,2855
26389,0,0,0,11700,6835,6112,0
31336,156,0,0,0,11487,522,3170
31606,0,169,0,0,0,11317,7008
34585,223,0,116,0,0,0,11163

************************************************
REMOTES MAP
0,8770,8303,10672,8504,10060,10542,11108
14074,0,0,0,0,34,0,67
13659,339,0,0,0,0,21,0
11794,2258,2701,0,0,0,0,38
12665,0,156,453,0,0,0,0
12442,1725,0,72,2787,0,0,0
11130,0,1642,0,3083,354,0,0
13856,0,0,1346,0,1090,2892,0

************************************************
Module: #_created, #_spawns, #_quits, #_migrates, #_rmos_in, #_rmos_out, mem_bw, IPC
NLET[0]: 1, 1538, 1539, 210254, 89620, 67959, 0.0193397, 0.0578644
NLET[1]: 0, 0, 0, 34695, 13092, 14175, 0.000169971, 0.000619808
NLET[2]: 0, 0, 0, 37329, 12802, 14019, 0.000176339, 0.000653959
NLET[3]: 0, 0, 0, 35448, 12543, 16791, 0.000169884, 0.000630922
NLET[4]: 0, 0, 0, 39336, 14374, 13274, 0.000184622, 0.00065829
NLET[5]: 0, 0, 0, 35184, 11538, 17026, 0.000165442, 0.000633519
NLET[6]: 0, 0, 0, 38783, 13455, 16209, 0.000179718, 0.000655649
NLET[7]: 0, 0, 0, 34924, 11213, 19184, 0.000162692, 0.000641368

Module: #_in_xacts, in_bw, #_to_nqms, #_to_sysic, p_zero, p_one, opt1, opt2, restored
ME[0].FromNQM[0]: 367833, 0.0113546, 367833, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[1]: 61962, 0.0018899, 61962, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[2]: 64150, 0.00202236, 64150, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[3]: 64782, 0.00194441, 64782, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[4]: 66984, 0.00212309, 66984, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[5]: 63748, 0.0019303, 63748, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[6]: 68447, 0.00211239, 68447, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[7]: 65321, 0.00193068, 65321, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, out_bw, passers_by, passers_stored
ME[0].FromSysIC[0]: 0, 0, 0, 0, 0
ME[0].FromSysIC[1]: 0, 0, 0, 0, 0
ME[0].FromSysIC[2]: 0, 0, 0, 0, 0
ME[0].FromSysIC[3]: 0, 0, 0, 0, 0
ME[0].FromSysIC[4]: 0, 0, 0, 0, 0
ME[0].FromSysIC[5]: 0, 0, 0, 0, 0

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToNQM[0]: 367833, 0.0114524, 0.000824967, 1.00138, 0, -nan, 0.000824967, 1.00138
ME[0].ToNQM[1]: 61962, 0.0018847, 0.000137449, 1.00003, 0, -nan, 0.000137449, 1.00003
ME[0].ToNQM[2]: 64150, 0.00201659, 0.000142324, 1.00003, 0, -nan, 0.000142324, 1.00003
ME[0].ToNQM[3]: 64782, 0.00192543, 0.000143799, 1.00065, 0, -nan, 0.000143799, 1.00065
ME[0].ToNQM[4]: 66984, 0.00212749, 0.000148657, 1.00022, 0, -nan, 0.000148657, 1.00022
ME[0].ToNQM[5]: 63748, 0.00190585, 0.000141523, 1.00055, 0, -nan, 0.000141523, 1.00055
ME[0].ToNQM[6]: 68447, 0.00209993, 0.000151956, 1.00061, 0, -nan, 0.000151956, 1.00061
ME[0].ToNQM[7]: 65321, 0.00189528, 0.000144962, 1.00044, 0, -nan, 0.000144962, 1.00044

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToSysIC[0]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[1]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[2]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[3]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[4]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[5]: 0, 0, 0, -nan, 0, -nan, 0, -nan


************************************************
End of simulation: CurrentRSS (MB)=82.168
End of simulation: PeakRSS (MB)=82.168
************************************************
Simulator wall clock time (seconds): 10570
