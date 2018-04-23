Post Untimed portion: CurrentRSS (MB)=28.5664
Post Untimed portion: PeakRSS (MB)=28.5664
************************************************
Program Name/Arguments: 
./b_e_i.mwx 
dataset256 
256 
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
Post SystemC Startup: CurrentRSS (MB)=28.5664
Post SystemC Startup: PeakRSS (MB)=28.5664
PROGRAM ENDED.
Emu system run time 0.0763 sec==76317367500 ps
System thread counts:
	active=0, created=35, died=35,
	max live=8 first occurred @71915614386 ps with prog 94.2% complete
	and last occurred @71915614386 ps with prog 98.8% complete
Num_Core_Cycles=22897500
Num_SRIO_Cycles=47698354
Num_Mem_Cycles=19320852
************************************************
MEMORY MAP
250986,1242,1266,838,1329,829,990,707
852,321,6,172,0,212,0,0
771,0,320,322,3,0,176,0
1165,0,0,320,0,3,0,164
766,0,0,0,320,305,261,0
1174,0,0,0,0,320,8,167
1135,0,0,0,0,0,320,300
1338,0,0,0,0,0,0,320

************************************************
REMOTES MAP
0,286,231,364,260,363,395,421
487,0,0,0,0,0,0,0
447,0,0,0,0,0,0,0
472,107,129,0,0,0,0,0
422,0,0,0,0,0,0,0
499,91,0,0,125,0,0,0
393,0,91,0,158,0,0,0
562,0,0,78,0,55,136,0

************************************************
Module: #_created, #_spawns, #_quits, #_migrates, #_rmos_in, #_rmos_out, mem_bw, IPC
NLET[0]: 1, 34, 35, 7201, 3282, 2320, 0.0146008, 0.049544
NLET[1]: 0, 0, 0, 1242, 484, 487, 0.000112469, 0.000411224
NLET[2]: 0, 0, 0, 1272, 451, 447, 0.000112417, 0.00042319
NLET[3]: 0, 0, 0, 1332, 442, 708, 0.000114332, 0.000448477
NLET[4]: 0, 0, 0, 1332, 543, 422, 0.000120078, 0.000422797
NLET[5]: 0, 0, 0, 1349, 418, 715, 0.000114125, 0.000458827
NLET[6]: 0, 0, 0, 1435, 531, 642, 0.000124373, 0.000453063
NLET[7]: 0, 0, 0, 1338, 421, 831, 0.00011366, 0.000467911

Module: #_in_xacts, in_bw, #_to_nqms, #_to_sysic, p_zero, p_one, opt1, opt2, restored
ME[0].FromNQM[0]: 12803, 0.00767975, 12803, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[1]: 2213, 0.0013325, 2213, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[2]: 2170, 0.00135596, 2170, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[3]: 2482, 0.00145003, 2482, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[4]: 2297, 0.00141697, 2297, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[5]: 2482, 0.00146697, 2482, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[6]: 2608, 0.00154873, 2608, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[7]: 2590, 0.00147125, 2590, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, out_bw, passers_by, passers_stored
ME[0].FromSysIC[0]: 0, 0, 0, 0, 0
ME[0].FromSysIC[1]: 0, 0, 0, 0, 0
ME[0].FromSysIC[2]: 0, 0, 0, 0, 0
ME[0].FromSysIC[3]: 0, 0, 0, 0, 0
ME[0].FromSysIC[4]: 0, 0, 0, 0, 0
ME[0].FromSysIC[5]: 0, 0, 0, 0, 0

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToNQM[0]: 12803, 0.00776456, 0.000563519, 1, 0, -nan, 0.000563519, 1
ME[0].ToNQM[1]: 2213, 0.00133207, 9.6777e-05, 1, 0, -nan, 9.6777e-05, 1
ME[0].ToNQM[2]: 2170, 0.00135617, 9.48989e-05, 1, 0, -nan, 9.48989e-05, 1
ME[0].ToNQM[3]: 2482, 0.00142679, 0.000108551, 1, 0, -nan, 0.000108551, 1
ME[0].ToNQM[4]: 2297, 0.00142727, 0.00010046, 1, 0, -nan, 0.00010046, 1
ME[0].ToNQM[5]: 2482, 0.0014409, 0.000108553, 1, 0, -nan, 0.000108553, 1
ME[0].ToNQM[6]: 2608, 0.00153895, 0.000114074, 1, 0, -nan, 0.000114074, 1
ME[0].ToNQM[7]: 2590, 0.00143544, 0.000113275, 1, 0, -nan, 0.000113275, 1

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToSysIC[0]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[1]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[2]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[3]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[4]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[5]: 0, 0, 0, -nan, 0, -nan, 0, -nan


************************************************
End of simulation: CurrentRSS (MB)=38.3984
End of simulation: PeakRSS (MB)=38.3984
************************************************
Simulator wall clock time (seconds): 531
