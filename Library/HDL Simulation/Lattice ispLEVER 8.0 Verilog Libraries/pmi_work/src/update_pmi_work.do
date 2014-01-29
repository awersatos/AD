#  File: update_pmi_work.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library pmi_work for Lattice
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file	

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw pmi_work
clearlibrary
cd $DSN
alog $OPT -v2k -work pmi_work $dsn\src\pmi_add.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_addsub.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_complex_mult.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_constant_mult.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_counter.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_distributed_dpram.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_distributed_rom.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_distributed_shift_reg.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_distributed_spram.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_dsp_casmultaddsub.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_dsp_mac.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_dsp_mult.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_dsp_multaddsub.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_dsp_multaddsubsum.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_fifo.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_fifo_dc.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_mac.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_mult.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_multaddsub.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_multaddsubsum.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_pll.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_pll_fp.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_ram_dp.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_ram_dp_true.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_ram_dq.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_rom.v
alog $OPT -v2k -work pmi_work $dsn\src\pmi_sub.v
alog $OPT -v2k -work pmi_work $dsn\src\jtaghub16.v
setlibrarymode -ro pmi_work




