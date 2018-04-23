Post Untimed portion: CurrentRSS (MB)=28.4102
Post Untimed portion: PeakRSS (MB)=28.4102
************************************************
Program Name/Arguments: 
./b_e_i.mwx 
dataset8 
8 
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
Post SystemC Startup: CurrentRSS (MB)=28.4102
Post SystemC Startup: PeakRSS (MB)=28.4102
PROGRAM ENDED.
Emu system run time 0.00244 sec==2438422800 ps
System thread counts:
	active=0, created=1, died=1,
	max live=1 first occurred @0 s with prog 0% complete
	and last occurred @0 s with prog 0% complete
Num_Core_Cycles=731600
Num_SRIO_Cycles=1524014
Num_Mem_Cycles=617322
************************************************
MEMORY MAP
7378,12,9,5,9,7,6,3
6,1,1,3,0,2,0,0
3,0,1,5,0,0,2,0
10,0,0,1,1,0,0,2
2,0,0,0,1,5,3,0
10,0,0,0,0,1,1,3
7,0,0,0,0,0,1,5
13,0,0,0,0,0,0,0

************************************************
REMOTES MAP
0,3,1,4,1,5,3,4
4,0,0,0,0,0,0,0
3,0,0,0,0,0,0,0
4,2,1,0,0,0,0,0
2,0,0,0,0,0,0,0
2,1,0,0,3,0,0,0
3,0,1,0,1,0,0,0
6,0,0,1,0,0,2,0

************************************************
Module: #_created, #_spawns, #_quits, #_migrates, #_rmos_in, #_rmos_out, mem_bw, IPC
NLET[0]: 1, 0, 1, 51, 24, 21, 0.0132265, 0.0588942
NLET[1]: 0, 0, 0, 12, 6, 4, 3.07781e-05, 0.000116184
NLET[2]: 0, 0, 0, 10, 3, 3, 2.26786e-05, 0.000112083
NLET[3]: 0, 0, 0, 13, 5, 7, 3.07781e-05, 0.00013532
NLET[4]: 0, 0, 0, 10, 5, 2, 2.59184e-05, 0.000105249
NLET[5]: 0, 0, 0, 14, 5, 6, 3.2398e-05, 0.000127119
NLET[6]: 0, 0, 0, 12, 5, 5, 2.91582e-05, 0.000123018
NLET[7]: 0, 0, 0, 13, 4, 9, 2.75383e-05, 0.000155823

Module: #_in_xacts, in_bw, #_to_nqms, #_to_sysic, p_zero, p_one, opt1, opt2, restored
ME[0].FromNQM[0]: 96, 0.00172225, 96, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[1]: 22, 0.000401859, 22, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[2]: 16, 0.000330782, 16, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[3]: 25, 0.000444232, 25, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[4]: 17, 0.000329415, 17, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[5]: 25, 0.000471569, 25, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[6]: 22, 0.000404593, 22, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[7]: 26, 0.000451066, 26, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, out_bw, passers_by, passers_stored
ME[0].FromSysIC[0]: 0, 0, 0, 0, 0
ME[0].FromSysIC[1]: 0, 0, 0, 0, 0
ME[0].FromSysIC[2]: 0, 0, 0, 0, 0
ME[0].FromSysIC[3]: 0, 0, 0, 0, 0
ME[0].FromSysIC[4]: 0, 0, 0, 0, 0
ME[0].FromSysIC[5]: 0, 0, 0, 0, 0

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToNQM[0]: 96, 0.00173045, 0.000131446, 1, 0, -nan, 0.000131446, 1
ME[0].ToNQM[1]: 22, 0.000407326, 3.00832e-05, 1, 0, -nan, 3.00832e-05, 1
ME[0].ToNQM[2]: 16, 0.000330782, 2.18771e-05, 1, 0, -nan, 2.18771e-05, 1
ME[0].ToNQM[3]: 25, 0.000438764, 3.41866e-05, 1, 0, -nan, 3.41866e-05, 1
ME[0].ToNQM[4]: 17, 0.000337616, 2.32445e-05, 1, 0, -nan, 2.32445e-05, 1
ME[0].ToNQM[5]: 25, 0.000468835, 3.41876e-05, 1, 0, -nan, 3.41876e-05, 1
ME[0].ToNQM[6]: 22, 0.000404593, 3.00832e-05, 1, 0, -nan, 3.00832e-05, 1
ME[0].ToNQM[7]: 26, 0.000437397, 3.5554e-05, 1, 0, -nan, 3.5554e-05, 1

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToSysIC[0]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[1]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[2]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[3]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[4]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[5]: 0, 0, 0, -nan, 0, -nan, 0, -nan


************************************************
End of simulation: CurrentRSS (MB)=28.75
End of simulation: PeakRSS (MB)=28.75
************************************************
Simulator wall clock time (seconds): 17
