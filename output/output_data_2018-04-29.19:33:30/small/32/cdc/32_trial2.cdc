Post Untimed portion: CurrentRSS (MB)=8.87109
Post Untimed portion: PeakRSS (MB)=9.12891
************************************************
Program Name/Arguments: 
../bin/bitonic_EMU_iterative.mwx 
../dataset//small/dataset32.dat 
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
Post SystemC Startup: CurrentRSS (MB)=9.12891
Post SystemC Startup: PeakRSS (MB)=9.12891
PROGRAM ENDED.
Emu system run time 0.00201 sec==2009465700 ps
System thread counts:
	active=0, created=130, died=130,
	max live=3 first occurred @342395757 ps with prog 17% complete
	and last occurred @342395757 ps with prog 84.7% complete
Num_Core_Cycles=602900
Num_SRIO_Cycles=1255916
Num_Mem_Cycles=508725
************************************************
MEMORY MAP
7813,26,36,0,52,0,16,0
20,12,6,16,0,12,0,0
4,16,16,26,0,0,12,0
36,0,0,12,6,0,0,12
16,12,0,0,24,26,20,0
20,0,12,0,0,10,6,16
4,0,0,12,0,16,16,26
54,0,0,0,0,0,0,12

************************************************
REMOTES MAP
0,0,0,0,0,0,0,0
10,0,0,0,0,0,0,0
4,0,0,0,0,0,0,0
0,12,8,0,0,0,0,0
6,0,0,0,0,0,0,0
0,4,0,0,12,0,0,0
0,0,5,0,10,0,0,0
0,0,0,5,0,5,9,0

************************************************
Module: #_created, #_spawns, #_quits, #_migrates, #_rmos_in, #_rmos_out, mem_bw, IPC
NLET[0]: 1, 105, 130, 130, 20, 0, 0.0234134, 0.0751153
NLET[1]: 0, 0, 0, 54, 16, 10, 0.000180844, 0.00121081
NLET[2]: 0, 4, 0, 58, 13, 4, 0.000171016, 0.00138995
NLET[3]: 0, 0, 0, 54, 5, 20, 0.000178879, 0.00152264
NLET[4]: 0, 16, 0, 74, 22, 6, 0.000216227, 0.00188754
NLET[5]: 0, 0, 0, 54, 5, 16, 0.000167084, 0.00149942
NLET[6]: 0, 4, 0, 58, 9, 15, 0.000184776, 0.00173827
NLET[7]: 0, 0, 0, 54, 0, 19, 0.000167084, 0.00163875

Module: #_in_xacts, in_bw, #_to_nqms, #_to_sysic, p_zero, p_one, opt1, opt2, restored
ME[0].FromNQM[0]: 150, 0.0039509, 150, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[1]: 80, 0.00177807, 80, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[2]: 75, 0.00186266, 75, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[3]: 79, 0.00180959, 79, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[4]: 102, 0.00242495, 102, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[5]: 75, 0.00178968, 75, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[6]: 82, 0.00191076, 82, 0, 0, 0, 0, 0, 0
ME[0].FromNQM[7]: 73, 0.00179632, 73, 0, 0, 0, 0, 0, 0

Module: #_in_xacts, in_bw, out_bw, passers_by, passers_stored
ME[0].FromSysIC[0]: 0, 0, 0, 0, 0
ME[0].FromSysIC[1]: 0, 0, 0, 0, 0
ME[0].FromSysIC[2]: 0, 0, 0, 0, 0
ME[0].FromSysIC[3]: 0, 0, 0, 0, 0
ME[0].FromSysIC[4]: 0, 0, 0, 0, 0
ME[0].FromSysIC[5]: 0, 0, 0, 0, 0

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToNQM[0]: 174, 0.00511196, 0.000290087, 1, 0, -nan, 0.000290087, 1
ME[0].ToNQM[1]: 80, 0.0017648, 0.000132926, 1, 0, -nan, 0.000132926, 1
ME[0].ToNQM[2]: 71, 0.00169348, 0.000117964, 1, 0, -nan, 0.000117964, 1
ME[0].ToNQM[3]: 79, 0.00172665, 0.00013126, 1, 0, -nan, 0.00013126, 1
ME[0].ToNQM[4]: 86, 0.00191408, 0.000142917, 1, 0, -nan, 0.000142917, 1
ME[0].ToNQM[5]: 75, 0.00172002, 0.000124613, 1, 0, -nan, 0.000124613, 1
ME[0].ToNQM[6]: 78, 0.00169182, 0.000129594, 1, 0, -nan, 0.000129594, 1
ME[0].ToNQM[7]: 73, 0.00170012, 0.000121287, 1, 0, -nan, 0.000121287, 1

Module: #_out_xacts, out_bw, avg_total_reqs, avg_total_reqs_exZero, avg_rio_reqs, avg_rio_reqs_exZero, avg_nqm_reqs, avg_nqm_reqs_exZero
ME[0].ToSysIC[0]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[1]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[2]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[3]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[4]: 0, 0, 0, -nan, 0, -nan, 0, -nan
ME[0].ToSysIC[5]: 0, 0, 0, -nan, 0, -nan, 0, -nan


************************************************
End of simulation: CurrentRSS (MB)=9.12891
End of simulation: PeakRSS (MB)=9.12891
************************************************
Simulator wall clock time (seconds): 12
