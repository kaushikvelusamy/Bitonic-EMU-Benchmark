Post Untimed portion: CurrentRSS (MB)=28.4922
Post Untimed portion: PeakRSS (MB)=28.4922
************************************************
Program Name/Arguments: 
./b_e_i.mwx 
dataset32 
32 
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
Post SystemC Startup: CurrentRSS (MB)=28.4922
Post SystemC Startup: PeakRSS (MB)=28.4922
PROGRAM ENDED.
Emu system run time 0.0085 sec==8499816600 ps
System thread counts:
	active=0, created=1, died=1,
	max live=1 first occurred @0 s with prog 0% complete
	and last occurred @0 s with prog 0% complete
Num_Core_Cycles=2550200
Num_SRIO_Cycles=5312385
Num_Mem_Cycles=2151852
************************************************
MEMORY MAP
25979,91,78,53,79,52,56,33
51,14,4,20,0,16,0,0
38,0,14,28,0,0,16,0
81,0,0,14,4,0,0,16
35,0,0,0,14,28,20,0
72,0,0,0,0,14,4,20
68,0,0,0,0,0,14,28
97,0,0,0,0,0,0,13

************************************************
REMOTES MAP
0,21,12,31,13,26,26,27
31,0,0,0,0,0,0,0
28,0,0,0,0,0,0,0
27,15,9,0,0,0,0,0
23,0,0,0,0,0,0,0
28,7,0,0,12,0,0,0
24,0,7,0,11,0,0,0
47,0,0,6,0,2,11,0

************************************************
Module: #_created, #_spawns, #_quits, #_migrates, #_rmos_in, #_rmos_out, mem_bw, IPC
NLET[0]: 1, 0, 1, 442, 208, 156, 0.0133592, 0.0526386
NLET[1]: 0, 0, 0, 91, 43, 31, 7.01721e-05, 0.000251353
NLET[2]: 0, 0, 0, 82, 28, 28, 5.85542e-05, 0.000247039
NLET[3]: 0, 0, 0, 101, 37, 51, 7.2031e-05, 0.000286644
NLET[4]: 0, 0, 0, 83, 36, 23, 6.32014e-05, 0.000238805
NLET[5]: 0, 0, 0, 96, 28, 47, 6.5525e-05, 0.000280762
NLET[6]: 0, 0, 0, 96, 37, 42, 7.01721e-05, 0.00027292
NLET[7]: 0, 0, 0, 97, 27, 66, 6.5525e-05, 0.000321543

Module: #_in_xacts, in_bw, #_to_nqms, #_to_sysic, p_zero, p_one, opt1, opt2, restored
ME[0].FromNQM[0]: 806, 0.00425143, 806, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[1]: 165, 0.000874049, 165, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[2]: 138, 0.000783468, 138, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[3]: 189, 0.000985413, 189, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[4]: 142, 0.000789742, 142, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[5]: 171, 0.000932084, 171, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[6]: 175, 0.000929731, 175, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[7]: 190, 0.000963062, 190, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, out_bw, passers_by, passers_stored
ME[0].FromSysIC[0]: 0, 0, 0, 0, 0
ME[0].FromSysIC[1]: 0, 0, 0, 0, 0
ME[0].FromSysIC[2]: 0, 0, 0, 0, 0
ME[0].FromSysIC[3]: 0, 0, 0, 0, 0
ME[0].FromSysIC[4]: 0, 0, 0, 0, 0
ME[0].FromSysIC[5]: 0, 0, 0, 0, 0

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToNQM[0]: 806, 0.00429221, 0.000317416, 1, 0, -nan, 0.000317416, 1
ME[0].ToNQM[1]: 165, 0.00088346, 6.4758e-05, 1, 0, -nan, 6.4758e-05, 1
ME[0].ToNQM[2]: 138, 0.000783468, 5.41558e-05, 1, 0, -nan, 5.41558e-05, 1
ME[0].ToNQM[3]: 189, 0.000974433, 7.41841e-05, 1, 0, -nan, 7.41841e-05, 1
ME[0].ToNQM[4]: 142, 0.000799937, 5.57264e-05, 1, 0, -nan, 5.57264e-05, 1
ME[0].ToNQM[5]: 171, 0.000917183, 6.71151e-05, 1, 0, -nan, 6.71151e-05, 1
ME[0].ToNQM[6]: 175, 0.00092581, 6.86856e-05, 1, 0, -nan, 6.86856e-05, 1
ME[0].ToNQM[7]: 190, 0.000932476, 7.45734e-05, 1, 0, -nan, 7.45734e-05, 1

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToSysIC[0]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[1]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[2]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[3]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[4]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[5]: 0, 0, 0, -nan, 0, -nan, 0, -nan


************************************************
End of simulation: CurrentRSS (MB)=29.0312
End of simulation: PeakRSS (MB)=29.0312
************************************************
Simulator wall clock time (seconds): 58
