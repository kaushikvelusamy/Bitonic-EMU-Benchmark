Post Untimed portion: CurrentRSS (MB)=8.69531
Post Untimed portion: PeakRSS (MB)=8.69531
************************************************
Program Name/Arguments: 
../bin/bitonic_EMU_iterative.mwx 
../dataset//small/dataset64.dat 
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
Post SystemC Startup: CurrentRSS (MB)=8.69531
Post SystemC Startup: PeakRSS (MB)=8.69531
PROGRAM ENDED.
Emu system run time 0.00436 sec==4358564100 ps
System thread counts:
	active=0, created=322, died=322,
	max live=4 first occurred @3567456552 ps with prog 81.8% complete
	and last occurred @3567456552 ps with prog 82% complete
Num_Core_Cycles=1307700
Num_SRIO_Cycles=2724102
Num_Mem_Cycles=1103433
************************************************
MEMORY MAP
17664,72,88,0,128,0,40,0
48,50,24,40,0,32,0,0
8,40,58,72,0,0,32,0
88,0,0,46,24,0,0,32
32,32,0,0,72,72,48,0
48,0,32,0,0,46,24,40
8,0,0,32,0,40,56,72
144,0,0,0,0,0,0,48

************************************************
REMOTES MAP
0,0,0,0,0,0,0,0
30,0,0,0,0,0,0,0
15,0,0,0,0,0,0,0
0,30,26,0,0,0,0,0
15,0,0,0,0,0,0,0
0,17,0,0,27,0,0,0
0,0,16,0,31,0,0,0
0,0,0,17,0,8,25,0

************************************************
Module: #_created, #_spawns, #_quits, #_migrates, #_rmos_in, #_rmos_out, mem_bw, IPC
NLET[0]: 1, 273, 322, 328, 60, 0, 0.0243005, 0.0782611
NLET[1]: 0, 0, 0, 144, 47, 30, 0.000245597, 0.00161046
NLET[2]: 0, 8, 0, 152, 42, 15, 0.000234722, 0.00178634
NLET[3]: 0, 0, 0, 144, 17, 56, 0.000238347, 0.00196528
NLET[4]: 0, 32, 0, 184, 58, 15, 0.00026916, 0.00222222
NLET[5]: 0, 0, 0, 144, 8, 44, 0.000219316, 0.00195916
NLET[6]: 0, 8, 0, 152, 25, 47, 0.000246503, 0.00222222
NLET[7]: 0, 0, 0, 144, 0, 50, 0.000219316, 0.00208611

Module: #_in_xacts, in_bw, #_to_nqms, #_to_sysic, p_zero, p_one, opt1, opt2, restored
ME[0].FromNQM[0]: 388, 0.00455456, 388, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[1]: 221, 0.00219699, 221, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[2]: 209, 0.00226275, 209, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[3]: 217, 0.00223369, 217, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[4]: 257, 0.0027644, 257, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[5]: 196, 0.00219928, 196, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[6]: 224, 0.00232316, 224, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[7]: 194, 0.00220693, 194, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, out_bw, passers_by, passers_stored
ME[0].FromSysIC[0]: 0, 0, 0, 0, 0
ME[0].FromSysIC[1]: 0, 0, 0, 0, 0
ME[0].FromSysIC[2]: 0, 0, 0, 0, 0
ME[0].FromSysIC[3]: 0, 0, 0, 0, 0
ME[0].FromSysIC[4]: 0, 0, 0, 0, 0
ME[0].FromSysIC[5]: 0, 0, 0, 0, 0

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToNQM[0]: 436, 0.0057475, 0.000335337, 1, 0, -nan, 0.000335337, 1
ME[0].ToNQM[1]: 221, 0.00218628, 0.000169369, 1, 0, -nan, 0.000169369, 1
ME[0].ToNQM[2]: 201, 0.00210216, 0.000154029, 1, 0, -nan, 0.000154029, 1
ME[0].ToNQM[3]: 217, 0.00213734, 0.000166295, 1, 0, -nan, 0.000166295, 1
ME[0].ToNQM[4]: 225, 0.00227957, 0.000172451, 1, 0, -nan, 0.000172451, 1
ME[0].ToNQM[5]: 196, 0.00210752, 0.000150198, 1, 0, -nan, 0.000150198, 1
ME[0].ToNQM[6]: 216, 0.00208763, 0.000165521, 1, 0, -nan, 0.000165521, 1
ME[0].ToNQM[7]: 194, 0.00209375, 0.000148663, 1, 0, -nan, 0.000148663, 1

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToSysIC[0]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[1]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[2]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[3]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[4]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[5]: 0, 0, 0, -nan, 0, -nan, 0, -nan


************************************************
End of simulation: CurrentRSS (MB)=9.32812
End of simulation: PeakRSS (MB)=9.32812
************************************************
Simulator wall clock time (seconds): 25
