#  file: update_ovi_hardcopyiv_pcie_hip.do
#    copyright (c) aldec inc.
#  file can be used to update library ovi_hardcopyiv_pcie_hip for Altera
#  to update the library, perform the following steps:
#    1. update existing library source files
#    2. execute this macro file

set OPT -O2
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw ovi_hardcopyiv_pcie_hip
clearlibrary
alog -work ovi_hardcopyiv_pcie_hip $OPT -f $dsn\src\ovi_hardcopyiv_pcie_hip.opt
setlibrarymode -ro ovi_hardcopyiv_pcie_hip
