#  File: update_arriaii_pcie_hip.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library arriaii_pcie_hip for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw arriaii_pcie_hip 
clearlibrary	  
cd $dsn
acom -work arriaii_pcie_hip $OPT -f $dsn\src\arriaii_pcie_hip.opt
setlibrarymode -ro arriaii_pcie_hip
