Post Untimed portion: CurrentRSS (MB)=8.83203
Post Untimed portion: PeakRSS (MB)=9.08984
************************************************
Program Name/Arguments: 
../bin/bitonic_EMU_iterative.mwx 
../dataset//small/dataset256.dat 
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
Post SystemC Startup: CurrentRSS (MB)=9.08984
Post SystemC Startup: PeakRSS (MB)=9.08984
PROGRAM ENDED.
Emu system run time 0.0215 sec==21466186500 ps
System thread counts:
	active=0, created=1794, died=1794,
	max live=6 first occurred @19213375137 ps with prog 89.5% complete
	and last occurred @19213375137 ps with prog 89.6% complete
Num_Core_Cycles=6440500
Num_SRIO_Cycles=13416366
Num_Mem_Cycles=5434477
************************************************
MEMORY MAP
91084,496,480,0,704,0,224,0
256,482,240,224,0,192,0,0
32,224,512,496,0,0,192,0
480,0,0,474,240,0,0,192
128,192,0,0,580,496,256,0
256,0,192,0,0,490,240,224
32,0,0,192,0,224,512,496
912,0,0,0,0,0,0,470

************************************************
REMOTES MAP
0,0,0,0,0,0,0,0
129,0,0,0,0,0,0,0
80,0,0,0,0,0,0,0
0,147,136,0,0,0,0,0
92,0,0,0,0,0,0,0
0,96,0,0,134,0,0,0
0,0,108,0,134,0,0,0
0,0,0,97,0,82,121,0

************************************************
Module: #_created, #_spawns, #_quits, #_migrates, #_rmos_in, #_rmos_out, mem_bw, IPC
NLET[0]: 1, 1601, 1794, 1904, 301, 0, 0.024814, 0.08294
NLET[1]: 0, 0, 0, 912, 243, 129, 0.000324962, 0.00225014
NLET[2]: 0, 32, 0, 944, 244, 80, 0.00032165, 0.00244205
NLET[3]: 0, 0, 0, 912, 97, 283, 0.000324962, 0.00266812
NLET[4]: 0, 128, 0, 1072, 268, 92, 0.000346675, 0.00281283
NLET[5]: 0, 0, 0, 912, 82, 230, 0.000315394, 0.00270569
NLET[6]: 0, 32, 0, 944, 121, 242, 0.000328826, 0.0029507
NLET[7]: 0, 0, 0, 912, 0, 300, 0.000309505, 0.00284046

Module: #_in_xacts, in_bw, #_to_nqms, #_to_sysic, p_zero, p_one, opt1, opt2, restored
ME[0].FromNQM[0]: 2205, 0.00530595, 2205, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[1]: 1284, 0.00278829, 1284, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[2]: 1268, 0.00284015, 1268, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[3]: 1292, 0.00283736, 1292, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[4]: 1432, 0.00323702, 1432, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[5]: 1224, 0.00281034, 1224, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[6]: 1307, 0.00289651, 1307, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[7]: 1212, 0.00283022, 1212, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, out_bw, passers_by, passers_stored
ME[0].FromSysIC[0]: 0, 0, 0, 0, 0
ME[0].FromSysIC[1]: 0, 0, 0, 0, 0
ME[0].FromSysIC[2]: 0, 0, 0, 0, 0
ME[0].FromSysIC[3]: 0, 0, 0, 0, 0
ME[0].FromSysIC[4]: 0, 0, 0, 0, 0
ME[0].FromSysIC[5]: 0, 0, 0, 0, 0

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToNQM[0]: 2397, 0.00644282, 0.000374589, 1, 0, -nan, 0.000374589, 1
ME[0].ToNQM[1]: 1284, 0.00278395, 0.00019992, 1, 0, -nan, 0.00019992, 1
ME[0].ToNQM[2]: 1236, 0.00269731, 0.00019243, 1, 0, -nan, 0.00019243, 1
ME[0].ToNQM[3]: 1292, 0.00273985, 0.000201157, 1, 0, -nan, 0.000201157, 1
ME[0].ToNQM[4]: 1304, 0.00279481, 0.000203036, 1, 0, -nan, 0.000203036, 1
ME[0].ToNQM[5]: 1224, 0.00272463, 0.000190567, 1, 0, -nan, 0.000190567, 1
ME[0].ToNQM[6]: 1275, 0.00266517, 0.000198495, 1, 0, -nan, 0.000198495, 1
ME[0].ToNQM[7]: 1212, 0.00269731, 0.000188693, 1, 0, -nan, 0.000188693, 1

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToSysIC[0]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[1]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[2]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[3]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[4]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[5]: 0, 0, 0, -nan, 0, -nan, 0, -nan


************************************************
End of simulation: CurrentRSS (MB)=10.9531
End of simulation: PeakRSS (MB)=10.9531
************************************************
Simulator wall clock time (seconds): 120
