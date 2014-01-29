#  File: update_ovi_xilinxcorelib.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_xilinxcorelib for Xilinx 
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg
setlibrarymode -rw ovi_xilinxcorelib 
clearlibrary
cd $dsn 


alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/pci_exp_1_lane_64b_dsport.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/pci_exp_4_lane_64b_dsport.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLKMEMDP_V6_2.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLK_MEM_GEN_V3_1_xst.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLK_MEM_GEN_V3_1.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLK_MEM_GEN_V3_2_xst.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLK_MEM_GEN_V3_2.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_GATE_BIT_BUS_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_DECODE_BINARY_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_SHIFT_FD_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_COUNTER_BINARY_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_ACCUM_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_MUX_BIT_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_GATE_BIT_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_REG_LD_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/PIPELINE_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_MUX_SLICE_BUFE_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_REG_FD_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_COMPARE_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_TWOS_COMP_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_ADDSUB_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_SHIFT_RAM_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_MUX_BUS_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_GATE_BUS_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_ACCUM_V5_1.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_MUX_SLICE_BUFT_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLKMEMDP_V6_3.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLK_MEM_GEN_V3_3.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLK_MEM_GEN_V3_3_xst.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/FIFO_GENERATOR_V5_1_XST.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/FIFO_GENERATOR_V5_1.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/FIFO_GENERATOR_V5_2_XST.v
alog -v2k5 -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/FIFO_GENERATOR_V5_2.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_DIST_MEM_V5_0.v
alog -v2k5 -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/FIFO_GENERATOR_V5_3.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/FIFO_GENERATOR_V5_3_XST.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/DIST_MEM_GEN_V4_1_XST.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/DIST_MEM_GEN_V4_1.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLKMEMSP_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/DIST_MEM_GEN_V4_2_XST.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/DIST_MEM_GEN_V4_2.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/DIST_MEM_GEN_V4_3.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/DIST_MEM_GEN_V4_3_XST.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLK_MEM_GEN_V4_1_xst.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLK_MEM_GEN_V4_1.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/SYNC_FIFO_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_ADDSUB_V6_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_SHIFT_RAM_V6_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_MUX_BUS_V6_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_GATE_BUS_V6_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_MUX_SLICE_BUFT_V6_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_DECODE_BINARY_V6_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_GATE_BIT_BUS_V6_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_SHIFT_FD_V6_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_COUNTER_BINARY_V6_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_ACCUM_V6_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_MUX_BIT_V6_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_GATE_BIT_V6_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_REG_LD_V6_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/PIPELINE_V6_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_MUX_SLICE_BUFE_V6_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_COMPARE_V6_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_REG_FD_V6_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_TWOS_COMP_V6_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/FIFO_GENERATOR_V6_1_XST.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/FIFO_GENERATOR_V6_1.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_DIST_MEM_V6_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLKMEMDP_V4_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLKMEMSP_V6_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/MULT_GEN_V6_0_SEQ.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/MULT_GEN_V6_0_NON_SEQ.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/MULT_GEN_V6_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/DIST_MEM_GEN_V5_1_XST.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/DIST_MEM_GEN_V5_1.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLKMEMSP_V6_2.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/CAM_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/ASYNC_FIFO_V5_1.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/CAM_V5_1.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_COUNTER_BINARY_V7_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_ACCUM_V7_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_MUX_BIT_V7_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_GATE_BIT_V7_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_REG_LD_V7_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/PIPELINE_V7_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_MUX_SLICE_BUFE_V7_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_REG_FD_V7_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_COMPARE_V7_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_TWOS_COMP_V7_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_ADDSUB_V7_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_SHIFT_RAM_V7_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_MUX_BUS_V7_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_GATE_BUS_V7_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_MUX_SLICE_BUFT_V7_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_GATE_BIT_BUS_V7_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_DECODE_BINARY_V7_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_SHIFT_FD_V7_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/FIFO_GENERATOR_V3_3_XST.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/FIFO_GENERATOR_V3_3.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_DIST_MEM_V7_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_DIST_MEM_V7_1.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLKMEMDP_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/FAMILY.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/MULT_GEN_V7_0_SEQ.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/MULT_GEN_V7_0_NON_SEQ.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/MULT_GEN_V7_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLK_MEM_GEN_V2_1.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLK_MEM_GEN_V2_1_xst.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_ADDSUB_V4_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_SHIFT_RAM_V4_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_MUX_BUS_V4_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_GATE_BUS_V4_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_MUX_SLICE_BUFT_V4_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_DECODE_BINARY_V4_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_GATE_BIT_BUS_V4_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_SHIFT_FD_V4_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_COUNTER_BINARY_V4_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_ACCUM_V4_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_MUX_BIT_V4_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_GATE_BIT_V4_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_REG_LD_V4_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/PIPELINE_V4_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_MUX_SLICE_BUFE_V4_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_COMPARE_V4_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_REG_FD_V4_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_TWOS_COMP_V4_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLK_MEM_GEN_V2_2_xst.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLK_MEM_GEN_V2_2.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLK_MEM_GEN_V2_4.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLK_MEM_GEN_V2_4_xst.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLK_MEM_GEN_V2_5.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLK_MEM_GEN_V2_5_xst.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLK_MEM_GEN_V2_6_xst.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLK_MEM_GEN_V2_6.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/CAM_V6_1.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/FIFO_GENERATOR_V4_3_XST.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/FIFO_GENERATOR_V4_3.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLK_MEM_GEN_V2_7_xst.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLK_MEM_GEN_V2_7.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/FIFO_GENERATOR_V4_4.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/FIFO_GENERATOR_V4_4_XST.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/DIST_MEM_GEN_V3_1.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLKMEMSP_V4_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/DIST_MEM_GEN_V3_2.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/DIST_MEM_GEN_V3_3.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLKMEMDP_V6_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/DIST_MEM_GEN_V3_4.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/DIST_MEM_GEN_V3_4_XST.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/BLKMEMDP_V6_1.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_BIT_CORRELATOR_V3_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/TRIG_TABLE_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/PIPE_BHV_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_SIN_COS_V5_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/TRIG_TABLE_V5_1.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/PIPE_BHV_V5_1.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_SIN_COS_V5_1.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_DA_FIR_V9_0.v
alog -v2k -l ovi_unisim  -work ovi_xilinxcorelib $OPT $dsn/src/C_DA_FIR_V7_0.v 


setlibrarymode -ro ovi_xilinxcorelib 
