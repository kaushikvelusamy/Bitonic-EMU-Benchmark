Post Untimed portion: CurrentRSS (MB)=8.74609
Post Untimed portion: PeakRSS (MB)=8.74609
************************************************
Program Name/Arguments: 
../bin/bitonic_EMU_iterative.mwx 
../dataset//small/dataset128.dat 
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
Post SystemC Startup: CurrentRSS (MB)=8.74609
Post SystemC Startup: PeakRSS (MB)=8.74609
PROGRAM ENDED.
Emu system run time 0.00965 sec==9649701600 ps
System thread counts:
	active=0, created=770, died=770,
	max live=5 first occurred @8343112272 ps with prog 86.5% complete
	and last occurred @8343112272 ps with prog 86.5% complete
Num_Core_Cycles=2895200
Num_SRIO_Cycles=6031063
Num_Mem_Cycles=2442962
************************************************
MEMORY MAP
40231,192,208,0,304,0,96,0
112,162,80,96,0,80,0,0
16,96,182,192,0,0,80,0
208,0,0,160,80,0,0,80
64,80,0,0,210,192,112,0
112,0,80,0,0,156,80,96
16,0,0,80,0,96,178,192
368,0,0,0,0,0,0,164

************************************************
REMOTES MAP
0,0,0,0,0,0,0,0
57,0,0,0,0,0,0,0
37,0,0,0,0,0,0,0
0,70,60,0,0,0,0,0
41,0,0,0,0,0,0,0
0,40,0,0,46,0,0,0
0,0,41,0,52,0,0,0
0,0,0,43,0,18,49,0

************************************************
Module: #_created, #_spawns, #_quits, #_migrates, #_rmos_in, #_rmos_out, mem_bw, IPC
NLET[0]: 1, 673, 770, 800, 135, 0, 0.0247069, 0.0809492
NLET[1]: 0, 0, 0, 368, 110, 57, 0.000285309, 0.00192733
NLET[2]: 0, 16, 0, 384, 101, 37, 0.000281625, 0.00213319
NLET[3]: 0, 0, 0, 368, 43, 130, 0.000286947, 0.00234181
NLET[4]: 0, 64, 0, 448, 98, 41, 0.000300046, 0.00253523
NLET[5]: 0, 0, 0, 368, 18, 86, 0.000257065, 0.00231279
NLET[6]: 0, 16, 0, 384, 49, 93, 0.000281625, 0.00257668
NLET[7]: 0, 0, 0, 368, 0, 110, 0.000262796, 0.00245786

Module: #_in_xacts, in_bw, #_to_nqms, #_to_sysic, p_zero, p_one, opt1, opt2, restored
ME[0].FromNQM[0]: 935, 0.00498169, 935, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[1]: 535, 0.00251209, 535, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[2]: 522, 0.00257668, 522, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[3]: 541, 0.00256459, 541, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[4]: 587, 0.00301637, 587, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[5]: 472, 0.00251036, 472, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[6]: 526, 0.00261674, 526, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[7]: 478, 0.00252901, 478, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, out_bw, passers_by, passers_stored
ME[0].FromSysIC[0]: 0, 0, 0, 0, 0
ME[0].FromSysIC[1]: 0, 0, 0, 0, 0
ME[0].FromSysIC[2]: 0, 0, 0, 0, 0
ME[0].FromSysIC[3]: 0, 0, 0, 0, 0
ME[0].FromSysIC[4]: 0, 0, 0, 0, 0
ME[0].FromSysIC[5]: 0, 0, 0, 0, 0

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToNQM[0]: 1031, 0.0061526, 0.000358311, 1, 0, -nan, 0.000358311, 1
ME[0].ToNQM[1]: 535, 0.00251002, 0.000185253, 1, 0, -nan, 0.000185253, 1
ME[0].ToNQM[2]: 506, 0.00242194, 0.000175196, 1, 0, -nan, 0.000175196, 1
ME[0].ToNQM[3]: 541, 0.00246581, 0.000187323, 1, 0, -nan, 0.000187323, 1
ME[0].ToNQM[4]: 523, 0.00253074, 0.000181102, 1, 0, -nan, 0.000181102, 1
ME[0].ToNQM[5]: 472, 0.0024247, 0.000163425, 1, 0, -nan, 0.000163425, 1
ME[0].ToNQM[6]: 510, 0.0023874, 0.000176575, 1, 0, -nan, 0.000176575, 1
ME[0].ToNQM[7]: 478, 0.00241434, 0.0001655, 1, 0, -nan, 0.0001655, 1

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToSysIC[0]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[1]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[2]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[3]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[4]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[5]: 0, 0, 0, -nan, 0, -nan, 0, -nan


************************************************
End of simulation: CurrentRSS (MB)=9.89453
End of simulation: PeakRSS (MB)=9.89453
************************************************
Simulator wall clock time (seconds): 55
