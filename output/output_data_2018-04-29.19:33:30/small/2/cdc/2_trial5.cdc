Post Untimed portion: CurrentRSS (MB)=8.83984
Post Untimed portion: PeakRSS (MB)=8.83984
************************************************
Program Name/Arguments: 
../bin/bitonic_EMU_iterative.mwx 
../dataset//small/dataset2.dat 
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
Post SystemC Startup: CurrentRSS (MB)=8.83984
Post SystemC Startup: PeakRSS (MB)=8.83984
PROGRAM ENDED.
Emu system run time 0.000317 sec==316968300 ps
System thread counts:
	active=0, created=2, died=2,
	max live=2 first occurred @13235343 ps with prog 4.18% complete
	and last occurred @13235343 ps with prog 4.18% complete
Num_Core_Cycles=95100
Num_SRIO_Cycles=198105
Num_Mem_Cycles=80245
************************************************
MEMORY MAP
920,1,0,0,0,0,0,0
1,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0

************************************************
REMOTES MAP
0,0,0,0,0,0,0,0
1,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0

************************************************
Module: #_created, #_spawns, #_quits, #_migrates, #_rmos_in, #_rmos_out, mem_bw, IPC
NLET[0]: 1, 1, 2, 1, 1, 0, 0.0135086, 0.0652787
NLET[1]: 0, 0, 0, 1, 0, 1, 2.49237e-05, 0.00022082
NLET[2]: 0, 0, 0, 0, 0, 0, 0, 0
NLET[3]: 0, 0, 0, 0, 0, 0, 0, 0
NLET[4]: 0, 0, 0, 0, 0, 0, 0, 0
NLET[5]: 0, 0, 0, 0, 0, 0, 0, 0
NLET[6]: 0, 0, 0, 0, 0, 0, 0, 0
NLET[7]: 0, 0, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, #_to_nqms, #_to_sysic, p_zero, p_one, opt1, opt2, restored
ME[0].FromNQM[0]: 2, 0.00019979, 2, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[1]: 2, 0.000231335, 2, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[2]: 0, 0, 0, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[3]: 0, 0, 0, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[4]: 0, 0, 0, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[5]: 0, 0, 0, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[6]: 0, 0, 0, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[7]: 0, 0, 0, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, out_bw, passers_by, passers_stored
ME[0].FromSysIC[0]: 0, 0, 0, 0, 0
ME[0].FromSysIC[1]: 0, 0, 0, 0, 0
ME[0].FromSysIC[2]: 0, 0, 0, 0, 0
ME[0].FromSysIC[3]: 0, 0, 0, 0, 0
ME[0].FromSysIC[4]: 0, 0, 0, 0, 0
ME[0].FromSysIC[5]: 0, 0, 0, 0, 0

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToNQM[0]: 2, 0.000231335, 2.10349e-05, 1, 0, -nan, 2.10349e-05, 1
ME[0].ToNQM[1]: 2, 0.00019979, 2.10343e-05, 1, 0, -nan, 2.10343e-05, 1
ME[0].ToNQM[2]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToNQM[3]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToNQM[4]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToNQM[5]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToNQM[6]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToNQM[7]: 0, 0, 0, -nan, 0, -nan, 0, -nan

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToSysIC[0]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[1]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[2]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[3]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[4]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[5]: 0, 0, 0, -nan, 0, -nan, 0, -nan


************************************************
End of simulation: CurrentRSS (MB)=9.15625
End of simulation: PeakRSS (MB)=9.15625
************************************************
Simulator wall clock time (seconds): 2
