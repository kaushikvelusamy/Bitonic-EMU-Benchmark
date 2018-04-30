Post Untimed portion: CurrentRSS (MB)=8.77734
Post Untimed portion: PeakRSS (MB)=8.77734
************************************************
Program Name/Arguments: 
../bin/bitonic_EMU_iterative.mwx 
../dataset//small/dataset16.dat 
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
Post SystemC Startup: CurrentRSS (MB)=8.77734
Post SystemC Startup: PeakRSS (MB)=8.77734
PROGRAM ENDED.
Emu system run time 0.000993 sec==992567400 ps
System thread counts:
	active=0, created=50, died=50,
	max live=3 first occurred @191410857 ps with prog 19.3% complete
	and last occurred @191410857 ps with prog 69.1% complete
Num_Core_Cycles=297800
Num_SRIO_Cycles=620354
Num_Mem_Cycles=251282
************************************************
MEMORY MAP
3603,9,14,0,20,0,6,0
8,1,1,6,0,4,0,0
2,6,3,9,0,0,4,0
14,0,0,1,1,0,0,4
8,4,0,0,9,9,8,0
8,0,4,0,0,3,1,6
2,0,0,4,0,6,5,9
19,0,0,0,0,0,0,3

************************************************
REMOTES MAP
0,0,0,0,0,0,0,0
4,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,5,5,0,0,0,0,0
2,0,0,0,0,0,0,0
0,2,0,0,5,0,0,0
0,0,3,0,5,0,0,0
0,0,0,2,0,1,1,0

************************************************
Module: #_created, #_spawns, #_quits, #_migrates, #_rmos_in, #_rmos_out, mem_bw, IPC
NLET[0]: 1, 37, 50, 49, 6, 0, 0.0215057, 0.0711148
NLET[1]: 0, 0, 0, 19, 7, 4, 0.000123367, 0.00080591
NLET[2]: 0, 2, 0, 21, 8, 0, 0.000119388, 0.000940228
NLET[3]: 0, 0, 0, 19, 2, 10, 0.000127347, 0.00108798
NLET[4]: 0, 8, 0, 29, 10, 2, 0.000167143, 0.00148422
NLET[5]: 0, 0, 0, 19, 1, 7, 0.000119388, 0.00104768
NLET[6]: 0, 2, 0, 21, 1, 8, 0.000131327, 0.00128274
NLET[7]: 0, 0, 0, 19, 0, 4, 0.000103469, 0.00108126

Module: #_in_xacts, in_bw, #_to_nqms, #_to_sysic, p_zero, p_one, opt1, opt2, restored
ME[0].FromNQM[0]: 55, 0.00306582, 55, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[1]: 30, 0.00127602, 30, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[2]: 29, 0.00136669, 29, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[3]: 31, 0.00131968, 31, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[4]: 41, 0.00194426, 41, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[5]: 27, 0.0012861, 27, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[6]: 30, 0.00142377, 30, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[7]: 23, 0.00125252, 23, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, out_bw, passers_by, passers_stored
ME[0].FromSysIC[0]: 0, 0, 0, 0, 0
ME[0].FromSysIC[1]: 0, 0, 0, 0, 0
ME[0].FromSysIC[2]: 0, 0, 0, 0, 0
ME[0].FromSysIC[3]: 0, 0, 0, 0, 0
ME[0].FromSysIC[4]: 0, 0, 0, 0, 0
ME[0].FromSysIC[5]: 0, 0, 0, 0, 0

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToNQM[0]: 67, 0.0041135, 0.000225911, 1, 0, -nan, 0.000225911, 1
ME[0].ToNQM[1]: 30, 0.00126931, 0.000100866, 1, 0, -nan, 0.000100866, 1
ME[0].ToNQM[2]: 27, 0.00123909, 9.07767e-05, 1, 0, -nan, 9.07767e-05, 1
ME[0].ToNQM[3]: 31, 0.00123909, 0.000104225, 1, 0, -nan, 0.000104225, 1
ME[0].ToNQM[4]: 33, 0.00146071, 0.000110974, 1, 0, -nan, 0.000110974, 1
ME[0].ToNQM[5]: 27, 0.00121894, 9.07749e-05, 1, 0, -nan, 9.07749e-05, 1
ME[0].ToNQM[6]: 28, 0.00119543, 9.41347e-05, 1, 0, -nan, 9.41347e-05, 1
ME[0].ToNQM[7]: 23, 0.00119879, 7.73252e-05, 1, 0, -nan, 7.73252e-05, 1

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToSysIC[0]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[1]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[2]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[3]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[4]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[5]: 0, 0, 0, -nan, 0, -nan, 0, -nan


************************************************
End of simulation: CurrentRSS (MB)=9.15234
End of simulation: PeakRSS (MB)=9.15234
************************************************
Simulator wall clock time (seconds): 5
