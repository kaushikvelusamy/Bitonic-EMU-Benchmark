Post Untimed portion: CurrentRSS (MB)=28.5078
Post Untimed portion: PeakRSS (MB)=28.5078
************************************************
Program Name/Arguments: 
./b_e_i.mwx 
dataset64 
64 
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
Post SystemC Startup: CurrentRSS (MB)=28.5078
Post SystemC Startup: PeakRSS (MB)=28.5078
PROGRAM ENDED.
Emu system run time 0.0439 sec==43857280500 ps
System thread counts:
	active=0, created=3, died=3,
	max live=2 first occurred @28684024644 ps with prog 65.4% complete
	and last occurred @28684024644 ps with prog 68% complete
Num_Core_Cycles=13158500
Num_SRIO_Cycles=27410800
Num_Mem_Cycles=11103108
************************************************
MEMORY MAP
127992,299,266,214,273,197,219,172
194,488,17,48,0,40,0,0
171,0,487,72,0,0,40,0
278,0,0,487,16,0,0,40
168,0,0,0,487,73,48,0
246,0,0,0,0,487,16,48
251,0,0,0,0,0,487,72
332,0,0,0,0,0,0,541

************************************************
REMOTES MAP
0,63,46,98,52,73,87,90
177,0,0,0,0,0,0,0
169,0,0,0,0,0,0,0
162,29,30,0,0,0,0,0
159,0,0,0,0,0,0,0
179,17,0,0,19,0,0,0
157,0,18,0,31,0,0,0
222,0,0,16,0,10,25,0

************************************************
Module: #_created, #_spawns, #_quits, #_migrates, #_rmos_in, #_rmos_out, mem_bw, IPC
NLET[0]: 1, 2, 3, 1640, 1225, 509, 0.0127218, 0.0565885
NLET[1]: 0, 0, 0, 299, 109, 177, 9.06053e-05, 0.000365771
NLET[2]: 0, 0, 0, 283, 94, 169, 8.77232e-05, 0.000363795
NLET[3]: 0, 0, 0, 334, 114, 221, 9.44781e-05, 0.000380059
NLET[4]: 0, 0, 0, 289, 102, 159, 8.91642e-05, 0.000359615
NLET[5]: 0, 0, 0, 310, 83, 215, 8.93444e-05, 0.000379299
NLET[6]: 0, 0, 0, 323, 112, 206, 9.32171e-05, 0.000374815
NLET[7]: 0, 0, 0, 332, 90, 273, 9.79005e-05, 0.000422921

Module: #_in_xacts, in_bw, #_to_nqms, #_to_sysic, p_zero, p_one, opt1, opt2, restored
ME[0].FromNQM[0]: 3374, 0.00307565, 3374, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[1]: 585, 0.000571266, 585, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[2]: 546, 0.000540335, 546, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[3]: 669, 0.000642854, 669, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[4]: 550, 0.000549151, 550, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[5]: 608, 0.000597181, 608, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[6]: 641, 0.000620055, 641, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[7]: 695, 0.00064939, 695, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, out_bw, passers_by, passers_stored
ME[0].FromSysIC[0]: 0, 0, 0, 0, 0
ME[0].FromSysIC[1]: 0, 0, 0, 0, 0
ME[0].FromSysIC[2]: 0, 0, 0, 0, 0
ME[0].FromSysIC[3]: 0, 0, 0, 0, 0
ME[0].FromSysIC[4]: 0, 0, 0, 0, 0
ME[0].FromSysIC[5]: 0, 0, 0, 0, 0

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToNQM[0]: 3374, 0.00318456, 0.000257231, 1, 0, -nan, 0.000257231, 1
ME[0].ToNQM[1]: 585, 0.00056093, 4.44829e-05, 1, 0, -nan, 4.44829e-05, 1
ME[0].ToNQM[2]: 546, 0.000528936, 4.1516e-05, 1, 0, -nan, 4.1516e-05, 1
ME[0].ToNQM[3]: 669, 0.000626591, 5.08735e-05, 1, 0, -nan, 5.08735e-05, 1
ME[0].ToNQM[4]: 550, 0.000540487, 4.18207e-05, 1, 0, -nan, 4.18207e-05, 1
ME[0].ToNQM[5]: 608, 0.000577117, 4.62325e-05, 1, 0, -nan, 4.62325e-05, 1
ME[0].ToNQM[6]: 641, 0.000605692, 4.87433e-05, 1, 0, -nan, 4.87433e-05, 1
ME[0].ToNQM[7]: 695, 0.000621575, 5.28504e-05, 1, 0, -nan, 5.28504e-05, 1

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToSysIC[0]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[1]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[2]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[3]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[4]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[5]: 0, 0, 0, -nan, 0, -nan, 0, -nan


************************************************
End of simulation: CurrentRSS (MB)=32.0156
End of simulation: PeakRSS (MB)=32.0156
************************************************
Simulator wall clock time (seconds): 292
