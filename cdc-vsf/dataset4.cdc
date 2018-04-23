Post Untimed portion: CurrentRSS (MB)=28.4844
Post Untimed portion: PeakRSS (MB)=28.4844
************************************************
Program Name/Arguments: 
./b_e_i.mwx 
dataset4 
4 
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
Emu system run time 0.00155 sec==1550178300 ps
System thread counts:
	active=0, created=1, died=1,
	max live=1 first occurred @0 s with prog 0% complete
	and last occurred @0 s with prog 0% complete
Num_Core_Cycles=465100
Num_SRIO_Cycles=968861
Num_Mem_Cycles=392450
************************************************
MEMORY MAP
4635,4,3,1,2,1,1,0
2,1,1,1,0,0,0,0
1,0,1,3,0,0,0,0
5,0,0,0,0,0,0,0
0,0,0,0,0,1,1,0
1,0,0,0,0,0,0,1
1,0,0,0,0,0,0,1
2,0,0,0,0,0,0,0

************************************************
REMOTES MAP
0,1,1,2,0,0,0,0
2,0,0,0,0,0,0,0
1,0,0,0,0,0,0,0
2,0,1,0,0,0,0,0
0,0,0,0,0,0,0,0
1,0,0,0,0,0,0,0
1,0,0,0,0,0,0,0
2,0,0,0,0,0,0,0

************************************************
Module: #_created, #_spawns, #_quits, #_migrates, #_rmos_in, #_rmos_out, mem_bw, IPC
NLET[0]: 1, 0, 1, 12, 9, 4, 0.0131507, 0.0618276
NLET[1]: 0, 0, 0, 4, 1, 2, 1.52886e-05, 0.000101054
NLET[2]: 0, 0, 0, 4, 2, 1, 1.78367e-05, 9.03032e-05
NLET[3]: 0, 0, 0, 5, 2, 3, 1.78367e-05, 0.000120404
NLET[4]: 0, 0, 0, 2, 0, 0, 5.09619e-06, 2.15008e-05
NLET[5]: 0, 0, 0, 2, 0, 1, 5.09619e-06, 3.22511e-05
NLET[6]: 0, 0, 0, 2, 0, 1, 5.09619e-06, 3.22511e-05
NLET[7]: 0, 0, 0, 2, 0, 2, 5.09619e-06, 4.30015e-05

Module: #_in_xacts, in_bw, #_to_nqms, #_to_sysic, p_zero, p_one, opt1, opt2, restored
ME[0].FromNQM[0]: 25, 0.000638572, 25, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[1]: 7, 0.000212857, 7, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[2]: 7, 0.000208557, 7, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[3]: 10, 0.000270909, 10, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[4]: 2, 9.89035e-05, 2, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[5]: 3, 0.000105354, 3, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[6]: 3, 0.000105354, 3, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[7]: 4, 0.000111804, 4, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, out_bw, passers_by, passers_stored
ME[0].FromSysIC[0]: 0, 0, 0, 0, 0
ME[0].FromSysIC[1]: 0, 0, 0, 0, 0
ME[0].FromSysIC[2]: 0, 0, 0, 0, 0
ME[0].FromSysIC[3]: 0, 0, 0, 0, 0
ME[0].FromSysIC[4]: 0, 0, 0, 0, 0
ME[0].FromSysIC[5]: 0, 0, 0, 0, 0

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToNQM[0]: 25, 0.000660073, 5.37872e-05, 1, 0, -nan, 5.37872e-05, 1
ME[0].ToNQM[1]: 7, 0.000208557, 1.50536e-05, 1, 0, -nan, 1.50536e-05, 1
ME[0].ToNQM[2]: 7, 0.000212857, 1.50537e-05, 1, 0, -nan, 1.50537e-05, 1
ME[0].ToNQM[3]: 10, 0.000266609, 2.15064e-05, 1, 0, -nan, 2.15064e-05, 1
ME[0].ToNQM[4]: 2, 9.89035e-05, 4.30056e-06, 1, 0, -nan, 4.30056e-06, 1
ME[0].ToNQM[5]: 3, 0.000101054, 6.45085e-06, 1, 0, -nan, 6.45085e-06, 1
ME[0].ToNQM[6]: 3, 0.000101054, 6.45085e-06, 1, 0, -nan, 6.45085e-06, 1
ME[0].ToNQM[7]: 4, 0.000103204, 8.60115e-06, 1, 0, -nan, 8.60115e-06, 1

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToSysIC[0]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[1]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[2]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[3]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[4]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[5]: 0, 0, 0, -nan, 0, -nan, 0, -nan


************************************************
End of simulation: CurrentRSS (MB)=28.4844
End of simulation: PeakRSS (MB)=28.4844
************************************************
Simulator wall clock time (seconds): 10
