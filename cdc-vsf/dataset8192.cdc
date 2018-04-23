Post Untimed portion: CurrentRSS (MB)=28.332
Post Untimed portion: PeakRSS (MB)=28.332
************************************************
Program Name/Arguments: 
./b_e_i.mwx 
dataset8192 
8192 
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
Post SystemC Startup: CurrentRSS (MB)=28.332
Post SystemC Startup: PeakRSS (MB)=28.332
PROGRAM ENDED.
Emu system run time 3.16 sec==3161859782400 ps
System thread counts:
	active=0, created=3587, died=3587,
	max live=112 first occurred @3056033692734 ps with prog 96.7% complete
	and last occurred @3056033692734 ps with prog 96.7% complete
Num_Core_Cycles=948652800
Num_SRIO_Cycles=1976162364
Num_Mem_Cycles=800470830
************************************************
MEMORY MAP
14651339,75432,80550,56355,84612,55370,63663,50254
61334,27492,1215,6726,0,7135,0,0
60215,0,27504,14135,901,0,6917,0
69748,0,0,26849,1199,558,0,5977
58798,0,0,0,26661,14460,13454,0
69308,500,0,0,0,26255,1269,6446
70276,0,403,0,0,0,25868,14624
76557,478,0,266,0,0,0,25622

************************************************
REMOTES MAP
0,19510,18589,23010,18714,22051,23206,24505
31289,0,0,0,0,79,0,177
30011,942,0,0,0,0,75,0
26028,4499,5669,0,0,0,0,103
27794,0,379,789,0,0,0,0
27068,3604,0,244,5639,0,0,0
25167,0,3266,0,6754,793,0,0
29854,0,0,2821,0,2468,6234,0

************************************************
Module: #_created, #_spawns, #_quits, #_migrates, #_rmos_in, #_rmos_out, mem_bw, IPC
NLET[0]: 1, 3586, 3587, 466236, 197211, 149585, 0.0238467, 0.0675641
NLET[1]: 0, 0, 0, 76410, 28555, 31545, 0.000180048, 0.000659865
NLET[2]: 0, 0, 0, 82168, 27903, 31028, 0.000186606, 0.000692894
NLET[3]: 0, 0, 0, 77482, 26864, 36299, 0.000178265, 0.000664124
NLET[4]: 0, 0, 0, 86712, 31107, 28962, 0.00019482, 0.000697508
NLET[5]: 0, 0, 0, 77523, 25391, 36555, 0.000175624, 0.00066761
NLET[6]: 0, 0, 0, 85303, 29515, 35980, 0.000189735, 0.000695392
NLET[7]: 0, 0, 0, 77301, 24785, 41377, 0.000173454, 0.000675932

Module: #_in_xacts, in_bw, #_to_nqms, #_to_sysic, p_zero, p_one, opt1, opt2, restored
ME[0].FromNQM[0]: 813032, 0.0119826, 813032, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[1]: 136510, 0.00198241, 136510, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[2]: 141099, 0.00211969, 141099, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[3]: 140645, 0.00202165, 140645, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[4]: 146781, 0.0022267, 146781, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[5]: 139469, 0.0020219, 139469, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[6]: 150798, 0.00221306, 150798, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[7]: 143463, 0.00203113, 143463, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, out_bw, passers_by, passers_stored
ME[0].FromSysIC[0]: 0, 0, 0, 0, 0
ME[0].FromSysIC[1]: 0, 0, 0, 0, 0
ME[0].FromSysIC[2]: 0, 0, 0, 0, 0
ME[0].FromSysIC[3]: 0, 0, 0, 0, 0
ME[0].FromSysIC[4]: 0, 0, 0, 0, 0
ME[0].FromSysIC[5]: 0, 0, 0, 0, 0

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToNQM[0]: 813032, 0.0120852, 0.000869265, 1.00195, 0, -nan, 0.000869265, 1.00195
ME[0].ToNQM[1]: 136510, 0.00197567, 0.000144194, 1.00007, 0, -nan, 0.000144194, 1.00007
ME[0].ToNQM[2]: 141099, 0.00211274, 0.000149078, 1.00018, 0, -nan, 0.000149078, 1.00018
ME[0].ToNQM[3]: 140645, 0.00200157, 0.000148637, 1.00051, 0, -nan, 0.000148637, 1.00051
ME[0].ToNQM[4]: 146781, 0.0022307, 0.000155097, 1.00016, 0, -nan, 0.000155097, 1.00016
ME[0].ToNQM[5]: 139469, 0.00199819, 0.000147439, 1.00061, 0, -nan, 0.000147439, 1.00061
ME[0].ToNQM[6]: 150798, 0.00219909, 0.000159469, 1.0007, 0, -nan, 0.000159469, 1.0007
ME[0].ToNQM[7]: 143463, 0.00199603, 0.000151648, 1.00062, 0, -nan, 0.000151648, 1.00062

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToSysIC[0]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[1]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[2]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[3]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[4]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[5]: 0, 0, 0, -nan, 0, -nan, 0, -nan


************************************************
End of simulation: CurrentRSS (MB)=126.59
End of simulation: PeakRSS (MB)=126.59
************************************************
Simulator wall clock time (seconds): 21747
