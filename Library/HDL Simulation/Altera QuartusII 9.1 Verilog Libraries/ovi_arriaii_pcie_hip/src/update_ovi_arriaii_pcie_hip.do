#  File: update_ovi_arriaii_pcie_hip.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library ovi_arriaii_pcie_hip for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_arriaii_pcie_hip 
clearlibrary	  
cd $dsn
alog -work ovi_arriaii_pcie_hip $OPT -f $dsn\src\ovi_arriaii_pcie_hip.opt
setlibrarymode -ro ovi_arriaii_pcie_hip
