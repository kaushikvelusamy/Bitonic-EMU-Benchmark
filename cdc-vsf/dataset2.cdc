Post Untimed portion: CurrentRSS (MB)=28.5
Post Untimed portion: PeakRSS (MB)=28.5
************************************************
Program Name/Arguments: 
./b_e_i.mwx 
dataset2 
2 
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
Post SystemC Startup: CurrentRSS (MB)=28.5
Post SystemC Startup: PeakRSS (MB)=28.5
PROGRAM ENDED.
Emu system run time 0.00116 sec==1160550600 ps
System thread counts:
	active=0, created=1, died=1,
	max live=1 first occurred @0 s with prog 0% complete
	and last occurred @0 s with prog 0% complete
Num_Core_Cycles=348200
Num_SRIO_Cycles=725344
Num_Mem_Cycles=293810
************************************************
MEMORY MAP
3433,3,1,0,0,0,0,0
3,0,0,0,0,0,0,0
0,0,0,1,0,0,0,0
1,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0

************************************************
REMOTES MAP
0,2,0,0,0,0,0,0
1,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
1,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0

************************************************
Module: #_created, #_spawns, #_quits, #_migrates, #_rmos_in, #_rmos_out, mem_bw, IPC
NLET[0]: 1, 0, 1, 4, 2, 2, 0.0131105, 0.0631333
NLET[1]: 0, 0, 0, 3, 2, 1, 1.70178e-05, 0.000103389
NLET[2]: 0, 0, 0, 1, 0, 0, 3.40356e-06, 1.43596e-05
NLET[3]: 0, 0, 0, 1, 0, 1, 3.40356e-06, 2.87191e-05
NLET[4]: 0, 0, 0, 0, 0, 0, 0, 0
NLET[5]: 0, 0, 0, 0, 0, 0, 0, 0
NLET[6]: 0, 0, 0, 0, 0, 0, 0, 0
NLET[7]: 0, 0, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, #_to_nqms, #_to_sysic, p_zero, p_one, opt1, opt2, restored
ME[0].FromNQM[0]: 8, 0.000287191, 8, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[1]: 6, 0.000212522, 6, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[2]: 1, 6.6054e-05, 1, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[3]: 2, 7.46697e-05, 2, 0, 0, 0, 0, 0, 0
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
ME[0].ToNQM[0]: 8, 0.000287191, 2.29818e-05, 1, 0, -nan, 2.29818e-05, 1
ME[0].ToNQM[1]: 6, 0.000218265, 1.72351e-05, 1, 0, -nan, 1.72351e-05, 1
ME[0].ToNQM[2]: 1, 6.6054e-05, 2.87209e-06, 1, 0, -nan, 2.87209e-06, 1
ME[0].ToNQM[3]: 2, 6.89259e-05, 5.74419e-06, 1, 0, -nan, 5.74419e-06, 1
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
End of simulation: CurrentRSS (MB)=28.5
End of simulation: PeakRSS (MB)=28.5
************************************************
Simulator wall clock time (seconds): 8
