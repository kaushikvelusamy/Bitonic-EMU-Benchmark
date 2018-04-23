Post Untimed portion: CurrentRSS (MB)=28.3281
Post Untimed portion: PeakRSS (MB)=28.3281
************************************************
Program Name/Arguments: 
./b_e_i.mwx 
dataset128 
128 
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
Post SystemC Startup: CurrentRSS (MB)=28.3281
Post SystemC Startup: PeakRSS (MB)=28.3281
PROGRAM ENDED.
Emu system run time 0.0363 sec==36280038300 ps
System thread counts:
	active=0, created=11, died=11,
	max live=4 first occurred @33471045894 ps with prog 92.3% complete
	and last occurred @33471045894 ps with prog 97.6% complete
Num_Core_Cycles=10885100
Num_SRIO_Cycles=22675023
Num_Mem_Cycles=9184819
************************************************
MEMORY MAP
115704,507,521,370,533,337,392,272
329,112,0,82,0,96,0,0
300,0,112,124,1,0,96,0
478,0,0,112,0,2,0,96
294,0,0,0,112,129,111,0
480,0,0,0,0,112,1,83
465,0,0,0,0,0,112,135
586,0,0,0,0,0,0,112

************************************************
REMOTES MAP
0,106,90,174,103,157,161,176
200,0,0,0,0,0,0,0
186,0,0,0,0,0,0,0
159,56,65,0,0,0,0,0
167,0,0,0,0,0,0,0
198,42,0,0,57,0,0,0
175,0,42,0,63,0,0,0
265,0,0,39,0,21,59,0

************************************************
Module: #_created, #_spawns, #_quits, #_migrates, #_rmos_in, #_rmos_out, mem_bw, IPC
NLET[0]: 1, 10, 11, 2932, 1350, 967, 0.0140788, 0.0499048
NLET[1]: 0, 0, 0, 507, 204, 200, 9.37416e-05, 0.000344783
NLET[2]: 0, 0, 0, 521, 197, 186, 9.47215e-05, 0.000353786
NLET[3]: 0, 0, 0, 576, 213, 280, 0.000102343, 0.000374365
NLET[4]: 0, 0, 0, 534, 223, 167, 9.91854e-05, 0.000345886
NLET[5]: 0, 0, 0, 564, 178, 297, 9.75523e-05, 0.000388513
NLET[6]: 0, 0, 0, 600, 220, 280, 0.000105827, 0.000394117
NLET[7]: 0, 0, 0, 586, 176, 384, 9.96209e-05, 0.000427649

Module: #_in_xacts, in_bw, #_to_nqms, #_to_sysic, p_zero, p_one, opt1, opt2, restored
ME[0].FromNQM[0]: 5249, 0.00658506, 5249, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[1]: 911, 0.00114514, 911, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[2]: 904, 0.00117022, 904, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[3]: 1069, 0.00131381, 1069, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[4]: 924, 0.00119484, 924, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[5]: 1039, 0.00128993, 1039, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[6]: 1100, 0.00136517, 1100, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[7]: 1146, 0.00136021, 1146, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, out_bw, passers_by, passers_stored
ME[0].FromSysIC[0]: 0, 0, 0, 0, 0
ME[0].FromSysIC[1]: 0, 0, 0, 0, 0
ME[0].FromSysIC[2]: 0, 0, 0, 0, 0
ME[0].FromSysIC[3]: 0, 0, 0, 0, 0
ME[0].FromSysIC[4]: 0, 0, 0, 0, 0
ME[0].FromSysIC[5]: 0, 0, 0, 0, 0

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToNQM[0]: 5249, 0.00665616, 0.00048545, 1, 0, -nan, 0.00048545, 1
ME[0].ToNQM[1]: 911, 0.00114588, 8.37884e-05, 1, 0, -nan, 8.37884e-05, 1
ME[0].ToNQM[2]: 904, 0.00117224, 8.31468e-05, 1, 0, -nan, 8.31468e-05, 1
ME[0].ToNQM[3]: 1069, 0.0013015, 9.84276e-05, 1.00094, 0, -nan, 9.84276e-05, 1.00094
ME[0].ToNQM[4]: 924, 0.00120495, 8.49891e-05, 1, 0, -nan, 8.49891e-05, 1
ME[0].ToNQM[5]: 1039, 0.00126797, 9.56647e-05, 1.00096, 0, -nan, 9.56647e-05, 1.00096
ME[0].ToNQM[6]: 1100, 0.00135369, 0.000101193, 1, 0, -nan, 0.000101193, 1
ME[0].ToNQM[7]: 1146, 0.00132199, 0.000105421, 1, 0, -nan, 0.000105421, 1

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToSysIC[0]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[1]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[2]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[3]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[4]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[5]: 0, 0, 0, -nan, 0, -nan, 0, -nan


************************************************
End of simulation: CurrentRSS (MB)=33.9531
End of simulation: PeakRSS (MB)=33.9531
************************************************
Simulator wall clock time (seconds): 240
