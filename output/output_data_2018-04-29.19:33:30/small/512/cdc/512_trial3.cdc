Post Untimed portion: CurrentRSS (MB)=8.76172
Post Untimed portion: PeakRSS (MB)=8.76172
************************************************
Program Name/Arguments: 
../bin/bitonic_EMU_iterative.mwx 
../dataset//small/dataset512.dat 
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
Post SystemC Startup: CurrentRSS (MB)=8.76172
Post SystemC Startup: PeakRSS (MB)=8.76172
PROGRAM ENDED.
Emu system run time 0.0475 sec==47516581200 ps
System thread counts:
	active=0, created=4098, died=4098,
	max live=9 first occurred @43248311403 ps with prog 91% complete
	and last occurred @43248311403 ps with prog 91% complete
Num_Core_Cycles=14256400
Num_SRIO_Cycles=29697863
Num_Mem_Cycles=12029514
************************************************
MEMORY MAP
204266,1248,1088,0,1600,0,512,0
576,1346,672,512,0,448,0,0
64,512,1394,1248,0,0,448,0
1088,0,0,1344,672,0,0,448
256,448,0,0,1540,1248,576,0
576,0,448,0,0,1348,672,512
64,0,0,448,0,512,1418,1248
2208,0,0,0,0,0,0,1332

************************************************
REMOTES MAP
0,0,0,0,0,0,0,0
282,0,0,0,0,0,0,0
189,0,0,0,0,0,0,0
0,327,291,0,0,0,0,0
217,0,0,0,0,0,0,0
0,216,0,0,295,0,0,0
0,0,218,0,318,0,0,0
0,0,0,224,0,183,297,0

************************************************
Module: #_created, #_spawns, #_quits, #_migrates, #_rmos_in, #_rmos_out, mem_bw, IPC
NLET[0]: 1, 3713, 4098, 4448, 688, 0, 0.0248378, 0.0846063
NLET[1]: 0, 0, 0, 2208, 543, 282, 0.000364021, 0.00256348
NLET[2]: 0, 64, 0, 2272, 509, 189, 0.000357454, 0.00275441
NLET[3]: 0, 0, 0, 2208, 224, 618, 0.000365268, 0.00299178
NLET[4]: 0, 256, 0, 2528, 613, 217, 0.000385884, 0.00309321
NLET[5]: 0, 0, 0, 2208, 183, 511, 0.000353298, 0.00303737
NLET[6]: 0, 64, 0, 2272, 297, 536, 0.000370672, 0.0032826
NLET[7]: 0, 0, 0, 2208, 0, 704, 0.000352799, 0.00318678

Module: #_in_xacts, in_bw, #_to_nqms, #_to_sysic, p_zero, p_one, opt1, opt2, restored
ME[0].FromNQM[0]: 5136, 0.0055857, 5136, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[1]: 3033, 0.00304011, 3033, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[2]: 2970, 0.003081, 2970, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[3]: 3050, 0.00308844, 3050, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[4]: 3358, 0.00343986, 3358, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[5]: 2902, 0.00306305, 2902, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[6]: 3105, 0.00313915, 3105, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[7]: 2912, 0.00309082, 2912, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, out_bw, passers_by, passers_stored
ME[0].FromSysIC[0]: 0, 0, 0, 0, 0
ME[0].FromSysIC[1]: 0, 0, 0, 0, 0
ME[0].FromSysIC[2]: 0, 0, 0, 0, 0
ME[0].FromSysIC[3]: 0, 0, 0, 0, 0
ME[0].FromSysIC[4]: 0, 0, 0, 0, 0
ME[0].FromSysIC[5]: 0, 0, 0, 0, 0

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToNQM[0]: 5520, 0.00669229, 0.000389803, 1, 0, -nan, 0.000389803, 1
ME[0].ToNQM[1]: 3033, 0.00303632, 0.000213394, 1, 0, -nan, 0.000213394, 1
ME[0].ToNQM[2]: 2906, 0.00293735, 0.000204439, 1, 0, -nan, 0.000204439, 1
ME[0].ToNQM[3]: 3050, 0.00299276, 0.000214581, 1, 0, -nan, 0.000214581, 1
ME[0].ToNQM[4]: 3102, 0.00302405, 0.000218246, 1, 0, -nan, 0.000218246, 1
ME[0].ToNQM[5]: 2902, 0.00297663, 0.000204165, 1, 0, -nan, 0.000204165, 1
ME[0].ToNQM[6]: 3041, 0.00291708, 0.000213932, 1, 0, -nan, 0.000213932, 1
ME[0].ToNQM[7]: 2912, 0.00295166, 0.000204864, 1, 0, -nan, 0.000204864, 1

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToSysIC[0]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[1]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[2]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[3]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[4]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[5]: 0, 0, 0, -nan, 0, -nan, 0, -nan


************************************************
End of simulation: CurrentRSS (MB)=13.5195
End of simulation: PeakRSS (MB)=13.5195
************************************************
Simulator wall clock time (seconds): 277
