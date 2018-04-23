Post Untimed portion: CurrentRSS (MB)=28.4492
Post Untimed portion: PeakRSS (MB)=28.4492
************************************************
Program Name/Arguments: 
./b_e_i.mwx 
dataset2048 
2048 
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
Post SystemC Startup: CurrentRSS (MB)=28.4492
Post SystemC Startup: PeakRSS (MB)=28.4492
PROGRAM ENDED.
Emu system run time 0.715 sec==715359790200 ps
System thread counts:
	active=0, created=643, died=643,
	max live=48 first occurred @689328446928 ps with prog 96.4% complete
	and last occurred @689328446928 ps with prog 96.4% complete
Num_Core_Cycles=214629400
Num_SRIO_Cycles=447099868
Num_Mem_Cycles=181103744
************************************************
MEMORY MAP
2680016,14918,16150,11310,17338,10872,12642,9576
11664,5045,180,1526,0,1631,0,0
11447,0,5166,3136,104,0,1664,0
14299,0,0,5066,235,81,0,1373
11467,0,0,0,4997,3310,2900,0
14078,29,0,0,0,4902,214,1573
14209,0,21,0,0,0,4855,3190
15642,54,0,16,0,0,0,4807

************************************************
REMOTES MAP
0,3677,3465,4785,3549,4448,4715,5064
6253,0,0,0,0,1,0,8
6016,130,0,0,0,0,3,0
5243,1097,1404,0,0,0,0,2
5807,0,47,168,0,0,0,0
5694,876,0,23,1275,0,0,0
5100,0,827,0,1443,145,0,0
6313,0,0,687,0,546,1307,0

************************************************
Module: #_created, #_spawns, #_quits, #_migrates, #_rmos_in, #_rmos_out, mem_bw, IPC
NLET[0]: 1, 642, 643, 92806, 40426, 29703, 0.0173171, 0.0529122
NLET[1]: 0, 0, 0, 15001, 5780, 6262, 0.000153862, 0.000566199
NLET[2]: 0, 0, 0, 16351, 5743, 6149, 0.000162007, 0.00060331
NLET[3]: 0, 0, 0, 15988, 5663, 7746, 0.000158854, 0.000591391
NLET[4]: 0, 0, 0, 17677, 6267, 6022, 0.000171233, 0.000622683
NLET[5]: 0, 0, 0, 15894, 5140, 7868, 0.000154144, 0.000597756
NLET[6]: 0, 0, 0, 17420, 6025, 7515, 0.000167501, 0.000616994
NLET[7]: 0, 0, 0, 15712, 5074, 8853, 0.000152443, 0.000603855

Module: #_in_xacts, in_bw, #_to_nqms, #_to_sysic, p_zero, p_one, opt1, opt2, restored
ME[0].FromNQM[0]: 162935, 0.0105471, 162935, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[1]: 27043, 0.00172199, 27043, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[2]: 28243, 0.0018649, 28243, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[3]: 29397, 0.00184795, 29397, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[4]: 29966, 0.00200767, 29966, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[5]: 28902, 0.00183715, 28902, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[6]: 30960, 0.00199987, 30960, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[7]: 29639, 0.00183111, 29639, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, out_bw, passers_by, passers_stored
ME[0].FromSysIC[0]: 0, 0, 0, 0, 0
ME[0].FromSysIC[1]: 0, 0, 0, 0, 0
ME[0].FromSysIC[2]: 0, 0, 0, 0, 0
ME[0].FromSysIC[3]: 0, 0, 0, 0, 0
ME[0].FromSysIC[4]: 0, 0, 0, 0, 0
ME[0].FromSysIC[5]: 0, 0, 0, 0, 0

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToNQM[0]: 162935, 0.0106487, 0.000767627, 1.00041, 0, -nan, 0.000767627, 1.00041
ME[0].ToNQM[1]: 27043, 0.00171718, 0.000126215, 1, 0, -nan, 0.000126215, 1
ME[0].ToNQM[2]: 28243, 0.0018608, 0.000131835, 1, 0, -nan, 0.000131835, 1
ME[0].ToNQM[3]: 29397, 0.00182843, 0.000137292, 1.00054, 0, -nan, 0.000137292, 1.00054
ME[0].ToNQM[4]: 29966, 0.00200952, 0.000139913, 1.0001, 0, -nan, 0.000139913, 1.0001
ME[0].ToNQM[5]: 28902, 0.00181159, 0.000134979, 1.00055, 0, -nan, 0.000134979, 1.00055
ME[0].ToNQM[6]: 30960, 0.00198573, 0.00014496, 1.00132, 0, -nan, 0.00014496, 1.00132
ME[0].ToNQM[7]: 29639, 0.00179582, 0.000138398, 1.0004, 0, -nan, 0.000138398, 1.0004

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToSysIC[0]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[1]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[2]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[3]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[4]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[5]: 0, 0, 0, -nan, 0, -nan, 0, -nan


************************************************
End of simulation: CurrentRSS (MB)=63.9727
End of simulation: PeakRSS (MB)=63.9727
************************************************
Simulator wall clock time (seconds): 4945
