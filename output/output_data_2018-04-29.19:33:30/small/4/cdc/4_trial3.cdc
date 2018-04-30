Post Untimed portion: CurrentRSS (MB)=8.875
Post Untimed portion: PeakRSS (MB)=8.875
************************************************
Program Name/Arguments: 
../bin/bitonic_EMU_iterative.mwx 
../dataset//small/dataset4.dat 
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
Post SystemC Startup: CurrentRSS (MB)=8.875
Post SystemC Startup: PeakRSS (MB)=8.875
PROGRAM ENDED.
Emu system run time 0.000385 sec==384628200 ps
System thread counts:
	active=0, created=6, died=6,
	max live=3 first occurred @77938872 ps with prog 20.3% complete
	and last occurred @77938872 ps with prog 20.3% complete
Num_Core_Cycles=115400
Num_SRIO_Cycles=240392
Num_Mem_Cycles=97374
************************************************
MEMORY MAP
1176,2,3,0,0,0,0,0
2,0,0,1,0,0,0,0
1,1,1,2,0,0,0,0
3,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0

************************************************
REMOTES MAP
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,1,1,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0

************************************************
Module: #_created, #_spawns, #_quits, #_migrates, #_rmos_in, #_rmos_out, mem_bw, IPC
NLET[0]: 1, 4, 6, 5, 0, 0, 0.0155278, 0.0661265
NLET[1]: 0, 0, 0, 3, 1, 0, 4.10787e-05, 0.000320624
NLET[2]: 0, 1, 0, 4, 1, 0, 5.13484e-05, 0.000528596
NLET[3]: 0, 0, 0, 3, 0, 2, 5.13484e-05, 0.000493934
NLET[4]: 0, 0, 0, 0, 0, 0, 0, 0
NLET[5]: 0, 0, 0, 0, 0, 0, 0, 0
NLET[6]: 0, 0, 0, 0, 0, 0, 0, 0
NLET[7]: 0, 0, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, #_to_nqms, #_to_sysic, p_zero, p_one, opt1, opt2, restored
ME[0].FromNQM[0]: 5, 0.000805893, 5, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[1]: 4, 0.0005026, 4, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[2]: 5, 0.000684575, 5, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[3]: 5, 0.000545927, 5, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[4]: 0, 0, 0, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[5]: 0, 0, 0, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[6]: 0, 0, 0, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[7]: 0, 0, 0, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, out_bw, passers_by, passers_stored
ME[0].FromSysIC[0]: 0, 0, 0, 0, 0
ME[0].FromSysIC[1]: 0, 0, 0, 0, 0
ME[0].FromSysIC[2]: 0, 0, 0, 0, 0
ME[0].FromSysIC[3]: 0, 0, 0, 0, 0
ME[0].FromSysIC[4]: 0, 0, 0, 0, 0
ME[0].FromSysIC[5]: 0, 0, 0, 0, 0

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToNQM[0]: 6, 0.00102253, 5.20454e-05, 1, 0, -nan, 5.20454e-05, 1
ME[0].ToNQM[1]: 4, 0.0005026, 3.46789e-05, 1, 0, -nan, 3.46789e-05, 1
ME[0].ToNQM[2]: 4, 0.000519931, 3.46795e-05, 1, 0, -nan, 3.46795e-05, 1
ME[0].ToNQM[3]: 5, 0.000493934, 4.33482e-05, 1, 0, -nan, 4.33482e-05, 1
ME[0].ToNQM[4]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToNQM[5]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToNQM[6]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToNQM[7]: 0, 0, 0, -nan, 0, -nan, 0, -nan

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToSysIC[0]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[1]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[2]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[3]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[4]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[5]: 0, 0, 0, -nan, 0, -nan, 0, -nan


************************************************
End of simulation: CurrentRSS (MB)=9.19141
End of simulation: PeakRSS (MB)=9.19141
************************************************
Simulator wall clock time (seconds): 2
